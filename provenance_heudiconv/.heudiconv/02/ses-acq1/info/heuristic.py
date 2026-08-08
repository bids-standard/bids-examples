import logging
import lzma
from simplejson import loads as json_loads
from os import environ

lgr = logging.getLogger(__name__)


# map the various guesses to the cannonical labels
modality_label_map = {
    't1': 'T1w',
    't1w': 'T1w',
    't2': 'T2w',
    't2w': 'T2w',
    't1rho': 'T1rho',
    't1map': 'T1map',
    't2map': 'T2map',
    't2star': 'T2star',
    'flair': 'FLAIR',
    'flash': 'FLASH',
    'pd': 'PD',
    'pdmap': 'PDmap',
    'pdt2': 'PDT2',
    'inplanet1': 'inplaneT1',
    'inplanet2': 'inplaneT2',
}

# map the cannonical modality labels to data_type labels
datatype_labels_map = {
    'bold': 'func',
    'sbref': 'func',

    'T1w': 'anat',
    'T2w': 'anat',
    'T1rho': 'anat',
    'T1map': 'anat',
    'T2map': 'anat',
    'T2star': 'anat',
    'FLAIR': 'anat',
    'FLASH': 'anat',
    'PD': 'anat',
    'PDmap': 'anat',
    'PDT2': 'anat',
    'inplaneT1': 'anat',
    'inplaneT2': 'anat',
    'angio': 'anat',

    'swi': 'swi',
    'dwi': 'dwi',

    'phasediff': 'fmap',
    'phase1': 'fmap',
    'phase2': 'fmap',
    'magnitude1': 'fmap',
    'magnitude2': 'fmap',
    'fieldmap': 'fmap',

    'epi': 'fmap',  # TODO?
}

# map specification keys to BIDS abbreviation used in paths
spec2bids_map = {
    'subject': "sub",
    'anon-subject': "sub",
    'bids-session': "ses",
    'bids-task': "task",
    'bids-run': "run",
    'bids-modality': "mod",
    'bids-acquisition': "acq",
    'bids-scan': "scan",
    'bids-contrast-enhancement': "ce",
    'bids-reconstruction-algorithm': "rec",
    'bids-echo': "echo",
    'bids-direction': "dir",

    # SWI Extension:
    'bids-part': "part",
    'bids-coil': "coil",

}


def get_specval(spec, key):
    return spec[key]['value']


def has_specval(spec, key):
    return key in spec and 'value' in spec[key] and spec[key]['value']


# Snippet from https://github.com/datalad/datalad to avoid depending on it for
# just one function:
def LZMAFile(*args, **kwargs):
    """A little decorator to overcome a bug in lzma

    A unique to yoh and some others bug with pyliblzma
    calling dir() helps to avoid AttributeError __exit__
    see https://bugs.launchpad.net/pyliblzma/+bug/1219296
    """
    lzmafile = lzma.LZMAFile(*args, **kwargs)
    dir(lzmafile)
    return lzmafile


def loads(s, *args, **kwargs):
    """Helper to log actual value which failed to be parsed"""
    try:
        return json_loads(s, *args, **kwargs)
    except:
        lgr.error(
            "Failed to load content from %r with args=%r kwargs=%r"
            % (s, args, kwargs)
        )
        raise


def load_stream(fname, compressed=False):

    _open = LZMAFile if compressed else open
    with _open(fname, mode='r') as f:
        for line in f:
            yield loads(line)

# END datalad Snippet


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')

    return template, outtype, annotation_classes


class SpecLoader(object):
    """
    Persistent object to hold the study specification and not read the JSON on
    each invocation of `infotodict`. Module level attribute for the spec itself
    doesn't work, since the env variable isn't necessarily available at first
    import.
    """

    def __init__(self):
        self._spec = None
        # get chosen subject id (orig or anon) from env var
        self.subject = environ.get('HIRNI_SPEC2BIDS_SUBJECT')

    def get_study_spec(self):
        if self._spec is None:
            filename = environ.get('HIRNI_STUDY_SPEC')
            if filename:
                self._spec = [d for d in load_stream(filename)
                              if d['type'] == 'dicomseries']
            else:
                # TODO: Just raise or try a default location first?
                raise ValueError("No study specification provided. "
                                 "Set environment variable HIRNI_STUDY_SPEC "
                                 "to do so.")
        return self._spec


_spec = SpecLoader()


def validate_spec(spec):

    if not spec:
        raise ValueError("Image series specification is empty.")

    tags = spec.get('tags', None)
    if tags and 'hirni-dicom-converter-ignore' in tags:
        lgr.debug("Skip series %s (marked 'ignore' in spec)", spec['uid'])
        return False

    # mandatory keys for any spec dict (not only dicomseries)
    for k in spec.keys():
        # automatically managed keys with no subdict:
        # TODO: Where to define this list?
        # TODO: Test whether those are actually present!
        if k in ['type', 'location', 'uid', 'dataset-id',
                 'dataset-refcommit', 'procedures', 'tags']:
            continue
        if 'value' not in spec[k]:
            lgr.warning("DICOM series specification (UID: {uid}) has no value "
                        "for key '{key}'.".format(uid=spec['uid'], key=k))
            return False

    if spec['type'] != 'dicomseries':
        lgr.warning("Specification not of type 'dicomseries'.")
        return False

    if 'uid' not in spec.keys() or not spec['uid']:
        lgr.warning("Missing image series UID.")
        return False

    for var in ('bids-modality',):
        if not has_specval(spec, var):
            lgr.warning("Missing specification value for key '%s'", var)
            return False

    return True


# TODO: can be removed, whenever nipy/heudiconv #197 is solved
def infotoids(seqinfos, outdir):
    return {'locator': None,
            'session': None,
            'subject': None}


def infotodict(seqinfo):  # pragma: no cover
    """Heuristic evaluator for determining which runs belong where

    allowed template fields - follow python string module:

    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """

    info = dict()
    for idx, s in enumerate(seqinfo):

        # find in spec:
        candidates = [series for series in _spec.get_study_spec()
                      if str(s.series_uid) == series['uid']]
        if not candidates:
            raise ValueError("Found no match for seqinfo: %s" % str(s))
        if len(candidates) != 1:
            raise ValueError("Found %s match(es) for series UID %s" %
                             (len(candidates), s.uid))
        series_spec = candidates[0]

        if not validate_spec(series_spec):
            lgr.debug("Series invalid (%s). Skip.", str(s.series_uid))
            continue

        dirname = filename = "sub-{}".format(_spec.subject)
        # session
        if has_specval(series_spec, 'bids-session'):
            ses = get_specval(series_spec, 'bids-session')
            dirname += "/ses-{}".format(ses)
            filename += "_ses-{}".format(ses)

        # data type
        modality = get_specval(series_spec, 'bids-modality')
        # make cannonical if possible
        modality = modality_label_map.get(modality, modality)
        # apply fixed mapping from modality -> data_type
        data_type = datatype_labels_map[modality]

        dirname += "/{}".format(data_type)

        # TODO: Once special cases (like when to use '_mod-' prefix for modality
        # are clear, integrate data type selection with spec_key list and
        # thereby reduce code duplication further

        if data_type == 'func':
            # func/sub-<participant_label>[_ses-<session_label>]
            # _task-<task_label>[_acq-<label>][_rec-<label>][_run-<index>][_echo-<index>]_<modality_label>.nii[.gz]

            for spec_key in ['bids-task', 'bids-acquisition',
                             'bids-reconstruction_algorithm', 'bids-run',
                             'bids-echo']:
                if has_specval(series_spec, spec_key):
                    filename += "_{}-{}".format(
                            spec2bids_map[spec_key],
                            get_specval(series_spec, spec_key))

            filename += "_{}".format(modality)

        if data_type == 'anat':
            # anat/sub-<participant_label>[_ses-<session_label>]
            # [_acq-<label>][_ce-<label>][_rec-<label>][_run-<index>][_mod-<label>]_<modality_label>.nii[.gz]

            for spec_key in ['bids-acquisition',
                             'bids-contrast_enhancement',
                             'bids-reconstruction_algorithm',
                             'bids-run']:
                if has_specval(series_spec, spec_key):
                    filename += "_{}-{}".format(
                            spec2bids_map[spec_key],
                            get_specval(series_spec, spec_key))

            # TODO: [_mod-<label>]  (modality if defaced, right?)
            #       => simple bool 'defaced' in spec or is there more to it?

            filename += "_{}".format(modality)

        if data_type == 'dwi':
            # dwi/sub-<participant_label>[_ses-<session_label>]
            # [_acq-<label>][_run-<index>]_dwi.nii[.gz]

            for spec_key in ['bids-acquisition',
                             'bids-run']:
                if has_specval(series_spec, spec_key):
                    filename += "_{}-{}".format(
                            spec2bids_map[spec_key],
                            get_specval(series_spec, spec_key))

            # TODO: Double check: Is this always correct?
            filename += "_dwi"

        if data_type == 'swi':
            # BIDS-Extension:
            # https://docs.google.com/document/d/1kyw9mGgacNqeMbp4xZet3RnDhcMmf4_BmRgKaOkO2Sc
            # swi/sub-<participant_label>[_ses-<session_label>]
            #       [_acq-<label>][_rec-<label>]_part-<phase|mag>[_coil-<index>][_echo-<index>][_run-<index>]_GRE.nii[.gz]

            for spec_key in ['bids-acquisition',
                             'bids-reconstruction_algorithm',
                             'bids-part',
                             'bids-coil',
                             'bids-echo',
                             'bids-run',
                             ]:
                if has_specval(series_spec, spec_key):
                    filename += "_{}-{}".format(
                            spec2bids_map[spec_key],
                            get_specval(series_spec, spec_key))

            filename += "_GRE"

        if data_type == 'fmap':
            # Case 1: Phase difference image and at least one magnitude image
            # sub-<participant_label>/[ses-<session_label>/]
            # [_acq-<label>][_dir-<dir_label>][_run-<run_index>]_<modality_label>.nii[.gz]

            # Note/TODO: fmap modalities:
            # _phasediff
            # _magnitude1
            # _magnitude2
            # _phase1
            # _phase2
            # _magnitude
            # _fieldmap
            # _epi

            for spec_key in ['bids-acquisition',
                             'bids-direction',
                             'bids-run']:
                if has_specval(series_spec, spec_key):
                    filename += "_{}-{}".format(
                            spec2bids_map[spec_key],
                            get_specval(series_spec, spec_key))

            filename += "_{}".format(modality)

        key = create_key(dirname + '/' + filename)
        if key not in info:
            info[key] = []

        info[key].append(s[2])

    return info

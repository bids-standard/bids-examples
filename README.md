[![GitHub Actions](https://github.com/bids-standard/bids-examples/workflows/validate_datasets/badge.svg)](https://github.com/bids-standard/bids-examples/actions)
![GitHub repo size](https://img.shields.io/github/repo-size/bids-standard/bids-examples)


The content of this repository can also be viewed here:

**https://bids-standard.github.io/bids-examples/**

# bids-examples

This repository contains a set of
[BIDS-compatible](https://bids.neuroimaging.io/) datasets with **empty raw data
files**. These datasets can be useful to:

1. write lightweight software tests
1. serve as an example on how a BIDS dataset can be structured

**ALL RAW DATA FILES IN THIS REPOSITORY ARE EMPTY!**

However for some of the data, the headers containing the metadata are still
intact. (For example the NIfTI headers for `.nii` files, the BrainVision data
headers for `.vhdr` files, or the OME-XML headers for `.ome.tif` files.)

Headers are intact for the following datasets:

- `synthetic`
- Most EEG or iEEG data in BrainVision format (e.g., `eeg_matchingpennies`)

## Validating BIDS examples

The next three sections mention a few details on how the `bids-examples` can be
validated using `bids-validator`.

For general information on the `bids-validator`, including installation and
usage, see the
[bids-validator README file](https://github.com/bids-standard/bids-validator#quickstart).

### Validating individual examples

Since all raw data files in this repository are empty, the `bids-validator` must
to be configured to not report empty data files as errors. (See more on
bids-validator configuration in the
[bids-validator README](https://github.com/bids-standard/bids-validator#configuration).)

Just run the validator as follows (using the `eeg_matchingpennies` dataset as an
example, and assuming you are in a command line at the root of the
`bids-examples` repository):

`bids-validator eeg_matchingpennies --config.ignore=99`

The `--config.ignore=99` "flag" tells the bids-validator to ignore empty data
files rather than to report the "empty file" error .

For datasets that contain NIfTI `.nii` files, you also need to add the
`ignoreNiftiHeaders` flag to the `bids-validator` call, to suppress the issue
that NIfTI headers are not found.

For example:

`bids-validator ds003 --config.ignore=99 --ignoreNiftiHeaders`

### Validating all examples

If you want to validate all examples in one go, you can use the `run_tests.sh`
script that is provided in this repository. This script makes use of the
`bidsconfig.json` configuration file for the `bids-validator`, and appropriately
handles some special case examples (see
[Validator Exceptions](#validator-exceptions)).

Simply run `./run_tests.sh` in a command line from the root of the
`bids-examples` repository.

### Validator exceptions

Some datasets may include a custom `.bids-validator-config.json` to ignore
errors generated from idiosyncrasies of the datasets as they existed on
creation.

| name          | errors ignored                                                                                                                 |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| genetics_ukbb | SliceTiming values for tasks is larger than given TR, EchoTime1 and EchoTime2 are not provided for any of the phasediff files. |

Other datasets may include a `.SKIP_VALIDATION` file, to skip the validation
with the continuous integration service. This is useful for datasets that
_cannot_ pass at the moment due to lack of coverage in the
[bids-validator](https://github.com/bids-standard/bids-validator).

Note however, that the `.SKIP_VALIDATION` file only impacts the continuous
integration service, or validation when run with the `run_tests.sh` script (see
[Validating all examples](#validating-all-examples)). This file does **not**
have any effect when running `bids-validator` from custom scripts, the web-based
validator, docker, or from the command line.

| name              | why skipped                                            |
| ----------------- | ------------------------------------------------------ |
| ds000001-fmriprep | lack of coverage for "derivatives" in `bids-validator` |

## Contributing

We are happy to receive contributions in the form of:

- updates to existing examples, or the [dataset index](#dataset-index)
- new examples
  - only if they cover aspects that are currently not covered by existing
    examples
  - only if a maintainer can be found for this dataset
- suggestions on how to improve the bids-examples repository

For more information, please see our
[CONTRIBUTING.md](./CONTRIBUTING.md)
file or open a
[new GitHub Issue](https://github.com/bids-standard/bids-examples/issues/new)
and ask us directly.

## Dataset index
<!-- ADD EXAMPLE LISTING HERE -->
<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->


### ASL

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                  | description                                                                                   | datatypes        | suffixes                                  | link to full data             | maintained by                            |
|:--------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------|:-----------------|:------------------------------------------|:------------------------------|:-----------------------------------------|
| [2d_mb_pcasl](https://github.com/bids-standard/bids-examples/tree/master/2d_mb_pcasl) | Siemens 2D MultiBand Multi-delay PCASL (m0 and noRF included within timeseries)               | anat, fmap, perf | T1w, asl, aslcontext, epi                 | [link](https://osf.io/xrkc4/) | [@aptinis](https://github.com/aptinis)   |
| [asl001](https://github.com/bids-standard/bids-examples/tree/master/asl001)           | T1w, asl (GE, PCASL, 3D_SPIRAL), m0scan within timeseries                                     | anat, perf       | T1w, asl, aslcontext, asllabeling         | [link](https://osf.io/yru2q/) | [@patsycle](https://github.com/patsycle) |
| [asl002](https://github.com/bids-standard/bids-examples/tree/master/asl002)           | T1w, asl (Philips, PCASL, 2D_EPI), m0scan as separate scan                                    | anat, perf       | T1w, asl, aslcontext, asllabeling, m0scan | [link](https://osf.io/yru2q/) | [@patsycle](https://github.com/patsycle) |
| [asl003](https://github.com/bids-standard/bids-examples/tree/master/asl003)           | T1w, asl (Siemens, PASL, multiTI), M0scan as separate scan                                    | anat, perf       | T1w, asl, aslcontext, asllabeling, m0scan | [link](https://osf.io/yru2q/) | [@patsycle](https://github.com/patsycle) |
| [asl004](https://github.com/bids-standard/bids-examples/tree/master/asl004)           | T1w, asl (Siemens, PCASL, multiPLD with pepolar), m0scan separate scans with pepolar approach | anat, fmap, perf | T1w, asl, aslcontext, asllabeling, m0scan | [link](https://osf.io/yru2q/) | [@patsycle](https://github.com/patsycle) |
| [asl005](https://github.com/bids-standard/bids-examples/tree/master/asl005)           | T1w, asl (Siemens, PCASL, singleTI, 3D_GRASE), m0scan as separate scan                        | anat, perf       | T1w, asl, aslcontext, asllabeling, m0scan | [link](https://osf.io/yru2q/) | [@patsycle](https://github.com/patsycle) |

### Behavioral

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                        | description                                                                                 | datatypes                       | suffixes                                                                                                       | link to full data                                | maintained by                              |
|:------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------|:--------------------------------|:---------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|:-------------------------------------------|
| [ds000117](https://github.com/bids-standard/bids-examples/tree/master/ds000117)                             | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task | anat, beh, dwi, fmap, func, meg | FLASH, T1w, bold, channels, coordsystem, dwi, events, headshape, magnitude1, magnitude2, meg, phasediff, scans | [link](https://openneuro.org/datasets/ds000117/) | [@RikHenson](https://github.com/RikHenson) |
| [eeg_ds003645s_hed_demo](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_demo) | Shows usage of Hierarchical Event Descriptor (HED) in .tsv files                            | anat, beh, eeg, micr, motion    | KSSSleep, SPIM, beh, channels, coordsystem, defacemask, eeg, electrodes, events, motion, photo, samples, scans | [link](https://openneuro.org/datasets/ds003645)  | [@VisLab](https://github.com/VisLab)       |
| [synthetic](https://github.com/bids-standard/bids-examples/tree/master/synthetic)                           | A synthetic dataset                                                                         | anat, beh, func                 | T1w, beh, bold, events, physio, scans, sessions, stim                                                          | n/a                                              | [@effigies](https://github.com/effigies)   |

### EEG

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                              | description                                                                                                        | datatypes   | suffixes                                       | link to full data                               | maintained by                                  |
|:------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------|:------------|:-----------------------------------------------|:------------------------------------------------|:-----------------------------------------------|
| [eeg_cbm](https://github.com/bids-standard/bids-examples/tree/master/eeg_cbm)                                     | Rest EEG. European Data Format (.edf)                                                                              | eeg         | channels, eeg, events, scans                   | n/a                                             | [@cpernet](https://github.com/cpernet)         |
| [eeg_ds003645s_hed_library](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_library) | HED annotation using HED library vocabularies (schema).                                                            | eeg         | channels, eeg, events                          | [link](https://openneuro.org/datasets/ds003645) | [@VisLab](https://github.com/VisLab)           |
| [eeg_face13](https://github.com/bids-standard/bids-examples/tree/master/eeg_face13)                               | Deconstructing the early visual electrocortical response to face and house stimuli. EDF format                     | eeg         | channels, coordsystem, eeg, electrodes, events | n/a                                             | [@andesha](https://github.com/andesha)         |
| [eeg_matchingpennies](https://github.com/bids-standard/bids-examples/tree/master/eeg_matchingpennies)             | Offline data of BCI experiment decoding left vs. right hand movement. BrainVision data format (.eeg, .vhdr, .vmrk) | eeg         | channels, eeg, events                          | [link](https://doi.org/10.17605/OSF.IO/CJ2DR)   | [@sappelhoff](https://github.com/sappelhoff)   |
| [eeg_rishikesh](https://github.com/bids-standard/bids-examples/tree/master/eeg_rishikesh)                         | Mind wandering experiment. EEG data in Biosemi (.bdf) format                                                       | eeg         | channels, eeg, events                          | [link](https://openneuro.org/datasets/ds001787) | [@arnodelorme](https://github.com/arnodelorme) |

### DWI

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                      | description                                                                                          | datatypes                       | suffixes                                                                                                       | link to full data                                              | maintained by                              |
|:------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------|:--------------------------------|:---------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------|:-------------------------------------------|
| [ds000117](https://github.com/bids-standard/bids-examples/tree/master/ds000117)           | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task          | anat, beh, dwi, fmap, func, meg | FLASH, T1w, bold, channels, coordsystem, dwi, events, headshape, magnitude1, magnitude2, meg, phasediff, scans | [link](https://openneuro.org/datasets/ds000117/)               | [@RikHenson](https://github.com/RikHenson) |
| [ds114](https://github.com/bids-standard/bids-examples/tree/master/ds114)                 | multiple tasks, multiple runs                                                                        | anat, dwi, func                 | T1w, bold, dwi, events                                                                                         | [link](https://openneuro.org/datasets/ds000114/versions/1.0.1) | n/a                                        |
| [dwi_deriv](https://github.com/bids-standard/bids-examples/tree/master/dwi_deriv)         | exemplifies the storage of diffusion MRI derivates that may be generated on the Siemens XA platform. | dwi                             | dwi                                                                                                            | n/a                                                            | n/a                                        |
| [eeg_rest_fmri](https://github.com/bids-standard/bids-examples/tree/master/eeg_rest_fmri) | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk)                   | anat, dwi, eeg, func            | T1w, bold, dwi, eeg                                                                                            | n/a                                                            | [@cpernet](https://github.com/cpernet)     |
| [genetics_ukbb](https://github.com/bids-standard/bids-examples/tree/master/genetics_ukbb) | multiple tasks, T1w, DTI, BOLD, genetic info                                                         | anat, dwi, func                 | FLAIR, T1w, bold, dwi, events, info                                                                            | n/a                                                            | [@cpernet](https://github.com/cpernet)     |

### iEEG

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                        | description                                                                                                    | datatypes              | suffixes                                                               | link to full data                                                           | maintained by                                |
|:------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------|:-----------------------|:-----------------------------------------------------------------------|:----------------------------------------------------------------------------|:---------------------------------------------|
| [ieeg_epilepsyNWB](https://github.com/bids-standard/bids-examples/tree/master/ieeg_epilepsyNWB)             | multiple sessions, tutorial — derivative dataset of `ieeg_epilepsy` showcasing the NWB file format alternative | anat, ieeg             | T1w, channels, coordsystem, electrodes, events, ieeg, scans            | [link](https://neuroimage.usc.edu/bst/getupdate.php?s=tutorial_epimap_bids) | [@TheChymera](https://github.com/TheChymera) |
| [ieeg_epilepsy](https://github.com/bids-standard/bids-examples/tree/master/ieeg_epilepsy)                   | multiple sessions, tutorial                                                                                    | anat, ieeg             | T1w, channels, coordsystem, electrodes, events, ieeg, scans            | [link](https://neuroimage.usc.edu/bst/getupdate.php?s=tutorial_epimap_bids) | [@ftadel](https://github.com/ftadel)         |
| [ieeg_epilepsy_ecog](https://github.com/bids-standard/bids-examples/tree/master/ieeg_epilepsy_ecog)         | multiple sessions, tutorial                                                                                    | anat, ieeg             | T1w, channels, coordsystem, electrodes, events, ieeg, photo, scans     | [link](https://neuroimage.usc.edu/bst/getupdate.php?s=sample_ecog)          | [@ftadel](https://github.com/ftadel)         |
| [ieeg_filtered_speech](https://github.com/bids-standard/bids-examples/tree/master/ieeg_filtered_speech)     | recordings of three seizures                                                                                   | ieeg                   | channels, coordsystem, electrodes, events, ieeg, photo                 | n/a                                                                         | [@choldgraf](https://github.com/choldgraf)   |
| [ieeg_motorMiller2007](https://github.com/bids-standard/bids-examples/tree/master/ieeg_motorMiller2007)     | Cue-based hand & tongue movement data                                                                          | ieeg                   | channels, coordsystem, electrodes, events, ieeg                        | n/a                                                                         | [@dorahermes](https://github.com/dorahermes) |
| [ieeg_visual](https://github.com/bids-standard/bids-examples/tree/master/ieeg_visual)                       | Stimulus dependence of gamma oscillations in human visual cortex                                               | anat, ieeg             | T1w, channels, coordsystem, electrodes, events, ieeg                   | n/a                                                                         | [@dorahermes](https://github.com/dorahermes) |
| [ieeg_visual_multimodal](https://github.com/bids-standard/bids-examples/tree/master/ieeg_visual_multimodal) | n/a                                                                                                            | anat, fmap, func, ieeg | T1w, bold, channels, coordsystem, electrodes, epi, events, ieeg, sbref | n/a                                                                         | [@irisgroen](https://github.com/irisgroen)   |
| [xeeg_hed_score](https://github.com/bids-standard/bids-examples/tree/master/xeeg_hed_score)                 | EEG and iEEG data with annotations of artifacts, seizures and modulators using HED-SCORE                       | anat, eeg, ieeg        | T1w, channels, coordsystem, eeg, electrodes, events, ieeg              | n/a                                                                         | [@dorahermes](https://github.com/dorahermes) |

### HED

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                              | description                                                                              | datatypes                    | suffixes                                                                                                       | link to full data                               | maintained by                                |
|:------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------|:-----------------------------|:---------------------------------------------------------------------------------------------------------------|:------------------------------------------------|:---------------------------------------------|
| [eeg_ds003645s_hed_demo](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_demo)       | Shows usage of Hierarchical Event Descriptor (HED) in .tsv files                         | anat, beh, eeg, micr, motion | KSSSleep, SPIM, beh, channels, coordsystem, defacemask, eeg, electrodes, events, motion, photo, samples, scans | [link](https://openneuro.org/datasets/ds003645) | [@VisLab](https://github.com/VisLab)         |
| [eeg_ds003645s_hed_library](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_library) | HED annotation using HED library vocabularies (schema).                                  | eeg                          | channels, eeg, events                                                                                          | [link](https://openneuro.org/datasets/ds003645) | [@VisLab](https://github.com/VisLab)         |
| [xeeg_hed_score](https://github.com/bids-standard/bids-examples/tree/master/xeeg_hed_score)                       | EEG and iEEG data with annotations of artifacts, seizures and modulators using HED-SCORE | anat, eeg, ieeg              | T1w, channels, coordsystem, eeg, electrodes, events, ieeg                                                      | n/a                                             | [@dorahermes](https://github.com/dorahermes) |

### MEG

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                            | description                                                                                                          | datatypes                       | suffixes                                                                                                       | link to full data                                              | maintained by                              |
|:--------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------|:--------------------------------|:---------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------|:-------------------------------------------|
| [ds000117](https://github.com/bids-standard/bids-examples/tree/master/ds000117) | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task                          | anat, beh, dwi, fmap, func, meg | FLASH, T1w, bold, channels, coordsystem, dwi, events, headshape, magnitude1, magnitude2, meg, phasediff, scans | [link](https://openneuro.org/datasets/ds000117/)               | [@RikHenson](https://github.com/RikHenson) |
| [ds000246](https://github.com/bids-standard/bids-examples/tree/master/ds000246) | Auditory dataset used for Brainstorm’s general online tutorial                                                       | anat, meg                       | T1w, channels, coordsystem, headshape, meg, photo, scans                                                       | [link](https://openneuro.org/datasets/ds000246/versions/00001) | [@guiomar](https://github.com/guiomar)     |
| [ds000247](https://github.com/bids-standard/bids-examples/tree/master/ds000247) | Five minutes, eyes-open, resting-state MEG data from 5 subjects. This is a sample from The Open MEG Archive (OMEGA). | anat, meg                       | T1w, channels, coordsystem, headshape, meg, scans                                                              | [link](https://openneuro.org/datasets/ds000247/versions/00001) | [@guiomar](https://github.com/guiomar)     |
| [ds000248](https://github.com/bids-standard/bids-examples/tree/master/ds000248) | MNE sample data: Data with visual and auditory stimuli                                                               | anat, meg                       | FLASH, T1w, channels, coordsystem, events, meg, scans                                                          | [link](https://openneuro.org/datasets/ds000248/versions/00001) | [@agramfort](https://github.com/agramfort) |

### Microscopy

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                        | description                                                                                     | datatypes                    | suffixes                                                                                                       | link to full data                                            | maintained by                                |
|:------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------|:-----------------------------|:---------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------|:---------------------------------------------|
| [eeg_ds003645s_hed_demo](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_demo) | Shows usage of Hierarchical Event Descriptor (HED) in .tsv files                                | anat, beh, eeg, micr, motion | KSSSleep, SPIM, beh, channels, coordsystem, defacemask, eeg, electrodes, events, motion, photo, samples, scans | [link](https://openneuro.org/datasets/ds003645)              | [@VisLab](https://github.com/VisLab)         |
| [micr_SEM](https://github.com/bids-standard/bids-examples/tree/master/micr_SEM)                             | Example SEM dataset in PNG format with 1 sample imaged over 2 sessions                          | micr                         | SEM, photo, samples, sessions                                                                                  | [link](https://doi.org/10.5281/zenodo.5498378)               | [@jcohenadad](https://github.com/jcohenadad) |
| [micr_SEMzarr](https://github.com/bids-standard/bids-examples/tree/master/micr_SEMzarr)                     | Example SEM dataset in PNG and OME-ZARR format with 1 sample imaged over 2 sessions             | micr                         | SEM, SPIM, samples, sessions                                                                                   | n/a                                                          | [@TheChymera](https://github.com/TheChymera) |
| [micr_SPIM](https://github.com/bids-standard/bids-examples/tree/master/micr_SPIM)                           | Example SPIM dataset in OME-TIFF format with 2 samples from the same subject with 4 chunks each | micr                         | SPIM, photo, samples                                                                                           | [link](https://doi.org/10.5281/zenodo.5517223)               | [@jcohenadad](https://github.com/jcohenadad) |
| [micr_XPCTzarr](https://github.com/bids-standard/bids-examples/tree/master/micr_XPCTzarr)                   | Example XPCT dataset in OME-ZARR format with 1 sample imaged                                    | micr                         | XPCT, photo, samples, sessions                                                                                 | [link](https://human-organ-atlas.esrf.eu/datasets/572252538) | [@chourroutm](https://github.com/chourroutm) |

### Motion

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                          | description                                                                                               | datatypes                    | suffixes                                                                                                       | link to full data                                       | maintained by                                    |
|:--------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------|:-----------------------------|:---------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------|:-------------------------------------------------|
| [eeg_ds003645s_hed_demo](https://github.com/bids-standard/bids-examples/tree/master/eeg_ds003645s_hed_demo)   | Shows usage of Hierarchical Event Descriptor (HED) in .tsv files                                          | anat, beh, eeg, micr, motion | KSSSleep, SPIM, beh, channels, coordsystem, defacemask, eeg, electrodes, events, motion, photo, samples, scans | [link](https://openneuro.org/datasets/ds003645)         | [@VisLab](https://github.com/VisLab)             |
| [motion_dualtask](https://github.com/bids-standard/bids-examples/tree/master/motion_dualtask)                 | older and younger participants walking while performing discrimination task                               | eeg, motion                  | channels, eeg, events, motion, scans                                                                           | n/a                                                     | [@sjeung](https://github.com/sjeung)             |
| [motion_spotrotation](https://github.com/bids-standard/bids-examples/tree/master/motion_spotrotation)         | participants rotated heading using full-body motion or joystick                                           | eeg, motion                  | channels, coordsystem, eeg, electrodes, events, motion, scans                                                  | [link](https://openneuro.org/datasets/ds004460)         | [@sjeung](https://github.com/sjeung)             |
| [motion_systemvalidation](https://github.com/bids-standard/bids-examples/tree/master/motion_systemvalidation) | Example dataset of two different motion captured system recorded almost simultaneously, but no brain data | motion                       | channels, motion, scans                                                                                        | [link](https://doi.org/10.6084/m9.figshare.20238006.v2) | [@JuliusWelzel](https://github.com/JuliusWelzel) |

### MRI

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                        | description                                                                                 | datatypes                       | suffixes                                                                                                       | link to full data                                              | maintained by                              |
|:------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------|:--------------------------------|:---------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------|:-------------------------------------------|
| [7t_trt](https://github.com/bids-standard/bids-examples/tree/master/7t_trt)                                 | n/a                                                                                         | anat, fmap, func                | T1map, T1w, bold, magnitude1, magnitude2, phasediff, physio, scans, sessions                                   | [link](https://bit.ly/2H0Z6Qt)                                 | n/a                                        |
| [ds000117](https://github.com/bids-standard/bids-examples/tree/master/ds000117)                             | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task | anat, beh, dwi, fmap, func, meg | FLASH, T1w, bold, channels, coordsystem, dwi, events, headshape, magnitude1, magnitude2, meg, phasediff, scans | [link](https://openneuro.org/datasets/ds000117/)               | [@RikHenson](https://github.com/RikHenson) |
| [ds001](https://github.com/bids-standard/bids-examples/tree/master/ds001)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000001/versions/00006) | n/a                                        |
| [ds002](https://github.com/bids-standard/bids-examples/tree/master/ds002)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000002/versions/00002) | n/a                                        |
| [ds003](https://github.com/bids-standard/bids-examples/tree/master/ds003)                                   | single task, single run                                                                     | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000003/versions/00001) | n/a                                        |
| [ds005](https://github.com/bids-standard/bids-examples/tree/master/ds005)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000005/versions/00001) | n/a                                        |
| [ds006](https://github.com/bids-standard/bids-examples/tree/master/ds006)                                   | single task, multiple sessions, multiple runs                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000006/versions/00001) | n/a                                        |
| [ds007](https://github.com/bids-standard/bids-examples/tree/master/ds007)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000007/versions/00001) | n/a                                        |
| [ds008](https://github.com/bids-standard/bids-examples/tree/master/ds008)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000008/versions/00001) | n/a                                        |
| [ds009](https://github.com/bids-standard/bids-examples/tree/master/ds009)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2, scans                                                                            | [link](https://openneuro.org/datasets/ds000009/versions/00002) | n/a                                        |
| [ds011](https://github.com/bids-standard/bids-examples/tree/master/ds011)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000011/versions/00001) | n/a                                        |
| [ds051](https://github.com/bids-standard/bids-examples/tree/master/ds051)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000051/versions/00001) | n/a                                        |
| [ds052](https://github.com/bids-standard/bids-examples/tree/master/ds052)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000052/versions/00001) | n/a                                        |
| [ds101](https://github.com/bids-standard/bids-examples/tree/master/ds101)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000101/versions/00004) | n/a                                        |
| [ds102](https://github.com/bids-standard/bids-examples/tree/master/ds102)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000102/versions/00001) | n/a                                        |
| [ds105](https://github.com/bids-standard/bids-examples/tree/master/ds105)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000105/versions/00001) | n/a                                        |
| [ds107](https://github.com/bids-standard/bids-examples/tree/master/ds107)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000107/versions/00001) | n/a                                        |
| [ds108](https://github.com/bids-standard/bids-examples/tree/master/ds108)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000108/versions/00002) | n/a                                        |
| [ds109](https://github.com/bids-standard/bids-examples/tree/master/ds109)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events                                                                                              | [link](https://openneuro.org/datasets/ds000109/versions/00001) | n/a                                        |
| [ds110](https://github.com/bids-standard/bids-examples/tree/master/ds110)                                   | single task, multiple runs                                                                  | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000110/versions/00001) | n/a                                        |
| [ds113b](https://github.com/bids-standard/bids-examples/tree/master/ds113b)                                 | forrest gump watching, multiple sessions, multiple runs                                     | func                            | bold, events                                                                                                   | [link](https://openneuro.org/datasets/ds000113/versions/1.3.0) | n/a                                        |
| [ds114](https://github.com/bids-standard/bids-examples/tree/master/ds114)                                   | multiple tasks, multiple runs                                                               | anat, dwi, func                 | T1w, bold, dwi, events                                                                                         | [link](https://openneuro.org/datasets/ds000114/versions/1.0.1) | n/a                                        |
| [ds116](https://github.com/bids-standard/bids-examples/tree/master/ds116)                                   | multiple tasks, multiple runs                                                               | anat, func                      | T1w, bold, events, inplaneT2                                                                                   | [link](https://openneuro.org/datasets/ds000116/versions/00003) | n/a                                        |
| [ds210](https://github.com/bids-standard/bids-examples/tree/master/ds210)                                   | multiple tasks, multiple runs                                                               | func                            | bold, physio                                                                                                   | [link](https://openneuro.org/datasets/ds000210/versions/00002) | n/a                                        |
| [eeg_rest_fmri](https://github.com/bids-standard/bids-examples/tree/master/eeg_rest_fmri)                   | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk)          | anat, dwi, eeg, func            | T1w, bold, dwi, eeg                                                                                            | n/a                                                            | [@cpernet](https://github.com/cpernet)     |
| [genetics_ukbb](https://github.com/bids-standard/bids-examples/tree/master/genetics_ukbb)                   | multiple tasks, T1w, DTI, BOLD, genetic info                                                | anat, dwi, func                 | FLAIR, T1w, bold, dwi, events, info                                                                            | n/a                                                            | [@cpernet](https://github.com/cpernet)     |
| [ieeg_visual_multimodal](https://github.com/bids-standard/bids-examples/tree/master/ieeg_visual_multimodal) | n/a                                                                                         | anat, fmap, func, ieeg          | T1w, bold, channels, coordsystem, electrodes, epi, events, ieeg, sbref                                         | n/a                                                            | [@irisgroen](https://github.com/irisgroen) |
| [synthetic](https://github.com/bids-standard/bids-examples/tree/master/synthetic)                           | A synthetic dataset                                                                         | anat, beh, func                 | T1w, beh, bold, events, physio, scans, sessions, stim                                                          | n/a                                                            | [@effigies](https://github.com/effigies)   |
| [volume_timing](https://github.com/bids-standard/bids-examples/tree/master/volume_timing)                   | Sparse BOLD acquisitions                                                                    | func                            | bold                                                                                                           | n/a                                                            | [@effigies](https://github.com/effigies)   |

### MRS

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                  | description                                                                            | datatypes   | suffixes                 | link to full data                                | maintained by                                      |
|:--------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------|:------------|:-------------------------|:-------------------------------------------------|:---------------------------------------------------|
| [mrs_2dmrsi](https://github.com/bids-standard/bids-examples/tree/master/mrs_2dmrsi)   | 2D sLASER MRSI data from 8 subjects                                                    | anat, mrs   | T1w, mrsi                | [link](https://zenodo.org/records/7701228)       | [@markmikkelsen](https://github.com/markmikkelsen) |
| [mrs_biggaba](https://github.com/bids-standard/bids-examples/tree/master/mrs_biggaba) | MEGA-PRESS and PRESS MRS data from 12 subjects from one site from the Big GABA project | anat, mrs   | T1w, mrsref, svs         | [link](https://www.nitrc.org/projects/biggaba)   | [@markmikkelsen](https://github.com/markmikkelsen) |
| [mrs_fmrs](https://github.com/bids-standard/bids-examples/tree/master/mrs_fmrs)       | Functional MRS data involving a pain stimulus task from 15 subjects                    | anat, mrs   | T1w, events, mrsref, svs | [link](https://www.nitrc.org/projects/fmrs_2020) | [@markmikkelsen](https://github.com/markmikkelsen) |

### NIRS

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                                | description                                                             | datatypes   | suffixes                                                             | link to full data                              | maintained by                                            |
|:----------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------|:------------|:---------------------------------------------------------------------|:-----------------------------------------------|:---------------------------------------------------------|
| [fnirs_automaticity](https://github.com/bids-standard/bids-examples/tree/master/fnirs_automaticity) | 24 subjects performing (non-)automatic finger tapping and foot stepping | nirs        | channels, coordsystem, events, nirs, optodes, practicelogbook, scans | [link](https://doi.org/10.34973/vesb-mh30)     | [@robertoostenveld](https://github.com/robertoostenveld) |
| [fnirs_tapping](https://github.com/bids-standard/bids-examples/tree/master/fnirs_tapping)           | Example fNIRS measurement with three conditions from five subjects      | nirs        | channels, coordsystem, events, nirs, optodes, scans                  | [link](https://doi.org/10.5281/zenodo.5529797) | [@rob-luke](https://github.com/rob-luke)                 |

### PET

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                        | description     | datatypes   | suffixes         | link to full data                                | maintained by                                    |
|:----------------------------------------------------------------------------|:----------------|:------------|:-----------------|:-------------------------------------------------|:-------------------------------------------------|
| [pet001](https://github.com/bids-standard/bids-examples/tree/master/pet001) | T1w, PET, blood | anat, pet   | T1w, blood, pet  | n/a                                              | [@mnoergaard](https://github.com/mnoergaard)     |
| [pet002](https://github.com/bids-standard/bids-examples/tree/master/pet002) | T1w, PET        | anat, pet   | T1w, pet         | [link](https://openneuro.org/datasets/ds001420/) | [@mnoergaard](https://github.com/mnoergaard)     |
| [pet003](https://github.com/bids-standard/bids-examples/tree/master/pet003) | T1w, PET, blood | anat, pet   | T1w, blood, pet  | n/a                                              | [@mnoergaard](https://github.com/mnoergaard)     |
| [pet004](https://github.com/bids-standard/bids-examples/tree/master/pet004) | PET, blood      | pet         | blood, pet       | n/a                                              | [@mnoergaard](https://github.com/mnoergaard)     |
| [pet005](https://github.com/bids-standard/bids-examples/tree/master/pet005) | T1w, PET        | anat, pet   | T1w, events, pet | n/a                                              | [@mnoergaard](https://github.com/mnoergaard)     |
| [pet006](https://github.com/bids-standard/bids-examples/tree/master/pet006) | PET             | pet         | pet              | n/a                                              | [@bendhouseart](https://github.com/bendhouseart) |

### qMRI

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                                        | description                                                                              | datatypes   | suffixes                                               | link to full data             | maintained by                                                |
|:--------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------|:------------|:-------------------------------------------------------|:------------------------------|:-------------------------------------------------------------|
| [qmri_irt1](https://github.com/bids-standard/bids-examples/tree/master/qmri_irt1)           | Inversion Recovery T1 mapping                                                            | anat        | IRT1                                                   | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_megre](https://github.com/bids-standard/bids-examples/tree/master/qmri_megre)         | Multi-Echo Gradient-Echo for T2star mapping.                                             | anat        | MEGRE                                                  | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_mese](https://github.com/bids-standard/bids-examples/tree/master/qmri_mese)           | Multi-Echo Spin-Echo for T2 or Myelin Water Fraction (MWF) mapping.                      | anat        | MESE                                                   | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_mp2rage](https://github.com/bids-standard/bids-examples/tree/master/qmri_mp2rage)     | MP2RAGE for T1 mapping                                                                   | anat        | MP2RAGE, T1map, UNIT1, defacemask                      | [link](https://osf.io/k4bs5/) | [@Gilles86](https://github.com/Gilles86)                     |
| [qmri_mp2rageme](https://github.com/bids-standard/bids-examples/tree/master/qmri_mp2rageme) | Multi-echo MP2RAGE                                                                       | anat, fmap  | MP2RAGE, TB1map                                        | [link](https://osf.io/k4bs5/) | [@Gilles86](https://github.com/Gilles86)                     |
| [qmri_mpm](https://github.com/bids-standard/bids-examples/tree/master/qmri_mpm)             | Multi-parametric mapping for R1, R2star, MTsat and PD mapping                            | anat, fmap  | MPM, RB1COR, TB1EPI, magnitude1, magnitude2, phasediff | [link](https://osf.io/k4bs5/) | [@ChristophePhillips](https://github.com/ChristophePhillips) |
| [qmri_mtsat](https://github.com/bids-standard/bids-examples/tree/master/qmri_mtsat)         | Example dataset for T1 and MTsat mapping. Includes a double-angle B1+ mapping example.   | anat, fmap  | MTS, TB1DAM                                            | [link](https://osf.io/k4bs5/) | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_qsm](https://github.com/bids-standard/bids-examples/tree/master/qmri_qsm)             | Chimap using fast QSM                                                                    | anat        | T1w                                                    | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_sa2rage](https://github.com/bids-standard/bids-examples/tree/master/qmri_sa2rage)     | Fast B1+ mapping using SA2RAGE                                                           | fmap        | TB1SRGE                                                | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_tb1tfl](https://github.com/bids-standard/bids-examples/tree/master/qmri_tb1tfl)       | B1+ mapping with TurboFLASH readout.                                                     | fmap        | TB1TFL                                                 | `not publicly available`      | [@agahkarakuzu](https://github.com/agahkarakuzu)             |
| [qmri_vfa](https://github.com/bids-standard/bids-examples/tree/master/qmri_vfa)             | Variable Flip Angle T1 mapping. Includes an Actual Flip Angle (AFI) B1+ mapping example. | anat, fmap  | TB1AFI, VFA                                            | [link](https://osf.io/k4bs5/) | [@agahkarakuzu](https://github.com/agahkarakuzu)             |

### Phenotype

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name                                                                            | description                                                      | datatypes       | suffixes   | link to full data   | maintained by                            |
|:--------------------------------------------------------------------------------|:-----------------------------------------------------------------|:----------------|:-----------|:--------------------|:-----------------------------------------|
| [pheno004](https://github.com/bids-standard/bids-examples/tree/master/pheno004) | Minimal dataset with subjects with imaging and/or phenotype data | phenotype, anat | T1w        | n/a                 | [@ericearl](https://github.com/ericearl) |

### Provenance

<!--
TABLE BELOW IS GENERATED AUTOMATICALLY.
DO NOT EDIT DIRECTLY.
-->

| name   | description   | datatypes   | suffixes   | link to full data   | maintained by   |
|--------|---------------|-------------|------------|---------------------|-----------------|

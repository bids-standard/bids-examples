[![GitHub Actions](https://github.com/bids-standard/bids-examples/workflows/validate_datasets/badge.svg)](https://github.com/bids-standard/bids-examples/actions)

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

Simply run `bash run_tests.sh` in a command line from the root of the
`bids-examples` repository.

### Validator exceptions

Some datasets may include a custom `.bids-validator-config.json` to ignore
errors generated from idiosyncracies of the datasets as they existed on
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

- updates to existing examples, or the [dataset index](dataset-index)
- new examples
  - only if they cover aspects that are currently not covered by existing
    examples
  - only if a maintainer can be found for this dataset
- suggestions on how to improve the bids-examples repository

For more information, please see our
[CONTRIBUTING.md](https://github.com/bids-standard/bids-examples/blob/master/CONTRIBUTING.md)
file or open a
[new GitHub Issue](https://github.com/bids-standard/bids-examples/issues/new)
and ask us directly.

## Dataset index

Below you find several tables with information about the datasets available in
bids-examples (in alphabetical order).

- [EEG datasets](#eeg-datasets)
- [iEEG datasets](#ieeg-datasets)
- [MRI datasets](#mri-datasets)
- [ASL datasets](#asl-datasets)
- [qMRI datasets](#qmri-datasets)
- [PET datasets](#PET-datasets)
- [Microscopy datasets](#microscopy-datasets)
- [Multimodal datasets](#multimodal-datasets)

### EEG datasets

| name                | maintained by | description                                                                                                        | link to full data                       |
| ------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------ | --------------------------------------- |
| eeg_matchingpennies | @sappelhoff   | Offline data of BCI experiment decoding left vs. right hand movement. BrainVision data format (.eeg, .vhdr, .vmrk) | https://doi.org/10.17605/OSF.IO/CJ2DR   |
| eeg_rishikesh       | @arnodelorme  | Mind wandering experiment. EEG data in Biosemi (.bdf) format                                                       | https://openneuro.org/datasets/ds001787 |
| eeg_face13          | @andesha      | Deconstructing the early visual electrocortical response to face and house stimuli. EDF format                     |                                         |
| eeg_ds003654s_hed       | @VisLab       | Shows usage of Hierarchical Event Descriptor (HED) in events files                                                 | https://openneuro.org/datasets/ds003645 |
| eeg_ds003654s_hed_inheritance       | @VisLab       | HED annotation with multiple inherited sidecars                                                 | https://openneuro.org/datasets/ds003645 |
| eeg_ds003654s_hed_longform       | @VisLab       | HED annotation using tags in long form.                                                 | https://openneuro.org/datasets/ds003645 |
| eeg_cbm             | @cpernet      | Rest EEG. European Data Format (.edf)                                                                              |                                         |

### iEEG datasets

| name                 | maintained by | description                                                      |
| -------------------- | ------------- | ---------------------------------------------------------------- |
| ieeg_filtered_speech | @choldgraf    | recordings of three seizures                                     |
| ieeg_motorMiller2007 | @dorahermes   | Cue-based hand & tongue movement data                            |
| ieeg_visual          | @dorahermes   | Stimulus dependence of gamma oscillations in human visual cortex |

### MRI datasets

| name              | maintained by     | description                                             | func         | anat                      | other                  | link to link to full data                              |
| ----------------- | ----------------- | ------------------------------------------------------- | ------------ | ------------------------- | ---------------------- | ------------------------------------------------------ |
| 7t_trt            |                   |                                                         | bold, physio | T1w, quantitative T1 maps | fmap                   | https://bit.ly/2H0Z6Qt                                 |
| ds001             |                   | single task, multiple runs                              | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000001/versions/00006 |
| ds002             |                   | multiple tasks, multiple runs                           | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000002/versions/00002 |
| ds003             |                   | single task, single run                                 | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000003/versions/00001 |
| ds005             |                   | single task, multiple runs                              | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000005/versions/00001 |
| ds006             |                   | single task, multiple sessions, multiple runs           | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000006/versions/00001 |
| ds007             |                   | single task, multiple runs                              | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000007/versions/00001 |
| ds008             |                   | multiple tasks, multiple runs                           | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000008/versions/00001 |
| ds009             |                   | multiple tasks, multiple runs                           | bold, events | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000009/versions/00002 |
| ds011             |                   | multiple tasks, multiple runs                           | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000011/versions/00001 |
| ds051             |                   | multiple tasks, multiple runs                           | bold         | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000051/versions/00001 |
| ds052             |                   | multiple tasks, multiple runs                           | bold         | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000052/versions/00001 |
| ds101             |                   | single task, multiple runs                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000101/versions/00004 |
| ds102             |                   | single task, multiple runs                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000102/versions/00001 |
| ds105             |                   | single task, multiple runs                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000105/versions/00001 |
| ds107             |                   | single task, multiple runs                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000107/versions/00001 |
| ds108             |                   | single task, multiple runs                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000108/versions/00002 |
| ds109             |                   | multiple tasks, multiple runs                           | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000109/versions/00001 |
| ds110             |                   | single task, multiple runs                              | bold         | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000110/versions/00001 |
| ds113b            |                   | forrest gump watching, multiple sessions, multiple runs | bold         | T1w, T2w                  | angiography, dwi, fmap | https://openneuro.org/datasets/ds000113/versions/1.3.0 |
| ds114             |                   | multiple tasks, multiple runs                           | bold         | T1w                       | DWI                    | https://openneuro.org/datasets/ds000114/versions/1.0.1 |
| ds116             |                   | multiple tasks, multiple runs                           | bold         | T1w, in-plane T2          |                        | https://openneuro.org/datasets/ds000116/versions/00003 |
| ds210             |                   | multiple tasks, multiple runs                           | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000210/versions/00002 |
| hcp_example_bids  | @robertoostenveld |                                                         | bold         | T1w                       |                        | https://bit.ly/2H0Z6Qt                                 |
| synthetic         | @effigies         | A synthetic dataset                                     | bold         | T1w                       |                        | n/a                                                    |
| ds000001-fmriprep | @effigies         | Common derivatives example                              | bold         | T1w                       |                        | https://openneuro.org/datasets/ds000001/versions/1.0.0 |

### ASL datasets

| name   | maintained by | description                                                                                   | link to link to full data |
| ------ | ------------- | --------------------------------------------------------------------------------------------- | ------------------------- |
| asl001 | @patsycle     | T1w, asl (GE, PCASL, 3D_SPIRAL), m0scan within timeseries                                     | https://osf.io/yru2q/     |
| asl002 | @patsycle     | T1w, asl (Philips, PCASL, 2D_EPI), m0scan as separate scan                                    | https://osf.io/yru2q/     |
| asl003 | @patsycle     | T1w, asl (Siemens, PASL, multiTI), M0scan as separate scan                                    | https://osf.io/yru2q/     |
| asl004 | @patsycle     | T1w, asl (Siemens, PCASL, multiPLD with pepolar), m0scan separate scans with pepolar appraoch | https://osf.io/yru2q/     |
| asl005 | @patsycle     | T1w, asl (Siemens, PCASL, singleTI, 3D_GRASE), m0scan as separate scan                        | https://osf.io/yru2q/     |

### qMRI datasets

| name           | maintained by       | description                                                                              | link to link to full data |
| -------------- | ------------------- | ---------------------------------------------------------------------------------------- | ------------------------- |
| qmri_mp2rage   | @Gilles86           | MP2RAGE for T1 mapping                                                                   | https://osf.io/k4bs5/     |
| qmri_mp2rageme | @Gilles86           | Multi-echo MP2RAGE                                                                       | https://osf.io/k4bs5/     |
| qmri_mpm       | @ChristophePhillips | Multi-parametric mapping for R1, R2star, MTsat and PD mapping                            | https://osf.io/k4bs5/     |
| qmri_mtsat     | @agahkarakuzu       | Example dataset for T1 and MTsat mapping. Includes a double-angle B1+ mapping example.   | https://osf.io/k4bs5/     |
| qmri_qsm       | @agahkarakuzu       | Chimap using fast QSM                                                                    | `not publicly availabe`   |
| qmri_sa2rage   | @agahkarakuzu       | Fast B1+ mapping using SA2RAGE                                                           | `not publicly availabe`   |
| qmri_vfa       | @agahkarakuzu       | Variable Flip Angle T1 mapping. Includes an Actual Flip Angle (AFI) B1+ mapping example. | https://osf.io/k4bs5/     |
| qmri_irt1      | @agahkarakuzu       | Inversion Recovery T1 mapping                                                            | `not publicly availabe`   |
| qmri_mese      | @agahkarakuzu       | Multi-Echo Spin-Echo for T2 or Myelin Water Fraction (MWF) mapping.                      | `not publicly availabe`   |
| qmri_megre     | @agahkarakuzu       | Multi-Echo Gradient-Echo for T2star mapping.                                             | `not publicly availabe`   |
| qmri_tb1tfl    | @agahkarakuzu       | B1+ mapping with TurboFLASH readout.                                                     | `not publicly availabe`   |

### PET datasets

| name   | maintained by | description     | link to full data                        |
| ------ | ------------- | --------------- | ---------------------------------------- |
| pet001 | @mnoergaard   | T1w, PET, blood |                                          |
| pet002 | @mnoergaard   | T1w, PET        | https://openneuro.org/datasets/ds001420/ |
| pet003 | @mnoergaard   | T1w, PET, blood |                                          |
| pet004 | @mnoergaard   | PET, blood      |                                          |
| pet005 | @mnoergaard   | T1w, PET        |                                          |

### Microscopy datasets

| name          | maintained by | description                                                                                     |
| ------------- | ------------- | ----------------------------------------------------------------------------------------------- |
| micr_SEM      | @jcohenadad   | Example SEM dataset in PNG format with 1 sample imaged over 2 sessions                          |
| micr_SEMzarr  | @TheChymera   | Example SEM dataset in PNG and OME-ZARR format with 1 sample imaged over 2 sessions             |
| micr_SPIM     | @jcohenadad   | Example SPIM dataset in OME-TIFF format with 2 samples from the same subject with 4 chunks each |

### Multimodal datasets

| name                   | maintained by     | description                                                                                                                          | mri                   | meg | eeg | ieeg | genetics | link to full data                                              |
| ---------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------------------- | --- | --- | ---- | -------- | -------------------------------------------------------------- |
| ds000117               | @RikHenson        | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task                                          | anat, dwi, func, fmap | meg | eeg |      |          | https://openneuro.org/datasets/ds000117/                       |
| ds000246               | @guiomar          | Auditory dataset used for Brainstorm’s general online tutorial                                                                       | anat                  | meg |     |      |          | https://openneuro.org/datasets/ds000246/versions/00001         |
| ds000247               | @guiomar          | Five minutes, eyes-open, resting-state MEG data from 5 subjects. This is a sample from The Open MEG Archive (OMEGA).                 | anat                  | meg |     |      |          | https://openneuro.org/datasets/ds000247/versions/00001         |
| ds000248               | @agramfort        | MNE sample data: Data with visual and auditory stimuli                                                                               | anat                  | meg |     |      |          | https://openneuro.org/datasets/ds000248/versions/00001         |
| eeg_ds000117           | @robertoostenveld | Multimodal (fMRI, MEG, EEG) stripped down to EEG with MRI anatomical scan and electrode coordinates. EEGLAB data format (.set, .fdt) | anat                  |     | eeg |      |          | https://openneuro.org/datasets/ds000117/                       |
| eeg_rest_fmri          | @cpernet          | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk)                                                   | anat, dwi, func       |     | eeg |      |          |                                                                |
| ieeg_epilepsy          | @ftadel           | multiple sessions, tutorial                                                                                                          | anat                  |     |     | ieeg |          | https://neuroimage.usc.edu/bst/getupdate.php?s=tutorial_epimap_bids |
| ieeg_epilepsy_ecog     | @ftadel           | multiple sessions, tutorial                                                                                                          | anat                  |     |     | ieeg |          | https://neuroimage.usc.edu/bst/getupdate.php?s=sample_ecog     |
| ieeg_visual_multimodal | @irisgroen        |                                                                                                                                      | anat, fmap, func      |     |     | ieeg |          |                                                                |
| genetics_ukbb          | @cpernet          | multiple tasks, T1w, DTI, BOLD, genetic info                                                                                         | anat, dwi, func, fmap |     |     |      | genetics |                                                                |

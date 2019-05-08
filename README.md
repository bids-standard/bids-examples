[![Travis](https://api.travis-ci.org/bids-standard/bids-examples.svg?branch=master "Travis")](https://travis-ci.org/bids-standard/bids-examples)

# bids-examples

This repository contains a set of [BIDS-compatible](http://bids.neuroimaging.io/)
datasets with **empty raw data files**. These datasets can be useful to:

1. write lightweight software tests
1. serve as an example on how a BIDS dataset can be structured

ALL RAW DATA FILES IN THIS REPOSITORY ARE EMPTY!

However for some of the data, the headers containing the metadata are still
intact. This is true for the following datasets:

- `synthetic`
- Most EEG or iEEG data in BrainVision format (e.g., `eeg_matchingpennies`)

# Contributing

If you want to contribute a dataset to the examples, we would be happy to
accommodate it, as long as it exhibits some structure or particularity that is
not covered by the examples that are already present so far.

# Dataset index

If you want to update this table, please open a new GitHub Issue and a
corresponding Pull Request.

|  name | description | mri | meg | eeg | ieeg | full data |
| --- | --- | --- | --- | --- | --- | --- |
|  7t_trt | field maps, physiological data, quantitative T1 maps, T1w, BOLD | mri |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds000117 | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task | mri | meg | eeg |  | https://openneuro.org/datasets/ds000117/ |
|  ds000246 | Auditory dataset used for Brainstorm’s general online tutorial | mri | meg |  |  | https://openneuro.org/datasets/ds000246/versions/00001 |
|  ds000247 | Five minutes, eyes-open, resting-state MEG data from 5 subjects. This is a sample from The Open MEG Archive (OMEGA). | mri | meg |  |  | https://openneuro.org/datasets/ds000247/versions/00001 |
|  ds000248 | MNE sample data: Data with visual and auditory stimuli | mri | meg |  |  | https://openneuro.org/datasets/ds000248/versions/00001 |
|  ds001 | single task, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000001/versions/00006 |
|  ds002 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000002/versions/00002 |
|  ds003 | single task, single run, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000003/versions/00001 |
|  ds005 | single task, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000005/versions/00001 |
|  ds006 | single task, multiple sessions, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000006/versions/00001 |
|  ds007 | single task, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000007/versions/00001 |
|  ds008 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000008/versions/00001 |
|  ds009 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000009/versions/00002 |
|  ds011 | multiple tasks, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000011/versions/00001 |
|  ds051 | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | mri |  |  |  | https://openneuro.org/datasets/ds000051/versions/00001 |
|  ds052 | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | mri |  |  |  | https://openneuro.org/datasets/ds000052/versions/00001 |
|  ds101 | single task, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000101/versions/00004 |
|  ds102 | single task, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000102/versions/00001 |
|  ds105 | single task, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000105/versions/00001 |
|  ds107 | single task, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000107/versions/00001 |
|  ds108 | single task, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000108/versions/00002 |
|  ds109 | multiple tasks, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000109/versions/00001 |
|  ds110 | single task, multiple runs, T1w, BOLD, in plane T2 | mri |  |  |  | https://openneuro.org/datasets/ds000110/versions/00001 |
|  ds113b | forrest gump watching, multiple sessions, multiple runs, T1w, T2w, BOLD, angiography, dwi, fieldmaps | mri |  |  |  | https://openneuro.org/datasets/ds000113/versions/1.3.0 |
|  ds114 | multiple tasks, multiple runs, T1w, BOLD, DWI | mri |  |  |  | https://openneuro.org/datasets/ds000114/versions/1.0.1 |
|  ds116 | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | mri |  |  |  | https://openneuro.org/datasets/ds000116/versions/00003 |
|  ds210 | multiple tasks, multiple runs, T1w, BOLD | mri |  |  |  | https://openneuro.org/datasets/ds000210/versions/00002 |
|  eeg_cbm | Rest EEG. European Data Format (.edf) | mri |  |  |  |  |
|  eeg_ds000117 | Multimodal (fMRI, MEG, EEG) stripped down to EEG with MRI anatomical scan and electrode coordinates. EEGLAB data format (.set, .fdt) | mri |  | eeg |  | https://openneuro.org/datasets/ds000117/ |
|  eeg_matchingpennies | Offline data of BCI experiment decoding left vs. right hand movement. See Matching Pennies: A Brain Computer Interface Implementation Dataset for more information. BrainVision data format (.eeg, .vhdr, .vmrk) |  |  | eeg |  | https://osf.io/cj2dr/ |
|  eeg_rest_fmri | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk) |  |  | eeg |  |  |
|  eeg_rishikesh | Mind wandering experiment. EEG data in Biosemi (.bdf) format |  |  | eeg |  | https://zenodo.org/record/2536267 |
|  hcp_example_bids |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ieeg_epilepsy | multiple sessions, tutorial | mri |  |  | ieeg | https://openneuro.org/datasets/ds001779 |
|  ieeg_epilepsy_ecog | multiple sessions, tutorial | mri |  |  | ieeg | https://openneuro.org/datasets/ds001868 |
|  ieeg_filtered_speech | recordings of three seizures |  |  |  | ieeg |  |
|  ieeg_motorMiller2007 | Cue-based hand & tongue movement data |  |  |  | ieeg |  |
|  ieeg_visual | Stimulus dependence of gamma oscillations in human visual cortex |  |  |  | ieeg |  |
|  ieeg_visual_multimodal |  |  |  |  | ieeg |  |
|  synthetic | A synthetic dataset | mri |  |  |  |  |

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
|  7t_trt | field maps, physiological data, quantitative T1 maps, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds000117 | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task | x | x | x |  | https://openneuro.org/datasets/ds000117/ |
|  ds000246 | Auditory dataset used for Brainstorm’s general online tutorial | x | x |  |  | https://openneuro.org/datasets/ds000246/versions/00001 |
|  ds000247 | Five minutes, eyes-open, resting-state MEG data from 5 subjects. This is a sample from The Open MEG Archive (OMEGA). | x | x |  |  |  |
|  ds000248 | MNE sample data: Data with visual and auditory stimuli | x | x |  |  | https://bit.ly/2JfNYkf |
|  ds001 | single task, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds002 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds003 | single task, single run, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds005 | single task, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds006 | single task, multiple sessions, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds007 | single task, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds008 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds009 | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds011 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds051 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds052 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds101 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds102 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds105 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds107 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds108 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds109 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds110 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds113b |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds114 | DWI, multiple tasks, events, T1w, BOLD | x |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds116 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ds210 |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  eeg_cbm | Rest EEG. European Data Format (.edf) |  |  |  |  |  |
|  eeg_ds000117 | Multimodal (fMRI, MEG, EEG) stripped down to EEG with MRI anatomical scan and electrode coordinates. EEGLAB data format (.set, .fdt) | x |  | x |  | https://openneuro.org/datasets/ds000117/ |
|  eeg_matchingpennies | Offline data of BCI experiment decoding left vs. right hand movement. See Matching Pennies: A Brain Computer Interface Implementation Dataset for more information. BrainVision data format (.eeg, .vhdr, .vmrk) |  |  | x |  | https://osf.io/cj2dr/ |
|  eeg_rest_fmri | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk) |  |  |  |  |  |
|  eeg_rishikesh | Mind wandering experiment. EEG data in Biosemi (.bdf) format |  |  | x |  | https://zenodo.org/record/2536267 |
|  hcp_example_bids |  |  |  |  |  | https://bit.ly/2H0Z6Qt |
|  ieeg_epilepsy |  |  |  |  | x | https://openneuro.org/datasets/ds001779 |
|  ieeg_filtered_speech | recordings of three seizures |  |  |  | x |  |
|  ieeg_motorMiller2007 | Cue-based hand & tongue movement data |  |  |  | x |  |
|  ieeg_visual | Stimulus dependence of gamma oscillations in human visual cortex |  |  |  | x |  |
|  ieeg_visual_multimodal |  |  |  |  | x |  |
|  synthetic | A synthetic dataset |  |  |  |  |  |

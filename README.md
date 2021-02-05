[![GitHub Actions](https://github.com/bids-standard/bids-examples/workflows/validate_datasets/badge.svg)](https://github.com/bids-standard/bids-examples/actions)

# bids-examples

This repository contains a collection of [BIDS-compatible](https://bids.neuroimaging.io/)
datasets with **empty raw data files**. These datasets have been contributed as
test data for lightweight software tests and to provide examples of how BIDS datasets
may be structured. The [bids-starter-kit](https://github.com/bids-standard/bids-starter-kit)
is also a good place to look for models of best practice for structuring your BIDS
dataset.   

All of the raw data files in these example datasets are empty.
Some of the datasets have intact metadata headers (including 
`synthetic` and most EEG or iEEG datasets in BrainVision format).
Other datasets have some empty metadata headers.

# Using the example datasets

If you want to use the example datasets with the bids-validator,
you must indicate that empty raw files and certain empty headers should 
be ignored during validation. 

**Example:** For example, suppose you are running the bids-validator
 from the command line and want to validate the example dataset
 `eeg_matchingpennies`. From the parent directory of `eeg_matchingpennies`
 execute the following command:
 
````
 bids-validator eeg_matchingpennies --config.ignore=99 --config.ignore=40
````

See the [bids-validator home page](https://github.com/bids-validator) for
instructions on how to install and/or use the bids-validator.

# Validator configuration for the example datasets

You can put required validator configuration information in a custom 
`.bids-validator-config.json` file in the root of your dataset.
The configuration file that would be required to ignore 
empty raw files and empty Nifti headers is:

````json
{
     "ignore": [99, 40] 
} 
````
 
Some datasets in [bids-examples](https://github.com/bids-examples) may 
have a custom configuration file tailored to ignore errors generated 
from idiosyncracies particular to that dataset. 

| name | errors ignored |
| --- | --- |
| genetics_ukbb | SliceTiming values for tasks is larger than given TR, EchoTime1 and EchoTime2 are not provided for any of the phasediff files. |


Other datasets may include a `.SKIP_VALIDATION` file, to skip the validation with the continuous integration service.
This is useful for datasets that *cannot* pass at the moment due to lack of coverage in the [bids-validator](https://github.com/bids-standard/bids-validator).

| name | why skipped |
| --- | --- |
| ds000001-fmriprep | lack of coverage in bids-validator |

# Contributing

We are happy to receive contributions in the form of:

- updates to existing examples, or the [dataset index](dataset-index)
- new examples
    - only if they cover aspects that are currently not covered by existing examples
    - only if a maintainer can be found for this dataset
- suggestions on how to improve the bids-examples repository

For more information, please see our
[CONTRIBUTING.md](https://github.com/bids-standard/bids-examples/blob/master/CONTRIBUTING.md)
file or open a
[new GitHub Issue](https://github.com/bids-standard/bids-examples/issues/new)
and ask us directly.

# Dataset index

Below you find several tables with information about the datasets available in bids-examples (in alphabetical order).

- [EEG datasets](EEG-datasets)
- [iEEG datasets](iEEG-datasets)
- [MRI datasets](MRI-datasets)
- [Multimodal datasets](Multimodal-datasets)

## EEG datasets

|  name | maintained by | description | link to full data |
| --- | --- | --- | --- |
|  eeg_matchingpennies | @sappelhoff | Offline data of BCI experiment decoding left vs. right hand movement. BrainVision data format (.eeg, .vhdr, .vmrk) | https://doi.org/10.17605/OSF.IO/CJ2DR |
|  eeg_rishikesh | @arnodelorme | Mind wandering experiment. EEG data in Biosemi (.bdf) format | https://openneuro.org/datasets/ds001787 |
|  eeg_face13 | @andesha | Deconstructing the early visual electrocortical response to face and house stimuli. EDF format | |

## iEEG datasets

|  name | maintained by | description | link to full data |
| --- | --- | --- | --- |
| ieeg_filtered_speech | @choldgraf | recordings of three seizures |  |  |  | ieeg | not publicly available |
| ieeg_motorMiller2007 | @dorahermes | Cue-based hand & tongue movement data |  |  |  | ieeg |  |
| ieeg_visual | @dorahermes | Stimulus dependence of gamma oscillations in human visual cortex |  |  |  | ieeg |  |

## MRI datasets

|  name | maintained by | description | link to link to full data |
| --- | --- | --- | --- |
|  7t_trt | | field maps, physiological data, quantitative T1 maps, T1w, BOLD | https://bit.ly/2H0Z6Qt |
|  asl001 | @patsycle | T1w, asl (GE, PCASL, 3D_SPIRAL), m0scan within timeseries | |
|  asl002 | @patsycle | T1w, asl (Philips, PCASL, 2D_EPI), m0scan as separate scan | |
|  asl003 | @patsycle | T1w, asl (Siemens, PASL, multiTI), M0 from average control image | |
|  asl004 | @patsycle | T1w, asl (Siemens, PCASL, multiPLD with pepolar), m0scan separate scans with pepolar appraoch | |
|  asl005 | @patsycle | T1w, asl (Siemens, PCASL, singleTI, 3D_GRASE), m0scan as separate scan | |
|  ds001 | | single task, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000001/versions/00006 |
|  ds002 | | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000002/versions/00002 |
|  ds003 | | single task, single run, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000003/versions/00001 |
|  ds005 | | single task, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000005/versions/00001 |
|  ds006 | | single task, multiple sessions, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000006/versions/00001 |
|  ds007 | | single task, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000007/versions/00001 |
|  ds008 | | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000008/versions/00001 |
|  ds009 | | multiple tasks, multiple runs, in-plane T2, events, T1w, BOLD | https://openneuro.org/datasets/ds000009/versions/00002 |
|  ds011 | | multiple tasks, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000011/versions/00001 |
|  ds051 | | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | https://openneuro.org/datasets/ds000051/versions/00001 |
|  ds052 | | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | https://openneuro.org/datasets/ds000052/versions/00001 |
|  ds101 | | single task, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000101/versions/00004 |
|  ds102 | | single task, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000102/versions/00001 |
|  ds105 | | single task, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000105/versions/00001 |
|  ds107 | | single task, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000107/versions/00001 |
|  ds108 | | single task, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000108/versions/00002 |
|  ds109 | | multiple tasks, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000109/versions/00001 |
|  ds110 | | single task, multiple runs, T1w, BOLD, in plane T2 | https://openneuro.org/datasets/ds000110/versions/00001 |
|  ds113b | | forrest gump watching, multiple sessions, multiple runs, T1w, T2w, BOLD, angiography, dwi, fieldmaps | https://openneuro.org/datasets/ds000113/versions/1.3.0 |
|  ds114 | | multiple tasks, multiple runs, T1w, BOLD, DWI | https://openneuro.org/datasets/ds000114/versions/1.0.1 |
|  ds116 | | multiple tasks, multiple runs, T1w, BOLD, inplane T2 | https://openneuro.org/datasets/ds000116/versions/00003 |
|  ds210 | | multiple tasks, multiple runs, T1w, BOLD | https://openneuro.org/datasets/ds000210/versions/00002 |
|  hcp_example_bids | @robertoostenveld |   | https://bit.ly/2H0Z6Qt |
|  synthetic | @effigies | A synthetic dataset | mri |  |  |  |  | n/a
|  ds000001-fmriprep | @effigies | Common derivatives example | mri | | | | | https://openneuro.org/datasets/ds000001/versions/1.0.0

## Multimodal datasets

|  name | maintained by | description | mri | meg | eeg | ieeg | genetics | link to full data |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
|  ds000117 | @RikHenson | A multi-subject, multi-modal human neuroimaging dataset of 19 subjects on a MEG visual task | mri | meg | eeg |  | | https://openneuro.org/datasets/ds000117/ |
|  ds000246 | @guiomar | Auditory dataset used for Brainstorm’s general online tutorial | mri | meg |  |  | | https://openneuro.org/datasets/ds000246/versions/00001 |
|  ds000247 | @guiomar | Five minutes, eyes-open, resting-state MEG data from 5 subjects. This is a sample from The Open MEG Archive (OMEGA). | mri | meg |  |  | | https://openneuro.org/datasets/ds000247/versions/00001 |
|  ds000248 | @agramfort | MNE sample data: Data with visual and auditory stimuli | mri | meg |  |  | | https://openneuro.org/datasets/ds000248/versions/00001 |
|  eeg_cbm | @cpernet | Rest EEG. European Data Format (.edf) | mri |  | eeg |  |  | |
|  eeg_ds000117 | @robertoostenveld | Multimodal (fMRI, MEG, EEG) stripped down to EEG with MRI anatomical scan and electrode coordinates. EEGLAB data format (.set, .fdt) | mri |  | eeg |  | | https://openneuro.org/datasets/ds000117/ |
|  eeg_rest_fmri | @cpernet | Resting state with simultaneous fMRI. BrainVision data format (.eeg, .vhdr, .vmrk) | mri |  | eeg |  |  | |
|  ieeg_epilepsy | @ftadel | multiple sessions, tutorial | mri |  |  | ieeg | | https://neuroimage.usc.edu/bst/getupdate.php?s=tutorial_epimap |
|  ieeg_epilepsy_ecog | @ftadel | multiple sessions, tutorial | mri |  |  | ieeg | | https://neuroimage.usc.edu/bst/getupdate.php?s=sample_ecog |
|  ieeg_visual_multimodal |  @irisgroen | | mri |  |  | ieeg | | |
|  genetics_ukbb |  @cpernet | multiple tasks, T1w, DTI, BOLD, genetic info | mri |  |  | | genetics | |

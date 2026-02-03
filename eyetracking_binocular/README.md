# Example BIDS Physio-EyeTracking Dataset - Binocular Recordings

## Data descriptor 

Authors: Martin SZINTE, Guillaume Masson, Jason Samonds & Nicholas Priebe
BIDS-Conversion: Julia-Katharina Pfarr, Rémi Gau
BIDS-Example: Julia-Katharina Pfarr, Oscar Esteban
Project: natImSac
Version: 1.0

## Data

This example corresponds to the structure of the "natImSac" project, adapted to demonstrate BEP020.
This example does not contain any eye-tracking data, it just shows the BIDS organization of an experiment with an eye-tracker.
For the full example preserving the actual eye-tracker recordings, please access the DataLad dataset at https://github.com/julia-pfarr/natImSac_BIDSexample.git. 

The original source data is found at https://github.com/mszinte/natImSac.
The natImSac involved an experiment in which human participant free view natural images to determine saccade and fixation statistics.
Full description of the project is found in the following [publication](https://doi.org/10.1523/ENEURO.0287-23.2023).
Only the eye-tracking data of the original dataset and a subset of participants and runs thereof were kept for this example dataset. 

## Methods (BIDS Conversion)

Sourcedata was converted to raw data according to the BIDS Physio-EyeTracking specification using the [eye2bids](https://github.com/bids-standard/eye2bids) converter tool. 
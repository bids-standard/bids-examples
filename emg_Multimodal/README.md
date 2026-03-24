# EMG Multimodal Dataset

## Overview

This is a simplified example dataset derived from OpenNeuro ds003739 demonstrating the integration of EEG, EMG, and motion capture data in BIDS format. The dataset contains simultaneous recordings from all three modalities during a perturbed balance task.

## Modalities

- **EEG**: 128-channel electroencephalography using a Biosemi ActiveTwo system
- **EMG**: 10-channel electromyography from neck and lower leg muscles
- **Motion Capture**: 3D position tracking of head and sacrum markers
- **EOG**: 3-channel electrooculography

## Task Description

Participants stood on a treadmill-mounted balance beam (2.5 cm tall, 12.7 cm wide) and were exposed to sensorimotor perturbations consisting of side-to-side waist pulls lasting 1 second. Each session involved 150 perturbation events balanced between pull directions.

## Data Acquisition

All data were recorded synchronously at 256 Hz using a Biosemi ActiveTwo system. The recording includes:
- 128 EEG channels with common median reference
- 10 EMG channels (neck and lower leg muscles)
- 3 EOG channels
- Motion capture data for sacrum and head positions
- Load cell data from left and right sides

## Reference

This example is based on the study:

Peterson SM & Ferris DP (2018). Differentiation in theta and beta electrocortical activity between visual and physical perturbations to walking and standing balance. eNeuro, 5(4): ENEURO.0207-18.2018.

Full dataset: https://openneuro.org/datasets/ds003739

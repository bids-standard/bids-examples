# EMG Custom Bipolar Face Example

This dataset illustrates recording from facial muscles with:
- One-to-many mapping between sensors and muscles
- Functional localization for electrode placement
- Recording from muscles without bony landmarks

## Dataset Structure

The dataset includes a single subject with custom bipolar EMG setup for facial muscles:

```shell
emg_CustomBipolarFace/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-talking_channels.tsv
        ├── sub-01_task-talking_electrodes.json
        ├── sub-01_task-talking_electrodes.tsv
        ├── sub-01_task-talking_emg.edf
        └── sub-01_task-talking_emg.json
```

## Recording Details

- **Electrode Setup**: Custom bipolar EMG recordings from facial muscles
- **Task**: Talking task with facial expressions
- **Challenges**: Documentation of electrode placement on non-bony landmarks
- **Muscles Recorded**: Multiple facial muscles (zygomaticus, frontalis, orbicularis oris)

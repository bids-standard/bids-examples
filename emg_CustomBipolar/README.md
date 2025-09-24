# EMG Custom Bipolar Example

This dataset demonstrates documentation of a custom-made bipolar EMG system recording:
- Single channel bipolar montage
- Precise electrode placement using anatomical landmarks
- Inter-electrode distance specifications

## Dataset Structure

The dataset includes a single subject with a custom bipolar EMG setup:

```
emg_CustomBipolar/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-holdWeight_channels.tsv
        ├── sub-01_task-holdWeight_emg.edf
        └── sub-01_task-holdWeight_emg.json
```

## Recording Details

- **Electrode Setup**: Custom bipolar EMG recording from flexors of the lower arm
- **Task**: Holding a weight to activate forearm flexors
- **Electrode Placement**: Precise positioning using anatomical landmarks
- **Inter-electrode Distance**: 2 cm between recording electrodes 
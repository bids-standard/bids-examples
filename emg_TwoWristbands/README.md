# EMG Two Wristbands Example

This dataset demonstrates EMG recordings using two wristbands with dry electrodes:
- Dry electrode technology
- Wristband form factor
- Forearm muscle activity capture

## Dataset Structure

The dataset includes a single subject with two EMG wristbands:

```shell
emg_TwoWristbands/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-typing_channels.json
        ├── sub-01_task-typing_channels.tsv
        ├── sub-01_task-typing_coordsystem.json
        ├── sub-01_task-typing_electrodes.tsv
        ├── sub-01_task-typing_emg.edf
        └── sub-01_task-typing_emg.json
```

## Recording Details

- **Electrode Setup**: Two wristbands with dry electrodes
- **Task**: Typing task for hand and wrist movements
- **Electrode Type**: Dry electrodes integrated into wristbands
- **Muscles Recorded**: Forearm flexors and extensors

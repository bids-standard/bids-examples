# EMG Concurrent Independent Units Example

This dataset demonstrates concurrent EMG recording with multiple independent units:
- Different sampling rates
- Multiple recording units

## Dataset Structure

The dataset includes a single subject with multiple EMG recording units:

```shell
emg_ConcurrentIndependentUnits/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_photo.png
        ├── sub-01_recording-highDensity_coordsystem.json
        ├── sub-01_recording-highDensity_electrodes.tsv
        ├── sub-01_task-jumping_events.json
        ├── sub-01_task-jumping_events.tsv
        ├── sub-01_task-jumping_recording-bipolar_channels.tsv
        ├── sub-01_task-jumping_recording-bipolar_emg.edf
        ├── sub-01_task-jumping_recording-bipolar_emg.json
        ├── sub-01_task-jumping_recording-highDensity_channels.tsv
        ├── sub-01_task-jumping_recording-highDensity_emg.edf
        └── sub-01_task-jumping_recording-highDensity_emg.json
```

## Recording Details

- **Recording Setup**: Multiple independent EMG units recording simultaneously
- **Task**: Jumping tasks requiring multiple muscle groups
- **Sampling Rates**: Different rates for different units (1000 Hz and 2000 Hz)
- **Synchronization**: Documentation of timing between units

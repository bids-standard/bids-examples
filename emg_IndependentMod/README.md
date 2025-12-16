# EMG Independent Modules Example

This dataset demonstrates commercial bipolar EMG modules recording from multiple muscles:
- Multiple independent bipolar channels
- Wireless sensors
- Documentation of multiple target muscles

## Dataset Structure

The dataset includes a single subject with independent EMG modules:

```shell
emg_IndependentMod/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-grasping_channels.tsv
        ├── sub-01_task-grasping_emg.edf
        └── sub-01_task-grasping_emg.json
```

## Recording Details

- **Electrode Setup**: Commercial wireless bipolar EMG modules
- **Task**: Grasping tasks to activate multiple arm muscles
- **Muscles Recorded**: Flexor digitorum superficialis, extensor digitorum, biceps, triceps
- **Recording Configuration**: Independent bipolar electrode pairs on each muscle

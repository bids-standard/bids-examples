# EMG Two High-Density Grids Example

This dataset demonstrates high-density EMG grid recordings from two body parts:
- Grid placement documentation
- Multiple channels from each grid
- Spatial organization of electrodes

## Dataset Structure

The dataset includes a single subject with two high-density EMG grids:

```
emg_TwoHDsEMG/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-isometric_channels.json
        ├── sub-01_task-isometric_channels.tsv
        ├── sub-01_task-isometric_electrodes.json
        ├── sub-01_task-isometric_electrodes.tsv
        ├── sub-01_task-isometric_emg.edf
        └── sub-01_task-isometric_emg.json
```

## Recording Details

- **Electrode Setup**: Two high-density EMG grids (8x8 and 6x6 configurations)
- **Task**: Isometric tasks to activate different muscle regions
- **Grid Placement**: One grid on forearm flexors, one on deltoid
- **Channel Organization**: Spatial mapping of grid electrodes 
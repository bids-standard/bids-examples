# EMG Invasive Fine Wire Example

This dataset demonstrates documentation of a invasive fine wire EMG recording:
- Invasive EMG
- Single channel bipolar fine wire electrode

## Dataset Structure

The dataset includes a single subject and fine wire invasive EMG:

```
emg_fineWire/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-isometric_channels.tsv
        ├── sub-01_task-isometric_emg.edf
        └── sub-01_task-isometric_emg.json
```

## Recording Details

- **Electrode Setup**: Invasive fine wire electrode
- **Task**: Isometric contraction
- **Electrode Placement**: The fine-wires were inserted (perpendicular to the skin) into the right tibialis anterior as pairs using a cannulae to a target depth of 2 cm. After the insertion, the bipolar EMG was visually inspected and if needed the electrode positions were adjusted through light needle moovements. Afterwards, the cannula was removed leaving only the fine wires within the muscle.
- **Inter-electrode Distance**: Approximately 0.5 mm

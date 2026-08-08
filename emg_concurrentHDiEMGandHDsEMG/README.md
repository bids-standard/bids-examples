# EMG combined invasive and surface EMG

This dataset demonstrates simualtaneous iEMG and sEMG recordings:
- Heterogeneous electrodes
- High-desnity invasive EMG
- Custom electrodes

## Dataset Structure

The dataset includes a single subject with a custom combined iEMG + sEMG setup:

```
emg_concurentHDiEMGandHDsEMG/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_space-grid1_coordsystem.json
        ├── sub-01_space-grid2_coordsystem.json
        ├── sub-01_space-lowerleg_coordsystem.json
        ├── sub-01_task-isometric_channels.tsv
        ├── sub-01_task-isometric_electrodes.tsv
        ├── sub-01_task-isometric_emg.edf
        ├── sub-01_task-isometric_emg.json
        ├── sub-01_task-isometric_events.tsv
        └── sub-01_task-isometric_events.json
```

## Recording Details

- **Electrode Setup**: A custom HDiEMG thin-filament electrode is inserted into the tibialis anterior muscle, while a HDsEMG array records from the body surface (on top of the same muscle)
- **Recording Setup** Both iEMG and sEMG are electroded by a single data aquisition system
- **Task**: Isometric ramp-and-hold contraction (see *_events.tsv):
  - 0 to 10 seconds: rest
  - 10 to 20 seconds: ramping up the isometric torque at 2 % MVC per second
  - 20 to 50 seconds: steady isometric torque at 20 % MVC
  - 50 to 60 seconds: ramping down the isometric torque at -2 % MVC per second
  - 60 to 70 seconds: rest
- **Custom HDiEMG thin filament electrode**:
  - The thin film is a U-shaped polyimid structure with a height of 70 mm and thickness of 0.15 mm. The two vertical sides of the "U" have  widths of 0.65 mm (electrode filament) and 0.15 mm (guiding filament).
  - The electrode filament consists of a linear array of 40 platinum electrode contacs (surface area: 0.0056 mm^2) with an interelectrode distance of 0.5 mm
  - To implant the thin filament the guiding filament is inserted into a 25-gauge needle (length: 40 mm). After inserting the needle into the target muscle, the needle is withdrawn, leaving only the thin-film structure within the muscle.
- **HDsEMG**: Commercially available 13x5 HDsEMG grid with an interelectrode distance of 4 mm. 

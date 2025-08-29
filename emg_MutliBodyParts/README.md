# EMG Multiple Body Parts Example

This dataset demonstrates recording from multiple body parts with different electrode types:
- Different electrode types for different body parts
- Documentation of electrode placement for each type
- Recording from muscles with different characteristics

## Dataset Structure

The dataset includes a single subject with multiple EMG setups:

```shell
emg_MutliBodyParts/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-mechPerturbations_channels.json
        ├── sub-01_task-mechPerturbations_channels.tsv
        ├── sub-01_task-mechPerturbations_emg.edf
        └── sub-01_task-mechPerturbations_emg.json
```

## Recording Details

- **Electrode Setup**: Multiple electrode types (surface, fine-wire, needle) on different body parts
- **Task**: Mechanical perturbation tasks targeting different muscle groups
- **Electrode Types**: Surface electrodes, fine-wire electrodes, and needle electrodes
- **Body Parts**: Upper limb, lower limb, and trunk muscles

# EMG Concentric Needl Example

This dataset demonstrates documentation of a concentric needle EMG recording:
- Invasive EMG
- Single channel (bipolar) concentric needle

## Dataset Structure

The dataset includes a single subject with a custom bipolar EMG setup:

```
emg_concentricNeedle/
├── dataset_description.json
├── participants.json
├── participants.tsv
├── README.md
└── sub-01/
    └── emg/
        ├── sub-01_task-psaExamination_channels.tsv
        ├── sub-01_task-psaExamination_emg.edf
        ├── sub-01_task-psaExamination_emg.json
        ├── sub-01_task-psaExamination_events.tsv
        └── sub-01_task-psaExamination_events.json
```

## Recording Details

- **Electrode Setup**: Concentric needle EMG recording from the left abductor digiti minimi (ADM)
- **Insertion**: The concentric needle was inserted (perpendicular to the skin) into the proximal part of the left abductor digiti minimi (ADM) targeting an depth of 1 cm.
- **Task**: Sponatneous muscle acivity examination 
    - Triggering myotonic discharges through a slight needle motion every 8 seconds (see also *_events.tsv)

# BOLD volume timing test

This example is intended to exercise BOLD volume timing options enumerated in
https://bids-specification.readthedocs.io/en/stable/modality-specific-files/magnetic-resonance-imaging-data.html#timing-parameters_1.

All JSON files describe 1-second volume acquisitions, in various configurations.

| Filename                                       | Acquisition type   | Metadata fields                            | Description                                                                      |
| ---------------------------------------------- | ------------------ | ------------------------------------------ | -------------------------------------------------------------------------------- |
| `sub-01_task-rest_acq-dense_bold.json`         | Dense              | `RepetitionTime`                           | No gaps in volume acquisitions.                                                  |
| `sub-01_task-rest_acq-constantDelay_bold.json` | Constant-TR sparse | `RepetitionTime`, `DelayTime`              | Constant TR with a gap between volume acquisitions.                              |
| `sub-01_task-rest_acq-constantST_bold.json`    | Constant-TR sparse | `RepetitionTime`, `SliceTiming`            | Constant TR, with acquisition duration calculable from `SliceTiming`.            |
| `sub-01_task-rest_acq-clusteredTA_bold.json`   | Varying-TR sparse  | `VolumeTiming`, `FrameAcquisitionDuration` | Volume onsets and constant acquisition duration provided.                        |
| `sub-01_task-rest_acq-clusteredST_bold.json`   | Varying-TR sparse  | `VolumeTiming`, `SliceTiming`              | Volume onsets provided, with acquisition duration calculable from `SliceTiming`. |
| `sub-01_task-rest_acq-deprecated_bold.json`    | Varying-TR sparse  | `VolumeTiming`, `AcquisitionDuration`      | Volume onsets and constant acquisition duration provided.                        |

Note the `acq-deprecated` option, which uses the `AcquisitionDuration` field.
This field was identified with a DICOM field that has a distinct meaning from the meaning
used in BIDS, which more closely aligns with `FrameAcquisitionDuration`.
This form is still permitted by the validator, but should be migrated away from.

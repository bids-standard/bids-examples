## Introduction

Hierarchical Event Descriptors (HED) is BIDS' mechanism for providing 
dataset annotations and metadata in a machine-actionable way.
This means that tools can extract annotations automatically for analysis.
The purpose of the dataset is to demonstrate how to use HED in various ways.
BIDS allows HED to be used in any
[BIDS tabular file](https://bids-specification.readthedocs.io/en/stable/common-principles.html#tabular-files) (`.tsv`).

### What's in this dataset

This demo dataset is derived from a number of other datasets,
but particularly `ds003645` from openNeuro as well as the
`fnirs_automaticity`, `micro_SPIM`, and `motion_dualtask` datasets
from the [bids-examples](https://github.com/bids-standard/bids-examples)
GitHub repository.

| Subject | Session | Modalities illustrated     |
| ------- |---------|----------------------------|  
| sub-002 |         | eeg, beh, phenotype, scans | 
| sub-003 |         | eeg, phenotype, scans |
| sub-004 | ses-1   | eeg, anat, beh, micr, phenotype, scans |
| sub-004 | ses-2   | eeg, motion, phenotype, scans | 


### HED-supported files

HED supports these BIDS `.tsv` (and accompanying `.json`) files.
In all cases, HED automatically combines annotations in a `HED`
column of the `.tsv` file with annotations of column values
in the corresponding `.json` file.


| File                                | Use | 
|-------------------------------------|-----| 
| [`participants.tsv`](#participants) | Characteristics of participants. |
| `_events.tsv`                       | Descriptions of events in data. |
| `_scans.tsv`                        | Recording-wide experimental conditions, <br/>Experiment setup, start time, notes on a recording. |
| `_beh.tsv`                          | Responses to behavioral tasks. |
| `_channels.tsv`                     | Meaning of user-defined fields and notes about channels. |
| `samples.tsv`                       | Characteristics of samples associated with the dataset. |
| `phenotypes/`                       | Responses to questionnaires, medical and other information. |

This demo dataset illustrates HED's use in the above types of files.
The `.json` file contains two types of HED annotations.
**Categorical** annotations provide individual HED strings for each
unique column value. **Value** annotations provide a single
HED string with a `#` placeholder for the entire column.
When the annotations for a row of the `.tsv` file are assembled,
the column value is substituted for that placeholder.

Currently, HED ignores tabular files that correspond to continuous time series
and do not have column names
(e.g., `_motion.tsv`, `_physio.tsv`, and `_stim.tsv`).

### Participants
HED-annotated subject information contained in the BIDS-required 
[`participants.tsv`](https://bids-specification.readthedocs.io/en/stable/modality-agnostic-files.html#participants-file)
and its accompanying `participants.json` file can be extracted
as a HED string and then used in analysis for search or extracting design
matrices and contrasts.

The demo [`participants.json`](./participants.json) is:

```json
{
  "participant_id": {
    "LongName": "Participant identifier",
    "Description": "Unique dataset subject identifier",
    "HED": "(Experiment-participant, ID/#)"
  },
  "sex": {
    "Description": "Sex of the subject",
    "Levels": {
      "M": "male",
      "F": "female"
    },
    "HED": {
      "M": "Male",
      "F": "Female"
    }
  },
  "age": {
    "Description": "Age of the subject",
    "Units": "years",
    "HED": "Age/#"
  }
}
```

The `participant_id` and `age` column are annotated as value columns,
while `sex` is annotated as a value column.

In the demo, the first row of the [`partipants.tsv`](./participants.tsv) file is:

| participant_id | age | sex | HED |
| -------------- | --- | --- | --- |
| sub-002 | 31 | M | Healthy,Rested,Novice-level |

At validator or analysis time, the annotations for the columns of a `.tsv`
file are concatenated for a row in a comma-separated string. 
The HED annotation for the first row of the demo `participants.tsv` file is:

```code 
"(Experiment-participant, ID/sub-001),Age/3,Male,Healthy,Rested,Novide-level"
```

This annotation can then be used in downstream tools during analysis.

The parentheses in HED strings are meant to applicable modifiers with
the item being modified, in this case `ID/sub-001`.

We can use the HED curly brace notation to get a more desirable grouping.
If the HED annotation for the `participant_id` given in `participants.json` were:

```json
{
    "participant_id": {
        "LongName": "Participant identifier",
        "Description": "Unique dataset subject identifier",
        "HED": "(Experiment-participant, ID/#, {sex}, {age}, {HED})"
    }
}
```

then the `participant_id` annotation is treated like a template.
On assembly, the annotations for the `sex`, `age`, and `HED` columns
are inserted into the template, rather than concatenated:

```code
"(Experiment-participant, ID/sub-001),Age/3,Male,Healthy,Rested,Novide-level"
```

See [Assembly and curly braces](https://www.hed-resources.org/en/latest/HedAnnotationQuickstart.html#assembly-and-curly-braces)
in the [HED annotation quickstart](https://www.hed-resources.org/en/latest/HedAnnotationQuickstart.html#) for more information.
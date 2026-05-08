The following text is reproduced verbatim from version 1.7.0
of the Brain Imaging Data Structure (BIDS) specification:

    Example 1: Demonstration of inheritance principle

    ├─ sub-01/
    │  └─ func/
    │     ├─ sub-01_task-rest_acq-default_bold.nii.gz 
    │     ├─ sub-01_task-rest_acq-longtr_bold.nii.gz 
    │     └─ sub-01_task-rest_acq-longtr_bold.json 
    └─ task-rest_bold.json 

    Contents of file task-rest_bold.json:
    {
        "EchoTime": 0.040,
        "RepetitionTime": 1.0
    }
    Contents of file sub-01/func/sub-01_task-rest_acq-longtr_bold.json:
    {
        "RepetitionTime": 3.0
    }
    When reading image sub-01/func/sub-01_task-rest_acq-default_bold.nii.gz, only metadata file task-rest_bold.json is read; file sub-01/func/sub-01_task-rest_acq-longtr_bold.json is inapplicable as it contains entity "acq-longtr" that is absent from the image path (rule 2.c).
    When reading image sub-01/func/sub-01_task-rest_acq-longtr_bold.nii.gz, metadata file task-rest_bold.json at the top level is read first, followed by file sub-01/func/sub-01_task-rest_acq-longtr_bold.json at the bottom level (rule 5.b); the value for field "RepetitionTime" is therefore overridden to the value 3.0. The value for field "EchoTime" remains applicable to that image, and is not unset by its absence in the metadata file at the lower level (rule 5.b; corollary 3).

The following text is reproduced verbatim from version 1.7.0
of the Brain Imaging Data Structure (BIDS) specification:

    Example 2: Impermissible use of multiple metadata files at one directory level (rule 4)

    └─ sub-01/
       └─ ses-test/
          ├─ anat/
          │  └─ sub-01_ses-test_T1w.nii.gz
          └─ func/
             ├─ sub-01_ses-test_task-overtverbgeneration_run-1_bold.nii.gz
             ├─ sub-01_ses-test_task-overtverbgeneration_run-2_bold.nii.gz
             ├─ sub-01_ses-test_task-overtverbgeneration_bold.json
             └─ sub-01_ses-test_task-overtverbgeneration_run-2_bold.json

Notes:

-   This example is intentionally in violation of the Inheritance Principle
    for the version against which it was devised.
    For data file "sub-01_ses-test_task-overtverbgeneration_run-2_bold.nii.gz",
    both metadata JSON files in the dataset are considered applicable
    based on the entities / suffix / location in the filesystem hierarchy.
    This is however impermissible specifically because they are at the *same*
    location in the filesystem hierarchy.
    It is therefore expected that this dataset should fail tests performed
    based on the ruleset of the Inheritance Principle for this specification version.

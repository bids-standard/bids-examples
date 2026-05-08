From the relevant section of version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Example 1: Two JSON files at same level that are applicable for NIfTI file.

    sub-01/
        ses-test/
            sub-test_task-overtverbgeneration_bold.json
            sub-test_task-overtverbgeneration_run-2_bold.json
            anat/
                sub-01_ses-test_T1w.nii.gz
            func/
                sub-01_ses-test_task-overtverbgeneration_run-1_bold.nii.gz
                sub-01_ses-test_task-overtverbgeneration_run-2_bold.nii.gz
    In the above example, two JSON files are listed under sub-01/ses-test/, which are each applicable to sub-01_ses-test_task-overtverbgeneration_run-2_bold.nii.gz, violating the constraint that no more than one file may be defined at a given level of the directory structure. Instead task-overtverbgeneration_run-2_bold.json should have been under sub-01/ses-test/func/.

Notes:

-   The filesystem layout described in the specification is erroneous.
    Files "sub-test_task-overtverbgeneration*_bold.json" erroneously combine entities
    "sub-01" and "ses-test" implied by the directory structure
    into entity "sub-test" in the file names.
    This error is corrected in this realised dataset.

-   This dataset *incorporates* the suggestion made at the end of this section
    of how to modify the filesystem layout in order to make the dataset conformant.

    The actual layout of this dataset is therefore:

    sub-01/
        ses-test/
            sub-01_ses-test_task-overtverbgeneration_bold.json
            anat/
                sub-01_ses-test_T1w.nii.gz
            func/
                sub-01_ses-test_task-overtverbgeneration_run-1_bold.nii.gz
                sub-01_ses-test_task-overtverbgeneration_run-2_bold.json
                sub-01_ses-test_task-overtverbgeneration_run-2_bold.nii.gz

    As such, this dataset is expected to be determined conformant.

-   The (fixed) dataset as originally described in the specification,
    absent the rectification described above to conform specifically to the Inheritance Principle,
    is realised in sister dataset "ip112e1bad".

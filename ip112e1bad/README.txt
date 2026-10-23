The following exerpt is duplicated from version 1.1.2
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

-   There is an error in the filesystem structure shown.
    Files "sub-test_task-overtverbgeneration_*bold.json" erroneously combine
    entities "sub-01" and "ses-test" implied by the directory structure
    into entity "ses-test" in these file names.
    This error is rectified in the realised dataset,
    as it is not the aspect of specification non-conformity that is of interest.

-   This dataset is *intended to be non-conformant*.
    Its evaluation under the ruleset of the Inheritance Principle
    corresponding to this version of the specification
    should therefore fail.

-   The "Instead ... " proposal as to how this exemplar dataset
    should be modified in order to become conformant
    is realised in sister dataset "ip112e1good".

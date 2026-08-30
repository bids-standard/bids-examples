The following text is duplicated verbatim from version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Example 2: Multiple run and rec with same acquisition (acq) parameters acq-test1

    sub-01/
        anat/
        func/
            sub-01_task-xyz_acq-test1_run-1_bold.nii.gz
            sub-01_task-xyz_acq-test1_run-2_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon1_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon2_bold.nii.gz
            sub-01_task-xyz_acq-test1_bold.json

    For the above example, all NIfTI files are acquired with same scanning parameters (acq-test1). Hence a JSON file describing the acq parameters will apply to different runs and rec files. Also if the JSON file (task-xyz_acq-test1_bold.json) is defined at dataset top level directory, it will be applicable to all task runs with test1 acquisition parameter.

Notes:

-   The filesystem structure described in the specification above
    is replicated verbatim in sister dataset "ip112e2v1".

-   This dataset is the realisation of the proposed alternative configuration
    described at the end of the quoted text.
    As such, the actual filesystem structure is:

    task-xyz_acq-test1_bold.json
    sub-01/
        anat/
        func/
            sub-01_task-xyz_acq-test1_run-1_bold.nii.gz
            sub-01_task-xyz_acq-test1_run-2_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon1_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon2_bold.nii.gz

-   The quoted description regarding the proposed alternative filesystem layout is incomplete.
    The text refers to "... the JSON file (task-xyz_acq-test1_bold.json)";
    however this file does not exist in the filesystem structure shown.
    What was presumably intended by the author
    was that file "sub-01/func/sub-01_task-xyz_acq-test1_bold.json"
    could be *moved* to "task-xyz_acq-test1_bold.json" at the root of the dataset.
    This is what is realised in this dataset.

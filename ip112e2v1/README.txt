The following text is copied verbatim from version 1.1.2
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

-   This particular dataset recapitulates the filesystem structure shown in the specification verbatim.
    Sister dataset "ip112e2v2" realises the suggested modification
    at the end of the text description.

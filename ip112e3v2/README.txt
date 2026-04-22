The following text is reproduced versbation from version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Case 2: Multiple json files at different levels for same task and acquisition parameters

    sub-01/
        sub-01_task-xyz_acq-test1_bold.json
        anat/
        func/
            sub-01_task-xyz_acq-test1_run-1_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon1_bold.nii.gz
            sub-01_task-xyz_acq-test1_rec-recon2_bold.nii.gz

    In the above example, the fields from task-xyz_acq-test1_bold.json file will apply to all bold runs. However, if there is a key with different value in sub-01/func/sub-01_task-xyz_acq-test1_run-1_bold.json, the new value will be applicable for that particular run/task NIfTI file/s.

Notes:

-   This version of the specification erroneously refers to this example as "Case 2",
    incongruent with prior items "Example 1" and "Example 2".
    This dataset has instead been named "ip112e3v2" and described as "the third example"
    provided in this version of the specification.

-   The filesystem structure in this example was erroneously formatted.
    everything below file "sub-01_task-xyz_acq-test1_bold.json" is erroneously indented
    as though that item is a directory rather than a file.
    Empty directory "sub-01/anat/" also should not have been shown.

-   Use of the "run" and "rec" entities was erroneous in this example.
    The "run" entity should only be used in the presence of repeated acquisitions
    from the same sequence where no acquisition parameters differ.
    The "rec" entity should distinguish between different image reconstructions
    from the same acquisition;
    however here, because files "sub-01_task-xyz_acq-test1_rec-recon*_bold.nii.gz"
    do *not* match file "sub-01_task-xyz_acq-test1_run-1_bold.nii.gz" due to absence of the "run" entity,
    the relationships between these data files is ambiguous.
    These have nevertheless been overlooked in the production of this exemplar dataset,
    where the purpose is only defining the behaviour of the Inheritance Principle.

-   This exemplar dataset realises the proposed modification at the end of the description text.
    The actual filesystem structure is therefore:

    sub-01/
       sub-01_task-xyz_acq-test1_bold.json
       anat/
       func/
           sub-01_task-xyz_acq-test1_run-1_bold.json
           sub-01_task-xyz_acq-test1_run-1_bold.nii.gz
           sub-01_task-xyz_acq-test1_rec-recon1_bold.nii.gz
           sub-01_task-xyz_acq-test1_rec-recon2_bold.nii.gz

    Further, files "sub-01/sub-01_task-xyz_acq-test1_bold.json"
    and "sub-01/func/sub-01_task-xyz_acq-test1_run-1_bold.json"
    are not empty, but contain metadata fields
    intended to demonstrate the overloading of metadata fields.
    Sister dataset "ip112e3v1" shows this same exemplar
    without the integration of this proposed modification.

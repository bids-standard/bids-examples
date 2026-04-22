The following exerpt is duplicated from version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Files for a particular participant can exist only at participant level directory,
    i.e /dataset/sub-*[/ses-*]/sub-*_T1w.json.
    Similarly, any file that is not specific to a participant is to be declared
    only at top level of dataset
    for eg: task-sist_bold.json must be placed under /dataset/task-sist_bold.json.

The following exerpt is duplicated from version 1.7.0
of the Brain Imaging Data Structure (BIDS) specification:

    2.  For a given data file, any metadata file is applicable to that data file if:

        a.  It is stored at the same directory level or higher;
        b.  The metadata and the data filenames possess the same suffix;
        c.  The metadata filename does not include any entity absent from the data filename.

    3.  A metadata file MUST NOT have a filename that would be otherwise applicable to some data file based on rules 2.b and 2.c but is made inapplicable based on its location in the directory structure as per rule 2.a.

Notes:

-   This particular example dataset has been engineered in such a way
    that it would satisfy the criteria described in BIDS 1.1.2
    but fail the rule introduced in BIDS 1.7.0.
    File "sub-01/ses-01/anat/sub-01_T1w.json" is "in a participant level directory",
    and its entities match file "sub-01/ses-02/anat/sub-01_ses-02_T1w.nii.gz",
    yet it can't be associated with that data file due to not being within one of its parent directories.

-   Similarly to dataset "ip112badmetapathe*",
    there are intentionally two T1w runs included in this dataset
    in order to prevent unwanted warnings relating to an
    exclusively-matched non-sidecar data-metadata file pair.

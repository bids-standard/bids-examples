The following exerpt is duplicated from version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Files for a particular participant can exist only at participant level directory,
    i.e /dataset/sub-*[/ses-*]/sub-*_T1w.json.
    Similarly, any file that is not specific to a participant is to be declared
    only at top level of dataset
    for eg: task-sist_bold.json must be placed under /dataset/task-sist_bold.json.

Notes:

-   There are two potential issues with the issue as described:
    
    -   The T1-weighted image is not placed inside the "anat/" modality directory
        as would be conventionally expected / is most common,
        and the file name fails to account for the potential presence of the "ses" entity.
        The example path would more suitably have been:
        /dataset/sub-*[/ses-*]/anat/sub-*[_ses-*]_T1w.json.

    -   The description fails to clarify that such files can be placed
        only within *one of* potentially *multiple* "participant-level directories".
        As exemplified by other Inheritance Principle examples,
        it is permissible for metadata files to exist at a filesystem location
        other than the lowest level modality directory.
        The description fails to convey the fact that the example filesystem path presented
        is only one of multiple possible parent directories for such a file;
        for instance, location /dataset/sub-*[/ses-*]/sub-*[_ses-*]_T1w.json
        is technically permissible also.

-   This particular dataset exemplifies violation of the first criterion.
    Violation of the second criterion is exemplified
    in sister datasets "ip112badmetapathe2v1" and "ip112badmetapathe2v2".

-   There are intentionally two T1w runs for sub-01
    so that the dataset does not trigger a warning
    regarding an exclusively-matched non-sidecar data-metadata file pair.

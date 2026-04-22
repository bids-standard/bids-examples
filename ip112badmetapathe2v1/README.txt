The following exerpt is duplicated from version 1.1.2
of the Brain Imaging Data Structure (BIDS) specification:

    Files for a particular participant can exist only at participant level directory,
    i.e /dataset/sub-*[/ses-*]/sub-*_T1w.json.
    Similarly, any file that is not specific to a participant is to be declared
    only at top level of dataset
    for eg: task-sist_bold.json must be placed under /dataset/task-sist_bold.json.

Notes:

-   This particular dataset exemplifies violation of the second criterion.
    Violation of the first criterion is exemplified in sister dataset "ip112badmetapathe1".

-   In this first version of the example,
    the derivative Inheritance Principle criterion
    defined in version 1.7.0 of the specification
    *is* also violated,
    as the erroneous placement of the participant-agnosticcally-named metadata file
    is violated by the presence of another participant to which the metadata file name matches.
    A modified version of this example,
    where that corresponding 1.7.0 version criterion is *not* violated,
    is presented in sister dataset "ip112badmetapathe1v2".

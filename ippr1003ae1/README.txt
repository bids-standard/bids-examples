The following text is reproduced from GitHub repository "bids-specification"
within organisation "bids-standard",
specifically Pull Request #1003,
which was rejected for merge
(more details at https://github.com/bids-standard/bids-specification/pull/1003/files):

    ### Example 1: Complex inheritance scenario

    {
    "bold.json": "",
    "sub-01": {
        "ses-01": {
            "func": {
                "sub-01_ses-01_bold.json": "",
                "sub-01_ses-01_task-ovg_bold.json": "",
                "sub-01_ses-01_task-ovg_run-1_bold.nii.gz": "",
                "sub-01_ses-01_task-ovg_run-2_bold.nii.gz": "",
                "sub-01_ses-01_task-ovg_run-2_bold.json": "",
                "sub-01_ses-01_task-rest_bold.nii.gz": "",
                "sub-01_ses-01_task-rest_bold.json": "",
                }
            },
        "ses-02": {
            "func": {
                "sub-01_ses-02_task-ovg_bold.nii.gz": "",
                "sub-01_ses-02_task-rest_bold.nii.gz": "",
                }
            },
        "sub-01_bold.json": "",
        },
    "sub-02": {
        "ses-01": {
            "func": {
                "sub-02_ses-01_task-rest_bold.nii.gz": "",
                "sub-02_ses-01_task-rest_bold.json": "",
                }
            }
        },
    "task-ovg_bold.json": "",
    "task-rest_bold.json": "",
    }

    ### Applicable data files per metadata file

    For each metadata file, the set of data files to which its contents are
    applicable is as follows:

    -   `bold.json`:
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz`
        -   `sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.nii.gz`

    -   `task-ovg_bold.json`:
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz`

    -   `task-rest_bold.json`:
        -   `sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz`
        -   `sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.nii.gz`

    -   `sub-01/sub-01_bold.json`:
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz`
        -   `sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz`

    -   `sub-01/ses-01/sub-01_ses-01_bold.json`:
        -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`
        -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`
        -   `sub-01/ses-01/sub-01_ses-01_task-rest_bold.nii.gz`

    -   `sub-01/ses-01/sub-01_ses-01_task-ovg_bold.json`:
        -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`
        -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`

    -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.json`:
        -   `sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`

    -   `sub-01/ses-01/sub-01_ses-01_task-rest_bold.json`:
        -   `sub-01/ses-01/sub-01_ses-01_task-rest_bold.nii.gz`

    -   `sub-02/ses-01/sub-02_ses-01_task-rest_bold.json`:
        -   `sub-02/ses-01/sub-02_ses-01_task-rest_bold.nii.gz`

    ### Applicable metadata files per data file

    For each data file, the order in which the set of applicable metadata
    files would be loaded is as follows:

    -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz`:
        -   `bold.json`
        -   `task-ovg_bold.json`
        -   `sub-01/sub-01_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_bold.json`
    -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_bold.json`

    -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz`:
        -   `bold.json`
        -   `task-ovg_bold.json`
        -   `sub-01/sub-01_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.json`

    -   `sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz`:
        -   `bold.json`
        -   `task-rest_bold.json`
        -   `sub-01/sub-01_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_bold.json`
        -   `sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.json`

    -   `sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz`:
        -   `bold.json`
        -   `task-ovg_bold.json`
        -   `sub-01/sub-01_bold.json`

    -   `sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz`:
        -   `bold.json`
        -   `task-rest_bold.json`
        -   `sub-01/sub-01_bold.json`

    -   `sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.nii.gz`:
        -   `bold.json`
        -   `task-rest_bold.json`
        -   `sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.json`
        
Notes:

-   There are errors in the metadata association information
    in the quoted text;
    mostly arising from omission of the "func/" parent.
    These are rectified in file "sourcedata/ip_graph.json".                

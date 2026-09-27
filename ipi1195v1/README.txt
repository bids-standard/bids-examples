The following content is duplicated from a fork
of the Brain Imaging Data Structure (BIDS) specification.
It is referenced in GitHub Issue #1195
(https://github.com/bids-standard/bids-specification/issues/1195),
and the code is located at:
https://github.com/Lestropie/bids-specification/pull/5.

    {
    "bold.json",
    "sub-01": {
        "ses-01": {
            "func": {
                "sub-01_ses-01_bold.json",
                "sub-01_ses-01_task-ovg_bold.json",
                "sub-01_ses-01_task-ovg_run-1_bold.nii.gz",
                "sub-01_ses-01_task-ovg_run-2_bold.nii.gz",
                "sub-01_ses-01_task-ovg_run-2_bold.json",
                "sub-01_ses-01_task-rest_bold.nii.gz",
                "sub-01_ses-01_task-rest_bold.json"
            }
        },
        "ses-02": {
            "func": { 
                "sub-01_ses-02_task-ovg_bold.nii.gz",
                "sub-01_ses-02_task-rest_bold.nii.gz",
            }
        },
        "sub-01_bold.json"
    },
    "sub-02": {
        "ses-01": {
            "func": {
                "sub-02_ses-01_res-high_task-olr_bold.nii.gz",
                "sub-02_ses-01_res-high_task-rest_bold.nii.gz",
                "sub-02_ses-01_res-high_bold.json",
                "sub-02_ses-01_res-low_task-olr_bold.nii.gz",
                "sub-02_ses-01_res-low_task-rest_bold.nii.gz",
                "sub-02_ses-01_res-low_bold.json",
                "sub-02_ses-01_task-olr_bold.json",
                "sub-02_ses-01_task-rest_bold.json"
            }
        }
    }, 
    "task-olr_bold.json",
    "task-ovg_bold.json",
    "task-rest_bold.json"
    }

    Applicable data files per metadata file
    For each metadata file, the set of data files to which its contents are applicable is as follows:

    -   bold.json:

        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz
        -   sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz
        -   sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.nii.gz

    -   task-olr_bold.json:

        -   sub-02/ses-01/func/sub-02_ses-01_res-high_task-olr_bold.nii.gz
        -   sub-02/ses-01/func/sub-02_ses-01_res-low_task-olr_bold.nii.gz

    -   task-ovg_bold.json:

        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz

    -   task-rest_bold.json:
        
        -   sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz
        -   sub-02/ses-01/func/sub-02_ses-01_res-high_task-rest_bold.nii.gz
        -   sub-02/ses-01/func/sub-02_ses-01_res-low_task-rest_bold.nii.gz

    -   sub-01/sub-01_bold.json:

        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz
        -   sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz
        -   sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz

    -   sub-01/ses-01/sub-01_ses-01_bold.json:

        -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-1_bold.nii.gz
        -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz
        -   sub-01/ses-01/sub-01_ses-01_task-rest_bold.nii.gz

    -   sub-01/ses-01/sub-01_ses-01_task-ovg_bold.json:

        -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-1_bold.nii.gz
        -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz

    -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.json:

        -   sub-01/ses-01/sub-01_ses-01_task-ovg_run-2_bold.nii.gz

    -   sub-01/ses-01/sub-01_ses-01_task-rest_bold.json:

        -   sub-01/ses-01/sub-01_ses-01_task-rest_bold.nii.gz

    -   sub-02/ses-01/sub-02_ses-01_res-high_bold.json:

        -   sub-02/ses-01/sub-02_ses-01_res-high_task-olr_bold.nii.gz
        -   sub-02/ses-01/sub-02_ses-01_res-high_task-rest_bold.nii.gz

    -   sub-02/ses-01/sub-02_ses-01_res-low_bold.json:

        -   sub-02/ses-01/sub-02_ses-01_res-low_task-olr_bold.nii.gz
        -   sub-02/ses-01/sub-02_ses-01_res-low_task-rest_bold.nii.gz

    -   sub-02/ses-01/sub-02_ses-01_task-olr_bold.json:

        -   sub-02/ses-01/sub-02_ses-01_res-high_task-olr_bold.nii.gz
        -   sub-02/ses-01/sub-02_ses-01_res-low_task-olr_bold.nii.gz

    -   sub-02/ses-01/sub-02_ses-01_task-rest_bold.json:

        -   sub-02/ses-01/sub-02_ses-01_res-high_task-rest_bold.nii.gz
        -   sub-02/ses-01/sub-02_ses-01_res-low_task-rest_bold.nii.gz

    Applicable metadata files per data file
    For each data file, the order in which the set of applicable metadata files would be loaded is as follows:

    -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-1_bold.nii.gz:

        -   bold.json
        -   task-ovg_bold.json
        -   sub-01/sub-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_bold.json

    -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.nii.gz:

        -   bold.json
        -   task-ovg_bold.json
        -   sub-01/sub-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_task-ovg_run-2_bold.json

    -   sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.nii.gz:

        -   bold.json
        -   task-rest_bold.json
        -   sub-01/sub-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_bold.json
        -   sub-01/ses-01/func/sub-01_ses-01_task-rest_bold.json

    -   sub-01/ses-02/func/sub-01_ses-02_task-ovg_bold.nii.gz:

        -   bold.json
        -   task-ovg_bold.json
        -   sub-01/sub-01_bold.json

    -   sub-01/ses-02/func/sub-01_ses-02_task-rest_bold.nii.gz:

        -   bold.json
        -   task-rest_bold.json
        -   sub-01/sub-01_bold.json

    -   sub-02_ses-01_res-high_task-olr_bold.nii.gz:

        -   bold.json
        -   task-olr_bold.json
        -   sub-02/ses-01/func/sub-02_ses-01_res-high_bold.json
            and sub-02/ses-01/func/sub-02_ses-01_task-olr_bold.json
            (ambiguous order)

    -   sub-02_ses-01_res-high_task-rest_bold.nii.gz:

        -   bold.json
        -   task-rest_bold.json
        -   sub-02/ses-01/func/sub-02_ses-01_res-high_bold.json
            and sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.json
            (ambiguous order)

    -   sub-02_ses-01_res-low_task-olr_bold.nii.gz:

        -   bold.json
        -   task-olr_bold.json
        -   sub-02/ses-01/func/sub-02_ses-01_res-low_bold.json
            and sub-02/ses-01/func/sub-02_ses-01_task-olr_bold.json
            (ambiguous order)

    -   sub-02_ses-01_res-low_task-rest_bold.nii.gz:

        -   bold.json
        -   task-rest_bold.json
        -   sub-02/ses-01/func/sub-02_ses-01_res-low_bold.json
            and sub-02/ses-01/func/sub-02_ses-01_task-rest_bold.json
            (ambiguous order)

Notes:

-   In this version of the dataset,
    key-value metadata has been added to show which files are inherited from.
    There are no metadata key-value overrides;
    as such the dataset should pass validation under this Inheritance Principle ruleset.
    Sister dataset "ipi1195v2" shows the same filesystem structure,
    but involves inherently ambiguous metadata key-value overrides.

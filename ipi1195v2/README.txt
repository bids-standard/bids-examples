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

-   This is an alternative to the dataset shown above,
    designed to highlight how preserving the ability
    to overwrite metadata key-values at lower levels of the hierarchy
    results in ambiguities,
    and therefore such overloading would need to be precluded in the specification.
    There are multiple key-value metadata fields used to demonstrate this,
    all beginning with the string "Lowest*".
    In some circumstances there is fundamental ambiguity in the order
    in which key-value metadata files should be read;
    see eg. ""LowestBOLD": null" in file sourcedata/ip_metadata.json.
    This example dataset should therefore fail validation
    due to the presence of overloads.
    Sister dataset "ipi1195v1" shows the original dataset without any overloading,
    which should pass validation under that ruleset without issue.

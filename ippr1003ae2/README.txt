The following text is reproduced from GitHub repository "bids-specification"
within organisation "bids-standard",
specifically Pull Request #1003,
which was rejected for merge
(more details at https://github.com/bids-standard/bids-specification/pull/1003/files):

    ### Example 2: Violation due to order ambiguity

    {
    "sub-01": {
        "func": {
            "sub-01_acq-highres_bold.json": "",
            "sub-01_acq-lowres_bold.json": "",
            "sub-01_bold.json": "",
            "sub-01_task-ovg_bold.json": "",
            "sub-01_task-ovg_acq-highres_bold.nii.gz": "",
            "sub-01_task-ovg_acq-lowres_bold.nii.gz": "",
            "sub-01_task-rest_bold.json": "",
            "sub-01_task-rest_acq-highres_bold.nii.gz": "",
            "sub-01_task-rest_acq-lowres_bold.nii.gz": "",
            }
        }
    }

    Data file `sub-01_ses-01_task-ovg_acq-highres_bold.nii.gz` has three metadata
    files deemed applicable according to rule 2, all residing within the same directory: (
    `sub-01_bold.json`,
    `sub-01_task-ovg_bold.json`,
    `sub-01_acq-highres_bold.json`).
    It is however impossible to determine a unique ordering of these files that
    satisfies rule 4.a. The metadata contents to be associated with this data file
    would be ambiguous if files `sub-01_task-ovg_bold.json` and `sub-01_acq-highres_bold.json`
    were to contain differing values for the same key, as the ambiguous order in which
    they were loaded would determine those contents.

Notes:

-   This example dataset was synthesized specifically to demonstrate
    violation of the Inheritance Principle
    *even after* integration of the proposed ruleset changes in Pull Request #1003.
    It should therefore fail when validated against that ruleset.
    This does not however mean that it should fail against *all* rulesets.

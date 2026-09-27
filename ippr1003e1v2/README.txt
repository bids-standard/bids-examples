The following text is reproduced from GitHub repository "bids-specification"
within organisation "bids-standard",
specifically Pull Request #1003,
which was rejected for merge
(more details at https://github.com/bids-standard/bids-specification/pull/1003/files):

    Example 1: Single metadata file applicable to multiple data files

    {
    "sub-01": {
        "anat": {
            "sub-01_part-real_T2starw.nii.gz",
            "sub-01_part-imag_T2starw.nii.gz",
            "sub-01_T2starw.json",
            }
        }
    }

    For file `sub-01_T2starw.json`, there does not exist an immediately corresponding data file
    with the same basename but different file extension; for instance `sub-01_T2starw.nii.gz`.
    It is however applicable to both data files `sub-01_part-real_T2starw.nii.gz` and
    `sub-01_part-imag_T2starw.nii.gz`, since it possesses the same suffix "`T2starw`"
    and its entities are a subset of those present in the data filename in both cases.
    This storage structure is appropriate for such data given that the real and imaginary
    components of complex image data would be yielded by a single execution of an MRI sequence,
    with a fixed common set of acquisition parameters.

Notes:

-   This exemplar dataset presents an alternative scenario to the text description,
    where the complex data are encoded as a magnitude-phase image pair
    instead of the shown real-imaginary pair.
    
    The actual filesystem structure of this dataset is instead:

{
    "sub-01": {
        "anat": {
            "sub-01_part-mag_T2starw.nii.gz",
            "sub-01_part-phase_T2starw.json",
            "sub-01_part-phase_T2starw.nii.gz",
            "sub-01_T2starw.json",
            }
        }
    }

-   This distinction has consequences with respect to the Inheritance Principle.
    Under the initial definition of the Inheritance Principle,
    this filesystem structure would be invalid:
    data file "sub-01_part-phase_T2starw.nii.gz"
    has two potentially applicable JSON metadata files,
    but these two files reside at the same level in the filesystem hierarchy,
    which is in violation of Rule 4.
    Pull Request #1003 included modifications to the Inheritance Principle itself
    that would make this structure permissible;
    whether or not this dataset passes validation
    will therefore depend on which ruleset is specified during the validation.

-   Sister dataset "ippr1003e1v1" shows the quoted example reproduced verbatim.

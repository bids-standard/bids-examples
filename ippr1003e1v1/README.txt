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

-   This exemplar dataset reproduces the description verbatim.
    A sister dataset "ippr1003e1v2" shows a related scenario omitted from this Pull Request,
    where the complex data are stored as a magnitude-phase pair rather than a real-imaginary pair.

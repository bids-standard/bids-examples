This example demonstrates the overloading of non-JSON metadata.
For images "sub-01/dwi/sub-01_acq-default_run-*_dwi.nii.gz",
the "default" DWI gradient table stored in "dwi.bvec" & "dwi.bval" is used.
For image "sub-01/dwi/sub-01_acq-nonstandard_dwi.nii.gz",
there are sidecar gradient table files;
the latter should be what is associated *exclusively* with that image.

This example is crafted in such a way
that the dataset conforms to the Inheritance Principle as written in BIDS 1.x.
It does involve the overriding of metadata,
only in the form of DWI gradient table data rather than key-value metadata.
But because the diffusion gradient table files are at different levels
within the filesystem hierarchy,
the suitable files to use can be determined based on that specification.
Sister dataset "ipdwi003" shows a very similar scenario
that vioates the 1.x specification
but can be deemed acceptable by proposed augmentations to the Principle.

There are two runs of the "acq-default" image included intentionally:
if only one such run were specified,
then the dataset would raise a warning unrelated to the purpose of the dataset,
due to an exclusive non-sidecar data-metadata pairing.

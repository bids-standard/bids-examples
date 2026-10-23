This exemplar dataset has not at time of writing been contributed
or proposed to any version of the Brain Imaging Data Structure (BIDS) specification.
It was created to demonstrate a hypothetical dataset structure
that would be deemed valid given all current Inheritance Principle criteria,
but should perhaps be forbidden in future iterations.

It shows the scenario where there is a data file
for which there is only one applicable JSON metadata file,
and that JSON metadata file is only applicable to that one data file.
One would intuitively expect that such data would be specified as a sidecar pair,
with their filesystem paths differing only by file extension.
However it is technically possible for this situation to arise
despite those two files not being a sidecar pair.

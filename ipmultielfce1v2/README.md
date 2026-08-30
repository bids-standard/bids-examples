This dataset exemplifies an issue whereby the 1.x version of the specification
has difficulty in capturing data wherein there are multiple intersecting
Entity-Linked File Collections.

An Entity-Linked File Collection is a set of files containing at least two data files,
wherein the entities within their file names differ only by the value for one specific entity.
Examples include complex data that are split into eg. "_part-mag" and "_part-phase",
and multi-echo data that are split into "_echo-#".
This formalism however fails to consider the fact that there may be sets of files
that intersect along multiple such entities.
THis dataset shows the example of a multi-echo fMRI acquisition where complex data are saved.
While there is no issue in deriving file names for these images,
under version 1.x of the BIDS specification it becomes impossible to appropriately exploit this structure
to store redundant metadata in higher-level JSON files to be applicable via the Inheritance Principle,
as a data file cannot inherit from multiple such files at a single level in the filesystem hierarchy.

This dataset show how such data could plausibly be stored in a future BIDS specification.
It should be deemed invalid if evaluated under the 1.x version of the Inheritance Principle.
Sister dataset "ipmultielfce1v1" shows these same data without any exploitation of the Inheritance Principle,
which should be deemed valid under BIDS 1.x.

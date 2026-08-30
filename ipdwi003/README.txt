This example demonstrates tehe overloading of non-JSON metadata
where there are multiple applicable metadata files for a data file
within a single level of the filesystem hierarchy.
Because of this,
the dataset is not valid under any tagged version of the BIDS specification
at time of writing;
it may however be considered permissible
under proposed future augmentations of the Inheritance Principle
(see for example Pull Request #1003 and Issue #1195:
https://github.com/bids-standard/bids-specification/pull/1003
https://github.com/bids-standard/bids-specification/issues/1195

This dataset is very similar to sister dataset "ipdwi002".
The difference is that in "ipdwi002",
the multiple applicable diffusion gradient table files
are placed at different levels of the filesystem hierarchy,
whereas here in "ipdwi003" they are at the same level.
The precedence of these files must therefore be made
by a speculative Inheritance Principle ruleset
based not exclusively by directory, but also by file name.

There are two runs of the "acq-default" image included intentionally:
if only one such run were specified,
then the dataset would raise a warning unrelated to the purpose of the dataset,
due to an exclusive non-sidecar data-metadata pairing.

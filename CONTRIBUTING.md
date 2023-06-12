# Welcome to the bids-examples repository!

Below, we note down some helpful information for contributors.

## What does a dataset maintainer do?

A maintainer of a dataset is responsible for keeping the dataset up to date,
and making sure that all updates are mirrored between the dataset with
full size raw data
(for example, as hosted on [OpenNeuro](https://openneuro.org)),
and the bids-example dataset with 0kb size (empty) raw data.

Typically an update to a BIDS dataset may be required,
if the [bids-validator](https://github.com/bids-standard/bids-validator)
is updated and gets an increased coverage of BIDS aspects to validated.
In such cases, the new validator may reveal bugs that have gone undetected
in the previous validation.

## Why do we only host truncated data with 0kb size?

The datasets in the bids-examples repository are intended for lightweight
testing purposes only. Keeping the data volume low allows for fast download
times and a low memory footprint in the tests these data are used for.

Admittedly, these advantages come at the expense of reduced testing
functionality. Because the tests cannot go beyond very basic checks of
filenames and directory structures.

To provide a remedy for that, we provide some datasets with intact data headers,
see the [Dataset Index Table](./README.md#dataset-index).

## How to truncate data files to 0kb

You can always write a custom script in your favourite programming language,
but if you need a quick and simple way and have access to a unix based machine
(e.g., OSX, Linux), you can use the `find` command line tool:

```Bash
find <path_to_ds> -type f -name '*.fif' -exec truncate -s 0 {} +
```

which means:

-   in this directory `<path_to_ds>`
-   ... find everything of type "file" (or specify `d` for directory, ...)
-   [optional] ... use `-name` with wildcard `*` to match to particular file types
-   ... for each file, execute something
-   ... namely, truncate the file
-   ... to size 0
-   `{}` is where a file name is put automatically (do not modify it)
-   `+` means, this is performed not file-wise but with a bunch of files at once.
    Could also be `\;` to have it one after the other

## How to generate the tables in the readme 

Note that these steps must be executed whenever a new dataset is added to the repository.

1. Edit the `dataset_listing.tsv` file to add or update datasets from the table.
1. Install all the necessary dependencies: `pip install -r tools/requirements.txt`
1. Then run the script: `python tools/print_dataset_listing.py`
1. Finally, `git commit` all changes and `git push` them to your remote (for example when you are working on a Pull Request)

## How to make a release

We release `bids-examples` in sync with `bids-specification`.

1. Make sure your local repository is up to date: `git fetch upstream`
   (this assumes you have the `bids-standard/bids-examples` repository
    configured as a git remote called "upstream")
1. Tag the `master` branch: `git tag -a -m "X.X.X" X.X.X upstream/master`
   (replace `X.X.X` with the version to be released)
1. Push the tag upstream: `git push upstream X.X.X`
1. Create a GitHub release using the new tag. Fill the title of the release
   with the name of the tag. Fill the description of the release with a sentence like
   > "Microscopy" BEP was merged into BIDS-specification (2022-02-15).
1. You are done!

# Welcome to the bids-examples repository!

Below, we note down some helpful information for contributors.

## Why do we only host truncated data with 0kb size?

The datasets in the bids-examples repository are intended for lightweight
testing purposes only. Keeping the data volume low allows for fast download
times and a low memory footprint in the tests these data are used for.

Admittedly, these advantages come at the expense of reduced testing
functionality. Because the tests cannot go beyond very basic checks of
filenames and directory structures.

To provide a remedy for that, we provide some datasets with intact data headers,
see the [Dataset Index Table](https://github.com/bids-standard/bids-examples/blob/master/README.md#dataset-index).

## How to truncate data files to 0kb

You can always write a custom script in your favourite programming language,
but if you need a quick and simple way and have access to a unix based machine
(e.g., OSX, Linux), you can use the `find` command line tool:

```Bash
find <path_to_ds> -type f -name '*.fif' -exec truncate -s 0 {} +
```

which means:
- in this directory `<path_to_ds>`
- ... find everything of type "file" (or specify `d` for directory, ...)
- [optional] ... use `-name` with wildcard `*` to match to particular file types
- ... for each file, execute something
- ... namely, truncate the file
- ... to size 0
- `{}` is where a file name is put automatically (do not modify it)
- `+` means, this is performed not file-wise but with a bunch of files at once.
  Could also be `\;` to have it one after the other

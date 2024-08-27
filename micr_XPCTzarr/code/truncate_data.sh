#!/bin/bash
# Bash script to truncate all the files containing the binary chunked data as per ../../CONTRIBUTING.md
# Modified from ../../CONTRIBUTING.md

find ../sub-LADAF-2020-31/ses-01/micr/sub-LADAF-2020-31_ses-01_sample-brain_XPCT.ome.zarr/ -type f -regex ".*/[0-9]*" -exec truncate -s 0 {} +

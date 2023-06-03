"turn makdown tables into tsv files"
from pathlib import Path
import pandas as pd
import re
from rich import print

input_file = Path(__file__).parent / "README.md"
output_file = Path(__file__).parent / "dataset_listing.tsv"

lines = input_file.read_text().splitlines()

dataset_listing = {
    "name": [],
    "description": [],
    "link to full data": [],
    "maintained by": [],
}

is_table = False
skip_next = False
keep_table = False
headers = []
for i, l in enumerate(lines):
    # print(i)

    if l.startswith("|"):
        is_table = True

    if is_table and not l.startswith("|"):
        is_table = False
        headers = []

    if not is_table:
        continue

    if not headers:
        headers = l.strip("|").split("|")
        headers = [h.strip() for h in headers]
        if len(headers) < 4:
            keep_table = False
            continue
        print(headers)
        skip_next = True
        keep_table = True
        continue

    if skip_next:
        skip_next = False
        continue

    if keep_table:
        this_dataset = l.strip("|").split("|")
        this_dataset = [h.strip() for h in this_dataset]

        for h in dataset_listing:
            if h in headers:
                value = this_dataset[headers.index(h)] or "n/a"
                dataset_listing[h].append(value)

for key in dataset_listing:
    print(key, len(dataset_listing[key]))
df = pd.DataFrame(dataset_listing)
df.to_csv(output_file, sep="\t", index=False)

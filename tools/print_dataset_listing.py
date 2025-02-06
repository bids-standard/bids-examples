"""Take the listing of examples datasets
and turns it into a markdown document with a series of markdown tables.

You can pass an argument to insert the content in another file.
Otherwise the content will be added to the README of this repository.
"""

import sys
from pathlib import Path
import pandas as pd
from bids import BIDSLayout
from rich import print

folders_to_skip = ["docs", ".git", ".github", "tools", "env", "site", ".vscode"]
suffixes_to_remove = ["README", "description", "participants", "CITATION"]
column_order = [
    "name",
    "description",
    "datatypes",
    "suffixes",
    "link to full data",
    "maintained by",
]

UPSTREAM_REPO = "https://github.com/bids-standard/bids-examples/tree/master/"

# set to True to update the listing of datasets with the datatypes and suffixes
update_content = False

root = Path(__file__).resolve().parent.parent
input_file = root / "dataset_listing.tsv"

tables_order = {
    "ASL": "perf",
    "Behavioral": "beh",
    "EEG": "^eeg$",
    "DWI": "dwi",
    "iEEG": "ieeg",
    "HED": "",
    "MEG": "meg",
    "Microscopy": "micr",
    "Motion": "motion",
    "MRI": "func",
    "MRS": "mrs",
    "NIRS": "nirs",
    "PET": "pet",
    "qMRI": "",
}

DELIMITER = "<!-- ADD EXAMPLE LISTING HERE -->"


def main(output_file=None):

    if len(sys.argv) > 1:
        output_file = Path(sys.argv[1])

    if output_file is None:
        output_file = root / "README.md"

    df = pd.read_csv(input_file, sep="\t")

    names = df["name"].copy()

    check_missing_folders(df, root)

    if update_content:
        df = update_datatypes_and_suffixes(df, root)
        df.to_csv(input_file, sep="\t", index=False)
        df = pd.read_csv(input_file, sep="\t")

    df = add_links(df)

    clean_previous_run(output_file)

    df = df[column_order]
    add_tables(df, output_file, names)


def check_missing_folders(df, root):
    nb_datasets = len(df)
    folders = list(root.glob("*"))
    folders = [f.name for f in folders if f.is_dir() and f.name not in folders_to_skip]
    if len(folders) != nb_datasets:
        raise ValueError(
            f"Found {len(folders)} folders but {nb_datasets} datasets in the table:"
            f"missing {set(folders) - set(df['name'].values)} folders"
        )


def update_datatypes_and_suffixes(df, root):
    print("Listing datatypes, suffixes...")
    datatypes = []
    suffixes = []
    for row in df.iterrows():
        print(f"  {row[1]['name']}")

        layout = BIDSLayout(root / row[1]["name"])

        tmp = sorted(layout.get_datatypes()) or ["n/a"]
        print(f"  {tmp}")
        datatypes.append(stringify_list(tmp))

        tmp = layout.get_suffixes()
        tmp = sorted([s for s in tmp if s not in suffixes_to_remove]) or ["n/a"]
        print(f"  {tmp}")
        suffixes.append(stringify_list(tmp))

    if not datatypes:
        datatypes = ["n/a"]
    df["datatypes"] = datatypes
    df["suffixes"] = suffixes

    return df


def add_links(df):
    print("Adding hyperlinks in table...")
    for row in df.iterrows():
        for col in ["name", "link to full data", "maintained by"]:
            if not isinstance(row[1][col], str):
                continue
            if col == "name":
                row[1][col] = f"[{row[1][col]}]({UPSTREAM_REPO}{row[1][col]})"
            if col == "link to full data" and row[1][col].startswith("http"):
                row[1][col] = f"[link]({row[1][col]})"
            if col == "maintained by" and row[1][col].startswith("@"):
                row[1][col] = f"[{row[1][col]}](https://github.com/{row[1][col][1:]})"
    return df


def clean_previous_run(output_file: Path) -> None:
    print("Cleaning output files from previous run...")
    lines = output_file.read_text().split("\n")
    with output_file.open("w") as f:
        for line in lines:
            if line.startswith(DELIMITER):
                f.write(line + "\n")
                add_warning(f)
                break
            f.write(line + "\n")


def add_warning(f):
    f.write(
        """<!--
Table below is generated automatically.
Do not edit directly.
-->

""".upper()
    )


def add_tables(df: pd.DataFrame, output_file: Path, names) -> None:
    print("Writing markdown tables...")
    df.fillna("n/a", inplace=True)
    for table_name, table_datatypes in tables_order.items():
        with output_file.open("a") as f:
            f.write(f"\n### {table_name}\n\n")
            add_warning(f)

        if table_name == "qMRI":
            mask = names.str.contains("qmri_")
        elif table_name == "HED":
            mask = names.str.contains("_hed_")
        else:
            mask = df["datatypes"].str.contains(table_datatypes, regex=True)

        sub_df = df[mask].copy()
        sub_df.sort_values(by=["name"], inplace=True)

        print(sub_df)

        sub_df.to_markdown(output_file, index=False, mode="a")
        with output_file.open("a") as f:
            f.write("\n")


def stringify_list(l):
    return ", ".join(l)


if __name__ == "__main__":
    main()

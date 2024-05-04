"""Take the listing of examples datasets
and turns it into a markdown document with a series of markdown tables."""
from pathlib import Path
import pandas as pd
from bids import BIDSLayout

folders_to_skip = ["docs", ".git", ".github", "tools", "env", "site", ".vscode"]
suffixes_to_remove = ["README", "description", "participants"]
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
update_content = True

root = Path(__file__).resolve().parent.parent
input_file = root / "dataset_listing.tsv"
output_file = root / "README.md"

tables_order = {
    "ASL": "perf",
    "EEG": "^eeg$",
    "iEEG": "ieeg",
    "MEG": "meg",
    "Microscopy": "micr",
    "Motion": "motion",
    "MRI": "func",
    "MRS": "mrs",
    "NIRS": "nirs",
    "PET": "pet",
    "qMRI": "",
    "Behavioral": "beh",
}


def main():
    df = pd.read_csv(input_file, sep="\t")

    check_missing_folders(df, root)

    if update_content:
        df = update_datatypes_and_suffixes(df, root)
        df.to_csv(input_file, sep="\t", index=False)
        df = pd.read_csv(input_file, sep="\t")

    df = add_links(df)

    print(df)

    clean_previous_run(output_file)

    df = df[column_order]
    add_tables(df, output_file)


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
        datatypes.append(stringify_list(tmp))

        tmp = layout.get_suffixes()
        tmp = sorted([s for s in tmp if s not in suffixes_to_remove]) or ["n/a"]
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
            if line.startswith("## Dataset index"):
                f.write(line + "\n")
                add_warning(f)
                break
            f.write(line + "\n")

def add_warning(f):
    f.write("""<!--
Table below is generated automatically.
Do not edit directly.
-->

""".upper())

def add_tables(df: pd.DataFrame, output_file: Path) -> None:
    print("Writing markdown tables...")
    df.fillna("n/a", inplace=True)
    for table_name, table_datatypes in tables_order.items():
        with output_file.open("a") as f:
            f.write(f"\n### {table_name}\n\n")
            add_warning(f)
        if table_name == "qMRI":
            sub_df = df[df["name"].str.contains("qmri_")]
        else:
            sub_df = df[df["datatypes"].str.contains(table_datatypes, regex=True)]
        sub_df.sort_values(by=["name"], inplace=True)
        # sub_df["name"] = df["name"].apply(lambda x: f'[{x}](https://github.com/bids-standard/bids-examples/tree/master/{x})')
        print(sub_df)
        sub_df.to_markdown(output_file, index=False, mode="a")
        with output_file.open("a") as f:
            f.write("\n")


def stringify_list(l):
    return ", ".join(l)


if __name__ == "__main__":
    main()

from pathlib import Path
import pandas as pd
from bids import BIDSLayout


def main():
    root = Path(__file__).parent

    input_file = root / "dataset_listing.tsv"

    df = pd.read_csv(input_file, sep="\t")

    nb_datasets = len(df)

    folders_to_skip = ["docs", ".git", ".github"]
    folders = list(root.glob("*"))
    folders = [f.name for f in folders if f.is_dir() and f.name not in folders_to_skip]
    if len(folders) != nb_datasets:
        raise ValueError(
            f"Found {len(folders)} folders but {nb_datasets} datasets in the table:"
            f"missing {set(folders) - set(df['name'].values)} folders"
        )

    for row in df.iterrows():
        for col in ["link to full data", "maintained by"]:
            if not isinstance(row[1][col], str):
                continue
            if col == "link to full data" and row[1][col].startswith("http"):
                row[1][col] = f"[link]({row[1][col]})"
            if col == "maintained by" and row[1][col].startswith("@"):
                row[1][col] = f"[{row[1][col]}](https://github.com/{row[1][col][1:]})"

    print("Listing datatypes, suffixes...")
    datatypes = []
    suffixes = []
    suffixes_to_remove = ["README", "description", "participants"]

    for row in df.iterrows():
        print(f"  {row[1]['name']}")

        layout = BIDSLayout(root / row[1]["name"])

        datatypes.append(stringify_list(layout.get_datatypes()))

        tmp = layout.get_suffixes()
        tmp = [s for s in tmp if s not in suffixes_to_remove]
        suffixes.append(stringify_list(tmp))

    df["datatypes"] = datatypes
    df["suffixes"] = suffixes

    df = df[
        [
            "name",
            "description",
            "datatypes",
            "suffixes",
            "link to full data",
            "maintained by",
        ]
    ]

    df.to_markdown(input_file.with_suffix(".md"), index=False)


def stringify_list(l):
    return ", ".join(l)


if __name__ == "__main__":
    main()

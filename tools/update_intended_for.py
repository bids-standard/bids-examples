"""Update jsons of all datasets for IntendedFor field to use proper format.

https://bids-specification.readthedocs.io/en/latest/common-principles.html#bids-uri

Example:

- bad

    .. code-block:: json

        "IntendedFor": ["anat/sub-01_T1w.nii.gz"]


- good

    .. code-block:: json

        "IntendedFor": ["bids::sub-01/anat/sub-01_T1w.nii.gz"]
"""

import json
from pathlib import Path

from rich import print

VERBOSE = False
DRY_RUN = False


def root_dir():
    return Path(__file__).parent.parent


def main():
    for json_path in root_dir().glob("**/*.json"):
        with open(json_path) as f:
            content = json.load(f)

        if "IntendedFor" not in content:
            continue

        print()
        print(f"Checking {json_path.relative_to(root_dir())}")

        intended_for = content["IntendedFor"]

        was_str = False
        if isinstance(intended_for, str):
            was_str = True
            intended_for = [intended_for]

        for i, intended_for_path in enumerate(intended_for):
            if intended_for_path.startswith("bids:"):
                continue

            if not intended_for_path.startswith(
                ("ses-", "anat", "func", "ieeg", "fmap", "perf", "micr")
            ):
                print(f"[red]will not update {intended_for_path}[/red]")
                continue

            filename = Path(intended_for_path).name
            subject = filename.split("_")[0]

            if intended_for_path.startswith("ses-"):
                session = intended_for_path.split("/")[0]
                datatype = intended_for_path.split("/")[1]
                uri = [subject, session, datatype, filename]
            else:
                datatype = intended_for_path.split("/")[0]
                uri = [subject, datatype, filename]

            intended_for[i] = f"bids::{'/'.join(uri)}"

        if was_str:
            intended_for = intended_for[0]

        if VERBOSE:
            print(intended_for)

        if not DRY_RUN:
            with open(json_path, "w") as f:
                content["IntendedFor"] = intended_for
                json.dump(content, f, indent=1)


if __name__ == "__main__":
    main()

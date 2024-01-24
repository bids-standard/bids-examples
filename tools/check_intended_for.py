"""Check jsons of all datasets for IntendedFor field.

Make sure that the format is not one of the deprecated ones.

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

VERBOSE = False


def root_dir():
    return Path(__file__).parent.parent


def main():
    deprecated_formats = {}

    for json_path in root_dir().glob("**/*.json"):
        if VERBOSE:
            print(f"Checking {json_path.relative_to(root_dir())}")

        with open(json_path) as f:
            content = json.load(f)

        if "IntendedFor" not in content:
            continue

        intended_for = content["IntendedFor"]
        if isinstance(intended_for, str):
            intended_for = [intended_for]

        for intended_for_path in intended_for:
            if intended_for_path.startswith("bids:"):
                continue

            if json_path not in deprecated_formats:
                deprecated_formats[json_path] = []
            deprecated_formats[json_path].append(intended_for_path)

    if deprecated_formats:
        log_file = root_dir() / "deprecated_intended_for.log"

        with open(log_file, "w") as f:
            for json_path, deprecated_paths in deprecated_formats.items():
                f.write(f"{json_path.relative_to(root_dir())}\n")
                print(f"{json_path.relative_to(root_dir())}")
                for deprecated_path in deprecated_paths:
                    f.write(f"  {deprecated_path}\n")
                    print(f"  {deprecated_path}")

        raise (ValueError)(
            f"Found {len(deprecated_formats)} jsons with deprecated IntendedFor formats.\n"
            f"See {log_file}\n"
            "Please update them to the new format.\n"
            "See https://bids-specification.readthedocs.io/en/latest/common-principles.html#bids-uri"
        )


if __name__ == "__main__":
    main()

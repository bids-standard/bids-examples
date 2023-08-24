"""Add resolution metadata if json filename contains the res entity."""
import json
from pathlib import Path
from rich import print

root = Path(__file__).parent.parent

files_to_update = root.glob("sub-*/*/sub*res-2*.json")

for event in files_to_update:
    with open(event) as f:
        metadata = json.load(f)
    metadata["Resolution"] = "2mm, isotropic"
    with open(event, "w") as f:
        json.dump(metadata, f, indent=2)
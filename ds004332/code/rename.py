"""

- add task entity to the filename
- add TaskName to the json file
- change acquisition entity to use uppercase for pmc
- remove run entity as it was a place holder for the task

"""

import json
import os
from pathlib import Path
from bids import BIDSLayout
from rich import print

dry_run = True

data_pth = Path(__file__).parent.parent
pybids_config = Path(__file__).parent.joinpath("pybids_config.json")

layout = BIDSLayout(Path(__file__).parent.parent, config=pybids_config)

print(data_pth)
print(layout.get(target="suffix", return_type="id"))

bf = layout.get(datatype="anat", extension="nii|json", regex_search=True)

run_task_map = {"01": "still", "02": "nodding", "03": "shaking"}

for file in bf:

    entities = file.entities.copy()

    input_file = layout.build_path(entities, strict=False, validate=False)

    task_label = run_task_map[str(entities["run"])]
    entities["task"] = task_label
    entities["acquisition"] = entities["acquisition"].replace("pmc", "PMC")
    entities.pop("run")

    # need to skip validation as the the new task entity is not yet in the validator
    output_file = layout.build_path(entities, strict=False, validate=False)

    print()
    print(input_file)
    # print(entities)
    print(output_file)

    if not dry_run:

        os.rename(input_file, output_file)

        if file.entities["extension"] == ".json":

            with open(output_file, "r") as f:
                json_data = json.load(f)

            json_data["TaskName"] = task_label

            with open(output_file, "w") as f:
                json.dump(json_data, f, indent=4)

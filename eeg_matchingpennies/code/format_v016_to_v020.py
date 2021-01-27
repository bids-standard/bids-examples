"""Reformat eeg_matchingpennies from version 0.1.6 to version 0.2.0.

Information that is added here was taken from the original (unpublished) study materials.

Requirements
------------
- Python 3.7.7
- Numpy 1.18.5
- Pandas 1.0.5

"""
# %% Imports
import os.path as op
import json
import re

import numpy as np
import pandas as pd

# %% Constants
mp_root = "/home/stefanappelhoff/Desktop/bids/bids-examples/eeg_matchingpennies"
sfreq = 5000
countdown_duration_s = 3

# %% Assert we are working on the correct version of the data

CHANGES = op.join(mp_root, "CHANGES")
with open(CHANGES, "r", encoding="utf-8") as fin:
    lines = fin.readlines()

expected_versions = set(["0.1.0", "0.1.1", "0.1.2", "0.1.3", "0.1.4", "0.1.5", "0.1.6"])
found_versions = []
for line in lines:
    match = re.match(r"(\d\.\d\.\d)", line)
    if match:
        found_versions.append(match.group(0))

diff = set(found_versions) - set(expected_versions)
if len(diff) > 0:
    raise RuntimeError(f"Found unexpected versions in CHANGES: {diff}")


# %% Collect changes that are done to data in a list

changes = []

# %% Update README

txt = """Overview
--------
This is the "Matching Pennies" dataset. It was collected as part of a small
scale replication project targeting the following reference:

Matthias Schultze-Kraft et al.
"Predicting Motor Intentions with Closed-Loop Brain-Computer Interfaces".
In: Springer Briefs in Electrical and Computer Engineering.
Springer International Publishing, 2017, pp. 79–90.

In brief, it contains EEG data for 7 subjects raising either their left or right hand,
thus giving rise to a lateralized readiness potential as measured with the EEG.
For details, see the `Details about the experiment` section.


Citing this dataset
-------------------
Please cite as follows:

Appelhoff, S., Sauer, D., & Gill, S. S. (2018, July 22).
Matching Pennies: A Brain Computer Interface Implementation Dataset.

For more information, see the `dataset_description.json` file.


License
-------
This eeg_matchingpennies dataset is made available under the Open Database
License: See the LICENSE file. A human readable information can be found at:

https://opendatacommons.org/licenses/odbl/summary/

Any rights in individual contents of the database are licensed under the
Database Contents License: http://opendatacommons.org/licenses/dbcl/1.0/


Format
------
The dataset is formatted according to the Brain Imaging Data Structure. See the
`dataset_description.json` file for the specific version used.

Generally, you can find data in the .tsv files and descriptions in the
accompanying .json files.

An important BIDS definition to consider is the "Inheritance Principle", which
is described in the BIDS specification under the following link:

https://bids-specification.rtfd.io/en/stable/02-common-principles.html#the-inheritance-principle

The section states that:

> Any metadata file (​.json​,​.bvec​,​.tsv​, etc.) may be defined at any directory
level. The values from the top level are inherited by all lower levels unless
they are overridden by a file at the lower level.


Details about the experiment
----------------------------
For a detailed description of the task, see Schultze-Kraft et al. (2017)
and the supplied `task-matchingpennies_eeg.json` file.

Subjects 1 to 4 participated in the pilot testing only. Their data are not
included in this dataset.

In the matching pennies experiment, EEG data was evaluated in a closed-loop
BCI online setup. Due to an inherent latency of the system, the data used in
the online analysis does not necessarily coincide with the offline data marked
through EEG triggers. Therefore, after each trial-wise online analysis, the
used data was saved separately as an "online chunk". Based on the online chunks
of data, it was possible to calculate a latency of each trial with respect to
the time difference between when an event happened at the electrode level and
when it arrived in digitized format at the classification function. These
latencies were calculated by sliding the online chunk of data across the data
recording until a perfect match was found. The index of this perfect match is
then compared to the timepoint of the event trigger and that difference
constitutes the latency. The values are included in the events.tsv files for
each subject.

The original data was recorded in `.xdf` format using labstreaminglayer
(https://github.com/sccn/labstreaminglayer). It is stored in the `/sourcedata`
directory. To comply with the BIDS format, the .xdf format was converted to
brainvision format (see the `.eeg` file for binary eeg data, the `.vhdr` as a
text header filer containing meta data, and the `.vmrk` as a text file storing
the eeg markers).

Note that in the experiment, the only EEG TTL triggers that were recorded are related
to the button release of the left (=value 1) or right (=value 2) hand.
The onset of the feedback stimulus (drawing ofleft or right hand shown on the screen)
was not recorded, however it can be crudely estimated to be around 50ms + ~10ms + ~8ms,
where 50ms were a hardcoded break before getting the online data from LSL, ~10ms was
the time to get a prediction from the BCI classifier, but this varied around 10ms,
and finally the ~8ms at the end come from the uncertainty of the refresh rate of the
screen (60fps = 1 screen every 16.66666ms)

"""

README = op.join(mp_root, "README")
with open(README, "w", encoding="utf-8") as fout:
    print(txt, file=fout)

changes.append("Added info on feedback onset to README")

# %% Recalculate ONSET column

for sub in range(5, 12):
    fname = op.join(
        mp_root, f"sub-{sub:02}", "eeg", f"sub-{sub:02}_task-matchingpennies_events.tsv"
    )
    df = pd.read_csv(fname, sep="\t")
    df["onset"] = df["sample"] / sfreq
    df.to_csv(fname, index=False, sep="\t", na_rep="n/a")

changes.append("Re-calculated onset column without rounding")

# %% Reconstruct events that were previously not included

# the columns in events.tsv that refer to the trial as a whole
trialcols = [
    "stage",
    "trial",
    "stim_file",
    "trial_type",
    "response_time",
    "bci_prediction",
    "bci_prediction_valid",
    "n_repeated",
    "latency",
]

# previous column order for re-ordering later
prev_col_order = []

# go over subjs
for sub in range(5, 12):
    fname = op.join(
        mp_root, f"sub-{sub:02}", "eeg", f"sub-{sub:02}_task-matchingpennies_events.tsv"
    )
    df = pd.read_csv(fname, sep="\t")

    df = df.rename(
        columns={
            "trl": "trial",
            "pred": "bci_prediction",
            "pred_valid": "bci_prediction_valid",
            "n_invalid": "n_repeated",
        }
    )
    if len(prev_col_order) == 0:
        prev_col_order = df.columns[:]

    # Add new rows
    tmp = df.copy()
    tmp["countdown_ends"] = tmp["onset"] - tmp["response_time"] / 1000
    tmp["countdown_starts"] = tmp["countdown_ends"] - countdown_duration_s

    for newonset in ["countdown_ends", "countdown_starts"]:
        tmptmp = tmp[trialcols + [newonset]]
        tmptmp = tmptmp.rename(columns={newonset: "onset"})
        df = df.append(tmptmp, ignore_index=True, sort=True)

    # Reorder rows and sort by onset
    df = df[prev_col_order]
    df = df.sort_values(by="onset")
    df = df.reset_index(drop=True)

    # Some of our int columns have been converted to float because of np.nan
    # convert to str before saving to assure later int reading
    for col in ["sample", "value", "duration"]:
        df[col] = [int(i) if not np.isnan(i) else "n/a" for i in df[col].to_list()]

    # Save TSV
    df.to_csv(fname, index=False, sep="\t", na_rep="n/a")

# update JSON
events_json = op.join(mp_root, "task-matchingpennies_events.json")
with open(events_json, "r") as fin:
    events_json_dict = json.load(fin)


events_json_dict["trial"] = events_json_dict.pop("trl")
events_json_dict["bci_prediction"] = events_json_dict.pop("pred")
events_json_dict["bci_prediction_valid"] = events_json_dict.pop("pred_valid")
events_json_dict["n_repeated"] = events_json_dict.pop("n_invalid")


for col in ["trial_type", "bci_prediction", "bci_prediction_valid", "latency"]:
    data = events_json_dict[col]["Description"]
    data = data.rstrip(".")
    events_json_dict[col]["Description"] = data + " in this trial."

events_json_dict["n_repeated"][
    "Description"
] = "Number of trials that had to be repeated until the present trial because of invalid participant behavior (within this stage)."

with open(events_json, "w", encoding="UTF-8") as fout:
    json.dump(events_json_dict, fout, ensure_ascii=False, indent=4)
    fout.write("\n")

# these changes are a bit more extensive, so nest
these_changes = """Work on events.tsv and json
        - Renamed columns: trl->trial, pred->bci_prediction, pred_valid->bci_prediction_valid, n_invalid->n_repeated
        - Extend/clarify several 'Description' fields
        - Add previously undocumented events based on what was learned from experiment code
"""
these_changes = these_changes[:-1]  # drop final newline char

changes.append(these_changes)


# %% Use CMIXf-12 formatting of units

for sub in range(5, 12):
    fname = op.join(
        mp_root,
        f"sub-{sub:02}",
        "eeg",
        f"sub-{sub:02}_task-matchingpennies_channels.tsv",
    )
    df = pd.read_csv(fname, sep="\t")
    df["units"] = "uV"
    df.to_csv(fname, index=False, sep="\t", na_rep="n/a")

with open(events_json, "r") as fin:
    events_json_dict = json.load(fin)

for col in ["onset", "duration"]:
    events_json_dict[col]["Units"] = "s"

for col in ["response_time", "latency"]:
    events_json_dict[col]["Units"] = "ms"


with open(events_json, "w", encoding="UTF-8") as fout:
    json.dump(events_json_dict, fout, ensure_ascii=False, indent=4)
    fout.write("\n")


changes.append(
    "Use CMIXF-12 formatting throughout: https://people.csail.mit.edu/jaffer/MIXF/CMIXF-12"
)

# %% Update eeg.json

eeg_json = op.join(mp_root, "task-matchingpennies_eeg.json")
with open(eeg_json, "r") as fin:
    eeg_json_dict = json.load(fin)

eeg_json_dict["TaskName"] = "matchingpennies"


with open(eeg_json, "w", encoding="UTF-8") as fout:
    json.dump(eeg_json_dict, fout, ensure_ascii=False, indent=4)
    fout.write("\n")


# %% Update dataset_description.json

ds_json = op.join(mp_root, "dataset_description.json")
with open(ds_json, "r") as fin:
    ds_json_dict = json.load(fin)

ds_json_dict["HowToAcknowledge"] = "Please cite: " + ds_json_dict["HowToAcknowledge"]
ds_json_dict["DatasetType"] = "raw"

with open(ds_json, "w", encoding="UTF-8") as fout:
    json.dump(ds_json_dict, fout, ensure_ascii=False, indent=4)
    fout.write("\n")


changes.append("Add new recommended DatasetType field to dataset_description")

# %% Update CHANGES

txt = "\n0.2.0 2020-07-24"
for change in changes:
    txt += "\n    - " + change

CHANGES = op.join(mp_root, "CHANGES")
with open(CHANGES, "a", encoding="utf-8") as fout:
    print(txt, file=fout)

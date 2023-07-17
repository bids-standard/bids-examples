# Dataset Description

This is a copy of the `ieeg_epilepsy` dataset which is part of the `bids_examples` collection.
Fies with the extension `.eeg` are replaced with `.nwb` files with an empty data matrix and a subject field definition.
The `ieeg_epilepsy` was chosen for duplication as it was the smallest dataset using the `ieeg` modality.

```python
import os
from uuid import uuid4
from datetime import datetime, timezone
from dateutil.tz import tzlocal, tzutc
import pynwb
from dandi.pynwb_utils import make_nwb_file, metadata_nwb_file_fields

def simple1_nwb_metadata():
    # very simple assignment with the same values as the key with 1 as suffix
    metadata = {f: f"{f}1" for f in metadata_nwb_file_fields}
    metadata["identifier"] = uuid4().hex
    # subject_fields

    # tune specific ones:
    # Needs an explicit time zone since otherwise pynwb would add one
    # But then comparison breaks anyways any ways yoh have tried to set it
    # for datetime.now.  Taking example from pynwb tests
    metadata["session_start_time"] = datetime(2017, 4, 15, 12, tzinfo=tzutc())
    metadata["keywords"] = ["keyword1", "keyword 2"]
    # since NWB 2.1.0 some fields values become "arrays" which are
    # then reloaded as tuples, so we force them being tuples here
    # See e.g. https://github.com/NeurodataWithoutBorders/pynwb/issues/1091
    for f in "related_publications", "experimenter":
        metadata[f] = (metadata[f],)
    return metadata

for i in os.listdir("."):
    if i.endswith("nwb"):
        b = simple1_nwb_metadata()
        a = make_nwb_file(
            i+"1",
            subject=pynwb.file.Subject(
                subject_id="01",
                date_of_birth=datetime(2016, 12, 1, tzinfo=tzutc()),
                sex="U",
                species="Mus musculus",
            ),
            **b,
        )
        print(a)
```


# Parent Dataset License

This tutorial dataset (EEG and MRI data) remains property of the Grenoble University Hospital, France.
Its use and transfer outside the ImaGIN tutorial, e.g. for research purposes, is prohibited without written consent.
For questions, please contact Olivier David, PhD (olivier.david@inserm.fr).
The metadata and filename stubs shared in this repository can be used, transferred, and derived, without explicit permission.

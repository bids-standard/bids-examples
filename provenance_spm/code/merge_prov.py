#!/usr/bin/python
# coding: utf-8

""" Merge available prov JSON files into one RDF graph """

import json
from pathlib import Path

# List of available prov files
prov_soft_files = [
  'prov/prov-spm_soft.json'
]
prov_act_files = [
  'prov/prov-spm_act.json'
]
prov_ent_files = [
  'prov/prov-spm_ent.json'
]
prov_ent_files = [
  'prov/prov-spm_ent.json'
]
sidecar_files = [
  'SPM/PREPROCESSING/ANATOMICAL/c1sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/c2sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/c3sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/c4sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/c5sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/msub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/sub-01_T1w_seg8.json',
  'SPM/PREPROCESSING/ANATOMICAL/y_sub-01_T1w.json',
  'SPM/PREPROCESSING/ANATOMICAL/wmsub-01_T1w.json',
  'SPM/PREPROCESSING/FUNCTIONAL/meansub-01_task-tonecounting_bold.json',
  'SPM/PREPROCESSING/FUNCTIONAL/rp_sub-01_task-tonecounting_bold.json',
  'SPM/PREPROCESSING/FUNCTIONAL/rsub-01_task-tonecounting_bold.json',
  'SPM/PREPROCESSING/FUNCTIONAL/swsub-01_task-tonecounting_bold.json',
  'SPM/PREPROCESSING/FUNCTIONAL/wsub-01_task-tonecounting_bold.json'
]

# Base jsonld
base_provenance = {
  "Records": {
    "Software": [],
    "Activities": [],
    "Entities": []
  }
}

# Add context and version (in this example, we suppose that context and version are known by BIDS)
base_provenance["BIDSProvVersion"] = "0.0.1"
base_provenance["@context"] = "https://purl.org/nidash/bidsprov/context.json"

# Parse Software
for prov_file in prov_soft_files:
  with open(prov_file, encoding = 'utf-8') as file:
    data = json.load(file)
    base_provenance['Records']['Software'] += data['Software']

# Parse Entities
for prov_file in prov_ent_files:
  with open(prov_file, encoding = 'utf-8') as file:
    data = json.load(file)
    base_provenance['Records']['Entities'] += data['Entities']

# Parse Activities
for prov_file in prov_act_files:
  with open(prov_file, encoding = 'utf-8') as file:
    data = json.load(file)
    base_provenance['Records']['Activities'] += data['Activities']

# Parse Sidecar files
for sidecar_file in sidecar_files:
  # Identify data file(s) associated with the sidecar
  sidecar_filename = Path(sidecar_file)
  data_files = Path('').glob(f'{sidecar_filename.with_suffix("")}.*')
  data_files = [str(f) for f in list(data_files) if str(sidecar_filename) not in str(f)]

  # Write provenance
  with open(sidecar_file, encoding = 'utf-8') as file:
    data = json.load(file)
    if 'GeneratedBy' in data:

      # Get activity data and id
      activity_data = data['GeneratedBy']
      activity_id = ""
      if "Id" in activity_data:
        activity_id = activity_data['Id']
      else:
        activity_id = activity_data

      # Provenance for the data file
      for data_file in data_files:
        base_provenance['Records']['Entities'].append(
          {
            "Id": f"bids::{data_file}",
            "GeneratedBy": activity_data
          }
        )

    if 'SidecarGeneratedBy' in data:

      # Get activity data and id
      activity_data = data['SidecarGeneratedBy']
      activity_id = ""
      if "Id" in activity_data:
        activity_id = activity_data['Id']
      else:
        activity_id = activity_data

      # Provenance for the sidecar
      base_provenance['Records']['Entities'].append(
        {
          "Id": f"bids::{sidecar_filename}",
          "GeneratedBy": activity_id
        }
      )

# Write jsonld
with open('prov/prov-spm.jsonld', 'w', encoding = 'utf-8') as file:
  file.write(json.dumps(base_provenance, indent = 2))

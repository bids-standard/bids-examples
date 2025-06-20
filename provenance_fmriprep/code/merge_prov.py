#!/usr/bin/python
# coding: utf-8

""" Merge available prov JSON files into one RDF graph """

import json
from pathlib import Path

# List of available prov files
prov_soft_files = [
  'prov/prov-fmriprep_soft.json'
]
prov_act_files = [
  'prov/prov-fmriprep_act.json'
]
prov_ent_files = [
  'prov/prov-fmriprep_ent.json'
]
prov_ent_files = [
  'prov/prov-fmriprep_ent.json'
]
sidecar_files = []
dataset_files = [
	'dataset_description.json'
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

    # Identify data file associated with the sidecar
    sidecar_filename = Path(sidecar_file)
    data_files = Path('').glob(f'{sidecar_filename.with_suffix("")}.*')
    data_files = [str(f) for f in list(data_files) if str(sidecar_filename) not in str(f)]
    if len(data_files) != 1:
        continue
    data_file = data_files[0]

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

        # Provenance Entity record for the data file
        entity = {
            "Id": f"bids::{data_file}",
            "Label": Path(data_file).name,
            "AtLocation": data_file,
            "GeneratedBy": activity_data
        }

    # Get other provenance-related metadata
    if 'Digest' in data:
        entity['Digest'] = data['Digest']
    if 'Type' in data:
        entity['Type'] = data['Type']

    # Write provenance record
    base_provenance['Records']['Entities'].append(entity)

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
                "Label": Path(sidecar_filename).name,
                "AtLocation": sidecar_filename,
                "GeneratedBy": activity_id
            }
        )

# Parse dataset_description files
for dataset_file in dataset_files:

    with open(dataset_file, encoding = 'utf-8') as file:
        data = json.load(file)

    # Make entities from source datasets ?

    # Make entities for the current dataset
    if 'GeneratedBy' in data:
        current_dataset = {
            "Id": "bids:current_dataset",
            "Label": data['Name'],
            "GeneratedBy": []
        }
        for generated_by_obj in data['GeneratedBy']:
            if 'Id' in generated_by_obj:
                current_dataset['GeneratedBy'].append(generated_by_obj['Id'])
        if 'GeneratedBy' in current_dataset:
            base_provenance['Records']['Entities'].append(current_dataset)

# Write jsonld
with open('prov/prov-fmriprep.jsonld', 'w', encoding = 'utf-8') as file:
    file.write(json.dumps(base_provenance, indent = 2))

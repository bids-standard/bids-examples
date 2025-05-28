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

# Write jsonld
with open('prov/prov-spm.jsonld', 'w', encoding = 'utf-8') as file:
  file.write(json.dumps(base_provenance, indent = 2))

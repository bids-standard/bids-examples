# Provenance of manual brain segmentations

## Goal

This example aims at showing provenance metadata for a study dataset in which several experts performed manual brain segmentations from the same T1w file.

## Directory tree

> [!NOTE]
> Note that the `docs/` directory contains explanatory data (see [Provenance as a RDF graph](#provenance-as-a-rdf-graph)) that is not required to encode provenance.

```
.
├── dataset_description.json
├── derivatives
│   └── segmentations
│       ├── dataset_description.json
│       └── sub-001
│           └── anat
│               ├── sub-001_space-orig_desc-exp1_dseg.json
│               ├── sub-001_space-orig_desc-exp1_dseg.nii.gz
│               ├── sub-001_space-orig_desc-exp2_dseg.json
│               ├── sub-001_space-orig_desc-exp2_dseg.nii.gz
│               ├── sub-001_space-orig_desc-exp3_dseg.json
│               └── sub-001_space-orig_desc-exp3_dseg.nii.gz
├── docs
│   └── prov.jsonld
├── prov
│   ├── provenance.tsv
│   ├── prov-seg1_act.json
│   ├── prov-seg1_soft.json
│   ├── prov-seg2_act.json
│   ├── prov-seg2_soft.json
│   ├── prov-seg3_act.json
│   └── prov-seg3_soft.json
├── README.md
└── sourcedata
    └── raw
        ├── participants.tsv
        └── sub-001
            └── anat
                ├── sub-001_T1w.json
                └── sub-001_T1w.nii.gz
```

## Provenance as a RDF graph

Provenance metadata can be aggregated as a JSON-LD RDF graph, which is available in [`docs/prov-seg.jsonld`](docs/prov-seg.jsonld). This is a rendered version of the graph, also available in [`docs/prov-seg.png`](docs/prov-seg.png).

![Rendered version of the RDF graph](docs/prov-seg.png)

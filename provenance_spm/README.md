# BEP028 example dataset - Provenance records for SPM based fMRI statistical analysis

This example aims at showing provenance records for a statistical analysis performed with [`SPM`](https://www.fil.ion.ucl.ac.uk/spm/). Provenance records were created manually ; they act as a guideline for further machine-generated records by `SPM`. 

This is a derivative dataset, based upon:
* OpenfMRI DS000011 classification learning and tone counting experiment (cf. https://openfmri.org/dataset/ds000011/)
* SPM single subject t-test results from subject 01 of DS000011, performed using the [SPM batch file](https://github.com/incf-nidash/nidmresults-examples/blob/master/spm_default/batch.m) from the [NIDM Results example `spm_default`](https://github.com/incf-nidash/nidmresults-examples/tree/master/spm_default)

The directory tree is as follows:

```
prov/
├── prov-spm_act.json
├── prov-spm_ent.json
├── prov-spm_env.json
└── prov-spm_soft.json
sub-01/
└── ???
    ├── 
    └── 
```

TODOs:
- [ ] finish changing ids from the original jsonld file (currently in prov-spm_act.json)
- [ ] split activities / entities / env / soft into separated files
- [ ] > how to represent temporary files in the dataset ? -> we don't store them
- [ ] > where to save final files in the dataset ?
- [ ] finish readme & check if missing metadata in the dataset_description
- [ ] use sidecar JSONs ?
- [ ] add example in the list > must anat, func, T1w and bold be mentioned ? Where to say that it is a derivative dataset ?

provenance_spm_default Provenance records for a statistical analysis performed with [`SPM`](https://www.fil.ion.ucl.ac.uk/spm/). This example is buid upon [ds000011](cf. https://openfmri.org/dataset/ds000011/) data and the [NIDM Results example `spm_default`](https://github.com/incf-nidash/nidmresults-examples/tree/master/spm_default) code. [@bclenet](https://github.com/bclenet) anat, func T1w(?), bold(?), act, ent, env, soft
# BEP028 example dataset - Provenance records for `dcm2niix`

This example aims at showing provenance records for a DICOM to Nifti conversion, performed by [`dcm2niix`](https://github.com/rordenlab/dcm2niix
). Provenance records were created manually ; they act as a guideline for further machine-generated records by `dcm2niix`. 

After conversion, and adding provenance traces, the directory tree is as follows:

```
prov/
├── prov-dcm2niix_act.json
├── prov-dcm2niix_ent.json
├── prov-dcm2niix_env.json
└── prov-dcm2niix_soft.json
sourcedata/
sub-02/
└── anat
    ├── sub-02_T1w.json
    └── sub-02_T1w.nii
```

Note that the `sourcedata/` directory contains the source dataset (DICOM files) known as [hirni-demo](https://github.com/psychoinformatics-de/hirni-demo).

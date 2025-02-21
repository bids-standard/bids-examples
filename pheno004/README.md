# BEP036 example dataset 04: One imaging-only, one phenotypic-only, and one with both imaging and phenotypic data

This dataset contains imaging data and phenotypic data from one subject, only imaging data for another subject, and only phenotypic data for a third subject. Phenotype and imaging data were collected at the same session. The file tree is as follows:

```bash
pheno004
|-- README.md
|-- participants.json
|-- participants.tsv
|-- phenotype
|   |-- ace.json
|   |-- ace.tsv
|   |-- demographics.json
|   `-- demographics.tsv
|-- sub-01
|   `-- anat
|       |-- sub-01_T1w.json
|       `-- sub-01_T1w.nii.gz
`-- sub-02
    `-- anat
        |-- sub-02_T1w.json
        `-- sub-02_T1w.nii.gz

6 directories, 11 files

```

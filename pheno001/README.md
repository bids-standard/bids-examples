# BEP036 example dataset 01: One session with imaging and phenotypic data

This dataset contains imaging and phenotypic data from a single session. Phenotype and imaging data were collected at the same session. The file tree is as follows:

```bash
pheno001
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

**NOTE**: There is no sessions file in this dataset since both phenotype and imaging data were collected at the same single session. 

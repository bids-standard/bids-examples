# BEP036 example dataset 02: two sessions, one imaging-only session

This dataset has two sessions but only the first session includes both phenotype and imaging data. The second session only contains imaging data. The file tree is as follows:

```bash
pheno002
|-- README.md
|-- participants.json
|-- participants.tsv
|-- phenotype
|   |-- ace.json
|   |-- ace.tsv
|   |-- demographics.json
|   `-- demographics.tsv
|-- sessions.json
|-- sessions.tsv
|-- sub-01
|   |-- ses-01
|   |   `-- anat
|   |       |-- sub-01_ses-01_T1w.json
|   |       `-- sub-01_ses-01_T1w.nii.gz
|   `-- ses-02
|       `-- anat
|           |-- sub-01_ses-02_T1w.json
|           `-- sub-01_ses-02_T1w.nii.gz
`-- sub-02
    |-- ses-01
    |   `-- anat
    |       |-- sub-02_ses-01_T1w.json
    |       `-- sub-02_ses-01_T1w.nii.gz
    `-- ses-02
        `-- anat
            |-- sub-02_ses-02_T1w.json
            `-- sub-02_ses-02_T1w.nii.gz

12 directories, 17 files

```

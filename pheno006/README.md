# Pheno006 example dataset: Two sessions with one imaging-only session. No sessions files

This dataset contains imaging and phenotypic data from the baseline session and phenotypic data from followup sessions. This an example of a case where adding sessions files does not provide any new information. In other words, a sessions file is not strictly necessary here. The file tree is as follows:

```bash
pheno006
|-- README.md
|-- participants.json
|-- participants.tsv
|-- phenotype
|   |-- ace.json
|   `-- ace.tsv
|-- sub-01
|   `-- ses-baseline
|       `-- anat
|           |-- sub-01_ses-baseline_T1w.json
|           `-- sub-01_ses-baseline_T1w.nii.gz
`-- sub-02
    `-- ses-baseline
        `-- anat
            |-- sub-02_ses-baseline_T1w.json
            `-- sub-02_ses-baseline_T1w.nii.gz

8 directories, 9 files

```

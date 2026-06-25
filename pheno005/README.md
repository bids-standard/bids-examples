# Pheno005 example dataset: Two multi-run sessions with one imaging-only session

This dataset contains imaging and phenotypic data with multiple runs from the baseline session and phenotypic data from followup sessions. The file tree is as follows:

```bash
pheno005
|-- README.md
|-- participants.json
|-- participants.tsv
|-- phenotype
|   |-- tool-ACE_phenotype.json
|   |-- tool-ACE_phenotype.tsv
|   |-- tool-Demographics_phenotype.json
|   `-- tool-Demographics_phenotype.tsv
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

8 directories, 11 files

```

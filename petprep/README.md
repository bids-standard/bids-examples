# PETPrep Test Data Collection

## Overview

This dataset contains a curated collection of PET imaging data from multiple
OpenNeuro datasets,compiled for testing and development of the PETPrep software pipeline.
The data has been selected to provide a diverse range of PET imaging scenarios for comprehensive
software testing.

## Dataset Information

- **Dataset Type**: Raw BIDS data
- **BIDS Version**: 1.7.0
- **License**: CC0 (Public Domain)
- **Compiled for**: PETPrep software testing and development

## Included Datasets

This collection includes data from the following OpenNeuro datasets:

1. **ds005619**: [18F]SF51, a Novel 18F-labeled PET Radioligand for Translocator Protein 18kDa (TSPO) in Brain, Works Well in Monkeys but Fails in Humans
2. **ds004868**: [11C]PS13 demonstrates pharmacologically selective and substantial binding to cyclooxygenase-1 (COX-1) in the human brain
3. **ds004869**: https://openneuro.org/datasets/ds004869/versions/1.1.1

## Data Structure

The dataset follows the Brain Imaging Data Structure (BIDS) specification:

```
├── dataset_description.json
├── participants.tsv
├── sub-*/                    # Subject directories
│   ├── anat/                 # Anatomical data
│   │   └── sub-*_T1w.nii.gz
│   └── pet/                  # PET data
│       ├── sub-*_pet.nii.gz
│       ├── sub-*_pet.json
│       └── sub-*_blood.tsv   # Blood data (if available)
```

## Usage

This dataset is intended for:
- PETPrep software testing and validation
- Development of PET preprocessing pipelines
- Educational purposes in PET data analysis

## Citation

If you use this test dataset, please cite:
- The original OpenNeuro datasets
- The PETPrep software: [PETPrep GitHub Repository](https://github.com/nipreps/petprep)

## Acknowledgments

- OpenNeuro for hosting the original datasets
- The BIDS community for data organization standards
- Contributors to the PETPrep project

## Contact

For questions about this test dataset or PETPrep:
- PETPrep GitHub: https://github.com/nipreps/petprep
- OpenNeuro: https://openneuro.org

---

*This is a test dataset compiled for software development purposes. Please refer to the original
 datasets for research use.*

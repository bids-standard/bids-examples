Florbetapir NeuroMark Independent Component Analysis Template (MNI305 Space, 2 mm)
================================================================================

Overview
--------
This dataset contains an Independent Component Analysis (ICA)-based PET template constructed from cognitively normal subjects in the Alzheimer's Disease Neuroimaging Initiative (ADNI). The template was generated using the NeuroMark PET ICA pipeline.

Data were derived from 296 subjects with 18F-florbetapir PET scans, SUVR-normalized using the whole cerebellum as the reference region, and resampled to MNI305 space at 2 mm isotropic resolution. ICA was performed using a model order of 40, resulting in 19 spatial components: 17 amyloid-beta networks and 2 cerebellar components.

Contents
--------
- dataset_description.json: BIDS metadata describing the dataset, authorship, funding, and citation.
- tpl-adnineuromarkflorbetapir_space-MNI305_res-2_desc-ICA_pet.json: Metadata for this specific template, including listing of the ICA components and their functional labels.
- tpl-adnineuromarkflorbetapir_space-MNI305_res-2_desc-ICA_pet.nii.gz: Spatial maps of ICA components, with voxel intensities representing standardized component weights (z-scored).


File Naming Convention
-----------------------
The template file follows BIDS derivative naming:
  tpl-adnineuromarkflorbetapir_space-MNI305_res-2_desc-ICA_pet.nii.gz

Where:
- tpl-adnineuromarkflorbetapir: Describes the source and method of template creation.
- space-MNI305: Registered to MNI305 standard space.
- res-2: 2 mm isotropic resolution.
- desc-ICA: Denotes Independent Component Analysis-derived components.

Source Data
-----------
All subjects were selected from the ADNI GO/2/3 phases. Raw PET data were acquired using four 5-minute frames per subject and processed using standard SUVR normalization with the whole cerebellum as reference.

Please refer to the ADNI website for data access policies:
http://adni.loni.usc.edu

Acknowledgment
--------------
If you use this dataset, please cite the following publication:

Eierud C, et al. (2025). *Building Multivariate Molecular Imaging Brain Atlases Using the NeuroMark PET Independent Component Analysis Framework*. Aperture Neuro. https://doi.org/10.52294/001c.142578

Please also cite the Alzheimer's Disease Neuroimaging Initiative (ADNI) and acknowledge their funding sources as described at: http://adni.loni.usc.edu

License
-------
This dataset is distributed under the Creative Commons Attribution 4.0 International License (CC-BY-4.0).

Contact
-------
For questions or issues, please contact Cyrus Eierud (ceierud@gsu.edu)

BIDS Version
------------
1.11.1

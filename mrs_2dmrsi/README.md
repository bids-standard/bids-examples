# 2D semi-LASER MRSI reproducibility dataset

Contact: <wilsonmp@bham.ac.uk>

Data availability: <https://doi.org/10.5281/zenodo.7701228>

Publications:

- <https://doi.org/10.1016/j.neuroimage.2023.120235>

## Overview

The data from this study were acquired as part of a project to validate [SLIPMAT](https://doi.org/10.1016/j.neuroimage.2023.120235), a tool to extract high-quality, tissue-specific, spectral profiles from MR spectroscopic imaging data (MRSI).

Data types included are T1-weighted structural MRI images and 2D semi-LASER MRSI data. Each subject has three runs of each  MRSI acquisition.

## Methods

### Subjects

Eight healthy adults (2 females, 6 males, mean age = 21 years).

### MR protocol

Reproduced with slight modifications from [SLIPMAT](https://doi.org/10.1016/j.neuroimage.2023.120235):

MR data were acquired using a 3T Siemens Magnetom Prisma (Siemens Healthcare, Erlangen, Germany) system using a 32-channel receiver head coil-array. A T1-weighted MRI scan was acquired with a 3D-MPRAGE sequence: FOV = 208 × 256 × 256 mm, resolution = 1 × 1 × 1 mm<sup>3</sup>, TE / TR = 2 ms / 2000 ms, inversion time = 880 ms, flip angle = 8°, GRAPPA acceleration factor = 2, 4 min 54 s scan duration. Water suppressed MRSI data were acquired with 2D phase-encoding: FOV = 160 × 160 × 15 mm<sup>3</sup>, nominal voxel resolution 10 × 10 × 15 mm<sup>3</sup>, TE / TR = 40 ms / 2000 ms, complex data points = 1024, sampling frequency = 2000 Hz. The MRSI slice was aligned axially in the subcallosal plane with an approximately 1 mm gap from the upper surface of the corpus callosum. The semi-LASER method ([Scheenen et al., 2008](https://doi.org/10.1002/mrm.21302)) was used localize a 100 × 100 × 15 mm VOI, central to the FOV, four saturation regions were placed around the VOI prescribing a 100 × 100 mm interior, and an additional four saturation regions were positioned to intersect the four corners of the semi-LASER VOI to provide additional scalp lipid suppression. The total acquisition time for a single MRSI scan was 5 min and 6 s, and three MRSI datasets were acquired sequentially during the same session to assess technical repeatability.

### Experimental location

Centre for Human Brain Health, University of Birmingham, Birmingham, UK.

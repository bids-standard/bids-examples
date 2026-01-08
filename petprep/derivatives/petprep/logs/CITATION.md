
Results included in this manuscript come from preprocessing
performed using *PETPrep* 0.0.3
(@fmriprep1; @fmriprep2; RRID:SCR_016216),
which is based on *Nipype* 1.9.2
(@nipype1; @nipype2; RRID:SCR_002502).


Anatomical data preprocessing

: A total of 1 T1-weighted (T1w) images were found within the input
BIDS dataset. The T1w image was corrected for intensity
non-uniformity (INU) with `N4BiasFieldCorrection` [@n4], distributed with ANTs 2.6.2
[@ants, RRID:SCR_004757], and used as T1w-reference throughout the workflow.
The T1w-reference was then skull-stripped with a *Nipype* implementation of
the `antsBrainExtraction.sh` workflow (from ANTs), using OASIS30ANTs
as target template.
Brain tissue segmentation of cerebrospinal fluid (CSF),
white-matter (WM) and gray-matter (GM) was performed on
the brain-extracted T1w using `fast` [FSL (version unknown), RRID:SCR_002823, @fsl_fast].
Brain surfaces were reconstructed using `recon-all` [FreeSurfer 7.4.1,
RRID:SCR_001847, @fs_reconall], and the brain mask estimated
previously was refined with a custom variation of the method to reconcile
ANTs-derived and FreeSurfer-derived segmentations of the cortical
gray-matter of Mindboggle [RRID:SCR_002438, @mindboggle].
Volume-based spatial normalization to one standard space (MNI152NLin2009cAsym) was performed through
nonlinear registration with `antsRegistration` (ANTs 2.6.2),
using brain-extracted versions of both T1w reference and the T1w template.
The following template was were selected for spatial normalization
and accessed with *TemplateFlow* [24.2.2, @templateflow]:
*ICBM 152 Nonlinear Asymmetrical template version 2009c* [@mni152nlin2009casym, RRID:SCR_008796; TemplateFlow ID: MNI152NLin2009cAsym].

PET data preprocessing

: For each of the 2 PET runs found per subject (across all
tasks and sessions), the following preprocessing steps were performed. Robust head
motion estimation and correction were carried out after generating a
reference image, which was subsequently coregistered to the T1-weighted
anatomical image. A brain mask was computed and the structural image was
segmented with the ``gtm`` segmentation workflow from FreeSurfer.
Head-motion parameters with respect to the PET reference
(transformation matrices, and six corresponding rotation and translation
parameters) are estimated before any spatiotemporal filtering using
FreeSurfer's ``mri_robust_template``.
Several confounding time-series were calculated based on the
*preprocessed PET*: framewise displacement (FD), DVARS and
three region-wise global signals.
FD was computed using two formulations following Power (absolute sum of
relative motions, @power_fd_dvars) and Jenkinson (relative root mean square
displacement between affines, @mcflirt).
FD and DVARS are calculated for each PET run, both using their
implementations in *Nipype* [following the definitions by @power_fd_dvars].
The three global signals are extracted within the CSF, the WM, and
the whole-brain masks.
Additionally, a set of physiological regressors were extracted to
allow for component-based noise correction [*CompCor*, @compcor].
Principal components are estimated after high-pass filtering the
*preprocessed PET* time-series (using a discrete cosine filter with
128s cut-off) for the two *CompCor* variants: temporal (tCompCor)
and anatomical (aCompCor).
tCompCor components are then calculated from the top 2% variable
voxels within the brain mask.
For aCompCor, three probabilistic masks (CSF, WM and combined CSF+WM)
are generated in anatomical space.
The implementation differs from that of Behzadi et al. in that instead
of eroding the masks by 2 pixels on PET space, a mask of pixels that
likely contain a volume fraction of GM is subtracted from the aCompCor masks.
This mask is obtained by dilating a GM mask extracted from the FreeSurfer's *aseg* segmentation, and it ensures components are not extracted
from voxels containing a minimal fraction of GM.
Finally, these masks are resampled into PET space and binarized by
thresholding at 0.99 (as in the original implementation).
Components are also calculated separately within the WM and CSF masks.
For each CompCor decomposition, the *k* components with the largest singular
values are retained, such that the retained components' time series are
sufficient to explain 50 percent of variance across the nuisance mask (CSF,
WM, combined, or temporal). The remaining components are dropped from
consideration.
The head-motion estimates calculated in the correction step were also
placed within the corresponding confounds file.
The confound time series derived from head motion estimates and global
signals were expanded with the inclusion of temporal derivatives and
quadratic terms for each [@confounds_satterthwaite_2013].
Frames that exceeded a threshold of 0.5 mm FD or
1.5 standardized DVARS were annotated as motion outliers.
Additional nuisance timeseries are calculated by means of principal components
analysis of the signal found within a thin band (*crown*) of voxels around
the edge of the brain, as proposed by [@patriat_improved_2017].
All resamplings can be performed with *a single interpolation
step* by composing all the pertinent transformations (i.e. head-motion
transform matrices, susceptibility distortion correction when available,
and co-registrations to anatomical and output spaces).
Gridded (volumetric) resamplings were performed using `nitransforms`,
configured with cubic B-spline interpolation.


Many internal operations of *PETPrep* use
*Nilearn* 0.11.1 [@nilearn, RRID:SCR_001362],
mostly within the PET processing workflow.
For more details of the pipeline, see [the section corresponding
to workflows in *PETPrep*'s documentation](https://petprep.readthedocs.io/en/latest/workflows.html "PETPrep's documentation").


### Copyright Waiver

The above boilerplate text was automatically generated by PETPrep
with the express intention that users should copy and paste this
text into their manuscripts *unchanged*.
It is released under the [CC0](https://creativecommons.org/publicdomain/zero/1.0/) license.

### References


Results included in this manuscript come from preprocessing
performed using *PETPrep* 0.0.3
(@fmriprep1; @fmriprep2; RRID:SCR_016216),
which is based on *Nipype* 1.9.2
(@nipype1; @nipype2; RRID:SCR_002502).


Anatomical data preprocessing

: A total of 1 T1-weighted (T1w) images were found within the input
BIDS dataset. The T1w image was corrected for intensity
non-uniformity (INU) with `N4BiasFieldCorrection` [@n4], distributed with ANTs 2.6.2
[@ants, RRID:SCR_004757], and used as T1w-reference throughout the workflow.
The T1w-reference was then skull-stripped with a *Nipype* implementation of
the `antsBrainExtraction.sh` workflow (from ANTs), using OASIS30ANTs
as target template.
Brain tissue segmentation of cerebrospinal fluid (CSF),
white-matter (WM) and gray-matter (GM) was performed on
the brain-extracted T1w using `fast` [FSL (version unknown), RRID:SCR_002823, @fsl_fast].
Brain surfaces were reconstructed using `recon-all` [FreeSurfer 7.4.1,
RRID:SCR_001847, @fs_reconall], and the brain mask estimated
previously was refined with a custom variation of the method to reconcile
ANTs-derived and FreeSurfer-derived segmentations of the cortical
gray-matter of Mindboggle [RRID:SCR_002438, @mindboggle].
Volume-based spatial normalization to one standard space (MNI152NLin2009cAsym) was performed through
nonlinear registration with `antsRegistration` (ANTs 2.6.2),
using brain-extracted versions of both T1w reference and the T1w template.
The following template was were selected for spatial normalization
and accessed with *TemplateFlow* [24.2.2, @templateflow]:
*ICBM 152 Nonlinear Asymmetrical template version 2009c* [@mni152nlin2009casym, RRID:SCR_008796; TemplateFlow ID: MNI152NLin2009cAsym].

PET data preprocessing

: For each of the 1 PET runs found per subject (across all
tasks and sessions), the following preprocessing steps were performed. Robust head
motion estimation and correction were carried out after generating a
reference image, which was subsequently coregistered to the T1-weighted
anatomical image. A brain mask was computed and the structural image was
segmented with the ``gtm`` segmentation workflow from FreeSurfer.
Head-motion parameters with respect to the PET reference
(transformation matrices, and six corresponding rotation and translation
parameters) are estimated before any spatiotemporal filtering using
FreeSurfer's ``mri_robust_template``.
Several confounding time-series were calculated based on the
*preprocessed PET*: framewise displacement (FD), DVARS and
three region-wise global signals.
FD was computed using two formulations following Power (absolute sum of
relative motions, @power_fd_dvars) and Jenkinson (relative root mean square
displacement between affines, @mcflirt).
FD and DVARS are calculated for each PET run, both using their
implementations in *Nipype* [following the definitions by @power_fd_dvars].
The three global signals are extracted within the CSF, the WM, and
the whole-brain masks.
Additionally, a set of physiological regressors were extracted to
allow for component-based noise correction [*CompCor*, @compcor].
Principal components are estimated after high-pass filtering the
*preprocessed PET* time-series (using a discrete cosine filter with
128s cut-off) for the two *CompCor* variants: temporal (tCompCor)
and anatomical (aCompCor).
tCompCor components are then calculated from the top 2% variable
voxels within the brain mask.
For aCompCor, three probabilistic masks (CSF, WM and combined CSF+WM)
are generated in anatomical space.
The implementation differs from that of Behzadi et al. in that instead
of eroding the masks by 2 pixels on PET space, a mask of pixels that
likely contain a volume fraction of GM is subtracted from the aCompCor masks.
This mask is obtained by dilating a GM mask extracted from the FreeSurfer's *aseg* segmentation, and it ensures components are not extracted
from voxels containing a minimal fraction of GM.
Finally, these masks are resampled into PET space and binarized by
thresholding at 0.99 (as in the original implementation).
Components are also calculated separately within the WM and CSF masks.
For each CompCor decomposition, the *k* components with the largest singular
values are retained, such that the retained components' time series are
sufficient to explain 50 percent of variance across the nuisance mask (CSF,
WM, combined, or temporal). The remaining components are dropped from
consideration.
The head-motion estimates calculated in the correction step were also
placed within the corresponding confounds file.
The confound time series derived from head motion estimates and global
signals were expanded with the inclusion of temporal derivatives and
quadratic terms for each [@confounds_satterthwaite_2013].
Frames that exceeded a threshold of 0.5 mm FD or
1.5 standardized DVARS were annotated as motion outliers.
Additional nuisance timeseries are calculated by means of principal components
analysis of the signal found within a thin band (*crown*) of voxels around
the edge of the brain, as proposed by [@patriat_improved_2017].
All resamplings can be performed with *a single interpolation
step* by composing all the pertinent transformations (i.e. head-motion
transform matrices, susceptibility distortion correction when available,
and co-registrations to anatomical and output spaces).
Gridded (volumetric) resamplings were performed using `nitransforms`,
configured with cubic B-spline interpolation.


Many internal operations of *PETPrep* use
*Nilearn* 0.11.1 [@nilearn, RRID:SCR_001362],
mostly within the PET processing workflow.
For more details of the pipeline, see [the section corresponding
to workflows in *PETPrep*'s documentation](https://petprep.readthedocs.io/en/latest/workflows.html "PETPrep's documentation").


### Copyright Waiver

The above boilerplate text was automatically generated by PETPrep
with the express intention that users should copy and paste this
text into their manuscripts *unchanged*.
It is released under the [CC0](https://creativecommons.org/publicdomain/zero/1.0/) license.

### References


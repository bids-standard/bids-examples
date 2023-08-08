# The National Institute of Mental Health (NIMH) Intramural Healthy Volunteer Dataset

A comprehensive dataset characterizing healthy research volunteers in terms of clinical assessments, mood-related psychometrics, cognitive function neuropsychological tests, structural and functional magnetic resonance imaging (MRI), along with diffusion tensor imaging (DTI), and a comprehensive magnetoencephalography battery (MEG).

In addition, blood samples are currently banked for future genetic analysis.  All data collected in this protocol are broadly shared in the OpenNeuro repository, in the Brain Imaging Data Structure (BIDS) format.  In addition, task paradigms and basic pre-processing scripts are shared on GitHub.  This dataset is unprecedented in its depth of characterization of a healthy population and will allow a wide array of investigations into normal cognition and mood regulation.

This dataset is licensed under the [Creative Commons Zero (CC0) v1.0 License](https://creativecommons.org/publicdomain/zero/1.0/).

## Participant Eligibility

To be eligible for the study, participants need to be medically healthy adults over 18 years of age with the ability to read, speak and understand English.  All participants provided electronic informed consent for online pre-screening, and written informed consent for all other procedures.  Participants with a history of mental illness or suicidal or self-injury thoughts or behavior are excluded.  Additional exclusion criteria include current illicit drug use, abnormal medical exam, and less than an 8th grade education or IQ below 70.  Current NIMH employees, or first degree relatives of NIMH employees are prohibited from participating.  Study participants are recruited through direct mailings, bulletin boards and listservs, outreach exhibits, print advertisements, and electronic media.

## Clinical Measures

All potential volunteers visit [the study website](https://nimhresearchvolunteer.ctss.nih.gov), check a box indicating consent, and fill out preliminary screening questionnaires.  The questionnaires include basic demographics, the World Health Organization Disability Assessment Schedule 2.0 (WHODAS 2.0), the DSM-5 Self-Rated Level 1 Cross-Cutting Symptom Measure, the DSM-5 Level 2 Cross-Cutting Symptom Measure - Substance Use, the Alcohol Use Disorders Identification Test (AUDIT), the Edinburgh Handedness Inventory, and a brief clinical history checklist.  The WHODAS 2.0 is a 15 item questionnaire that assesses overall general health and disability, with 14 items distributed over 6 domains: cognition, mobility, self-care, “getting along”, life activities, and participation.  The DSM-5 Level 1 cross-cutting measure uses 23 items to assess symptoms across diagnoses, although an item regarding self-injurious behavior was removed from the online self-report version.  The DSM-5 Level 2 cross-cutting measure is adapted from the NIDA ASSIST measure, and contains 15 items to assess use of both illicit drugs and prescription drugs without a doctor’s prescription.  The AUDIT is a 10 item screening assessment used to detect harmful levels of alcohol consumption, and the Edinburgh Handedness Inventory is a systematic assessment of handedness.  These online results do not contain any personally identifiable information (PII).  At the conclusion of the questionnaires, participants are prompted to send an email to the study team. These results are reviewed by the study team, who determines if the participant is appropriate for an in-person interview.

Participants who meet all inclusion/exclusion criteria are scheduled for an in-person screening visit.  At this visit, participants receive a Structured Clinical Interview for DSM-5 Disorders (SCID-5), the Beck Depression Inventory-II (BDI-II), Beck Anxiety Inventory (BAI), the Kaufman Brief Intelligence Test, Second Edition (KBIT-2), and the NIH Toolbox Cognition Battery.  The purpose of these cognitive and psychometric tests is two-fold.  First, these measures are designed to provide a sensitive test of psychopathology.  Second, they provide a comprehensive picture of cognitive functioning, including mood regulation.  The SCID-5 is a structured interview, administered by a clinician, that establishes the absence of any DSM-5 axis I disorder.  The BDI-II is a 21 item self-report measure that assesses the presence and severity of depressive symptoms, while the BAI is a 21 item self-report measure assessing the presence and severity of anxiety symptoms.  The KBIT-2 is a brief (20 minute) assessment of intellectual functioning administered by a trained examiner.  There are three subtests, including verbal knowledge, riddles, and matrices.  The NIH Toolbox Cognition Battery consists of a series of seven tests.  A flanker inhibitory control and attention task assesses the constructs of attention and executive functioning.  Executive functioning is also assessed in the battery using a dimensional change card sort test.  Episodic memory is evaluated using a picture sequence memory test, while working memory is evaluated using a list sorting test.  The battery includes two language tests, a picture vocabulary test and an oral reading recognition test.  Finally, processing speed is assessed using a pattern comparison processing speed test.

## Biological and physiological measures

Biological and physiological measures are acquired, including blood pressure, pulse, weight, height, and BMI.  Blood and urine samples are taken and a complete blood count, acute care panel, hepatic panel, thyroid stimulating hormone, viral markers (HCV, HBV, HIV), c-reactive protein, creatine kinase, urine drug screen and urine pregnancy tests are performed.  In addition, blood samples for genetic testing are collected and banked, and genetic information will be shared once it is available.

## Imaging Studies

Participants were given the option to enroll in optional magnetic resonance imaging (MRI) and magnetoencephalography (MEG) studies.

### MRI

The MRI protocol used was initially based on the ADNI-3 basic protocol, but was later modified to include portions of the ABCD protocol in the following manner:

1. The T1 scan from ADNI3 was replaced by the T1 scan from the ABCD protocol.
2. The Axial T2 2D FLAIR acquisition from ADNI2 was added, and fat saturation turned on.
3. Fat saturation was turned on for the pCASL acquisition.
4. The high-resolution in-plane hippocampal 2D T2 scan was removed, and replaced with the whole brain 3D T2 scan from the ABCD protocol (which is resolution and bandwidth matched to the T1 scan).
5. The slice-select gradient reversal method was turned on for DTI acquisition, and reconstruction interpolation turned off.
6. Scans for distortion correction were added (reversed-blip scans for DTI and resting state scans).
7. The 3D FLAIR sequence was made optional, and replaced by one where the prescription and other acquisition parameters provide resolution and geometric correspondence between the T1 and T2 scans.

### MEG

The optional MEG studies were added to the protocol approximately one year after the study was initiated, thus there are relatively fewer MEG recordings in comparison to the MRI dataset.  MEG studies are performed on a 275 channel CTF MEG system.  The position of the head was localized at the beginning and end of the recording using three fiducial coils.  These coils were placed 1.5 cm above the nasion, and at each ear, 1.5 cm from the tragus on a line between the tragus and the outer canthus of the eye.  For some participants, photographs were taken of the three coils and used to mark the points on the T1 weighted structural MRI scan for co-registration.  For the remainder of the participants, a BrainSight neuronavigation unit was used to coregister the MRI, anatomical fiducials, and localizer coils directly prior to MEG data acquisition.

## Specific Survey and Test Data within Data Set

### 1. Preliminary Online Screening Questionnaires

|  Survey or Test                                                             |  BIDS TSV Name                 |
| --------------------------------------------------------------------------- | ------------------------------ |
|  Alcohol Use Disorders Identification Test (AUDIT)                          |  audit.tsv                     |
|  Demographics                                                               |  demographics.tsv              |
|  Drug Use Questionnaire                                                     |  drug_use.tsv                  |
|  Edinburgh Handedness Inventory (EHI)                                       |  ehi.tsv                       |
|  Health History Questions                                                   |  health_history_questions.tsv  |
|  Health Rating                                                              |  health_rating.tsv             |
|  Mental Health Questions                                                    |  mental_health_questions.tsv   |
|  World Health Organization Disability Assessment Schedule 2.0 (WHODAS 2.0)  |  whodas.tsv                    |

### 2. On-Campus In-Person Screening Visit

|  Survey                                                                                      |  BIDS TSV Name                |
| -------------------------------------------------------------------------------------------- | ----------------------------- |
|  Adverse Childhood Experiences (ACEs)                                                        |  ace.tsv                      |
|  Beck Anxiety Inventory (BAI)                                                                |  bai.tsv                      |
|  Beck Depression Inventory-II (BDI-II)                                                       |  bdi.tsv                      |
|  Clinical Variable Form                                                                      |  clinical_variable_form.tsv   |
|  Family Interview for Genetic Studies (FIGS)                                                 |  figs.tsv                     |
|  Kaufman Brief Intelligence Test 2nd Edition (KBIT-2) and Vocabulary Assessment Scale (VAS)  |  kbit2_vas.tsv                |
|  NIH Toolbox Cognition Battery                                                               |  nih_toolbox.tsv              |
|  Perceived Health Rating                                                                     |  perceived_health_rating.tsv  |
|  Satisfaction Survey                                                                         |  satisfaction.tsv             |
|  Structured Clinical Interview for DSM-5 Disorders (SCID-5)                                  |  scid5.tsv                    |

|  Test                                    |  BIDS TSV Name              |
| ---------------------------------------- | --------------------------- |
|  Acute Care Panel                        |  acute_care.tsv             |
|  Blood Chemistry                         |  blood_chemistry.tsv        |
|  Complete Blood Count with Differential  |  cbc_with_differential.tsv  |
|  Hematology Panel                        |  hematology.tsv             |
|  Hepatic Function Panel                  |  hepatic.tsv                |
|  Infectious Disease Panel                |  infectious_disease.tsv     |
|  Lipid Panel                             |  lipid.tsv                  |
|  Other Panel                             |  other.tsv                  |
|  Urinalysis                              |  urinalysis.tsv             |
|  Urine Chemistry                         |  urine_chemistry.tsv        |
|  Vitamin Levels                          |  vitamin_levels.tsv         |

### 3. Optional On-Campus In-Person MRI Visit

|  Survey         |  BIDS TSV Name      |
| --------------- | ------------------- |
|  MRI Variables  |  mri_variables.tsv  |

## Preparation Notes

In many of the Clinical Measures data files, there exist `-999` values.  `-999` means there was no response though a response was possible.  The question may have been skipped over by the participant or the question flow.  `-777` appears in the Edinburgh Handedness Inventory (EHI) as well.  `-777` means there is no data available for a response.  The question was not presented or asked to the participant.

The data were prepared using the following tools and filename mappings.

### Clinical Measures Data

The `ctdb_clean_up.ipynb` Jupyter Notebook contains the python functions used to clean and convert the spreadsheet downloaded from CTDB to BIDS-standard TSV files as well as their respective data dictionaries converted to BIDS-standard JSON files.

### Biological and Physiological Measures Data

The `cris_clean_up.ipynb` Jupyter Notebook contains the Python functions used to clean and convert the spreadsheet with clinical measures to BIDS-standard TSV files and their data dictionaries to BIDS-standard JSON files.

### BIDS-standard MEG Files

Data collected by the NIMH MEG Core was converted to BIDS-standard files using the MNE BIDS package.  Associated notebooks: `1_mne_bids_extractor.ipynb` & `2_bids_editor.ipynb`.

### BIDS-standard MRI

We used the `heudiconv` tool to convert MRI DICOM files to BIDS-standard files with the associated script: `heuristic_rvol.py`.  A modified workflow of `pydeface` was used to deface structural scans with the associated notebook: `modified-workflow-pydeface.ipynb`

Each participant received either the ADNI3 or the ABCD protocol, not both, during their MRI/MEG visit.  T1w scans with acquisition label `fspgr` are ADNI3 protocol sequence and scans with `mprage` acquisition labels are ABCD protocol sequence.

### Protocol PDFs

GE MRI scanner protocol PDFs are located within the `sourcedata/` folder, named after their BIDS tree file names.  In the parameter called "Auto SCIC", if it is set to 2 then both "Orig" (original) and "SCIC" (GE’s proprietary Surface Coil Intensity Correction algorithm) images are created.  Therefore one PDF with an Auto SCIC setting of "2" represents two images in the dataset.

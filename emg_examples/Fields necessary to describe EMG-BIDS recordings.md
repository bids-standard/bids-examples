# **Fields necessary to describe EMG-BIDS recordings**

EMG signals can be handily converted to BIDS-supported data format under the EEG-BIDS guidelines. Also, many of the [EEG-BIDS metadata](https://bids-specification.readthedocs.io/en/stable/04-modality-specific-files/03-electroencephalography.html) and [iEEG-BIDS metadata](https://bids-specification.readthedocs.io/en/stable/modality-specific-files/intracranial-electroencephalography.html) can cross over to EMG. Still, there are also specific metadata that should be defined to ensure reusability, and transparency of the data (following the FAIR principles).

In this document, we try to 1\) determine the shared EEG/iEEG-BIDS specifications that can carry over or require expansion of definition, and 2\) determine the EMG-BIDS specific terms.

Details with regard to the signals on disk (file format, channels.tsv, etc) are already settled upon in the main BEP document at [https://docs.google.com/document/d/1G5\_Eu2OemcZXS9xOGINPA6SUTaZOml7LBmZCMnUhTXA/edit](https://docs.google.com/document/d/1G5_Eu2OemcZXS9xOGINPA6SUTaZOml7LBmZCMnUhTXA/edit) 

To be agreed upon terminology:  
EMG \= any type of electromyography  
sEMG \= surface EMG, to be distinguished from needle EMG  
iEMG \=? "invasive/intramuscular needle EMG"? **(currently out of scope)**  
HDsEMG \= high-density surface EMG. What defines high density? The IED and/or the number of electrodes?  
HDiEMG \=? Is there also high density invasive EMG? Like with neuropixel probes or so?

1. ## Shared EEG-BIDS terms applicable for EMG-BIDS

[https://bids-specification.readthedocs.io/en/stable/modality-specific-files/electroencephalography.htm](https://bids-specification.readthedocs.io/en/stable/modality-specific-files/electroencephalography.html#electrodes-description-_electrodestsv)

[https://bids-specification.readthedocs.io/en/stable/modality-specific-files/intracranial-electroencephalography.html](https://bids-specification.readthedocs.io/en/stable/modality-specific-files/intracranial-electroencephalography.html)

Shared with all other BIDS modalities would be lab/institute information, participant information, dataset\_description, etc. 

Shared with EEG and iEEG would be the documentation of the amplifiers (make and model), the documentation of the electrodes (make, model, material), settings of the amplifiers, etc.

It is in the placement of the electrodes and the configuration of the montage that EMG starts to differ, and that is what is detailed below. 

2. ## sEMG specific metadata

Features are without any specific order in this iteration. After concluding the features of each section, features can be grouped into appropriate fields, sidecards, etc.

| Field Name | Data Type | Description | Existing in BIDS | Definition / Action |
| :---- | :---- | :---- | :---- | :---- |
| Manufacturer | String | Manufacturer of the EMG acquisition system. | Yes | Use existing field |
| ManufacturersModelName | String | Model name of the EMG acquisition system. | Yes | Use existing field |
| SamplingFrequency | Float | Sampling frequency of the EMG recording in Hz. | Yes | Use existing field |
| PowerLineFrequency | Float | Frequency of the power grid in the recording environment (Hz), typically 50 or 60 Hz. | Yes | Use existing field  |
| SoftwareFilters | String | Description of software filters applied during acquisition. | Yes | Use existing field  |
| HardwareFilters | String | Description of hardware filters applied during acquisition. | Yes | Use existing field |
| RecordingType | String | Specifies whether the recording is 'continuous' or 'epoched'. | Yes | Use existing field |
| MontageType | String | Indicates whether the recording setup is 'monopolar' or 'bipolar'. | No | Define as new field MontageType. |
| EMGChannelCount | Integer | Number of EMG channels recorded. | No | Define as new field EMGChannelCount. |
| EMGReference | String | Description of the reference used in the EMG recording. | No | Define as new field EMGReference |
| EMGGround | String | Description of the ground electrode location. | No | Define as new field EMGGround. |
| TaskName | String | Name of the task performed during the EMG recording. | Yes | Use existing field |
| Instructions | String | Instructions given to the participant. | Yes | Use existing field |
| EMGPlacementScheme | String | Description of the placement scheme of EMG electrodes (e.g., muscle groups targeted, location methods). | No | Define as new field EMGPlacementScheme. |
| TargetMuscle | String | Muscle(s) targeted by the EMG recording. | No | Define as new field TargetMuscle; include in channels.tsv. |
| EMGElectrodeCount | Integer | Number of total electrodes (inclusive of reference and ground) | No | Define as a new field |
| InterElectrodeDistance | Float | Distance between electrodes in millimeters. | No | Define as new field InterElectrodeDistance; include in electrodes.tsv. |
| ElectrodeGroup | String | Grouping of electrodes (e.g., grids, arrays); similar to iEEGElectrodeGroups. | Yes (in iEEG) | Use existing field |
| ElectrodeOrientation | String | Orientation of the electrodes relative to muscle fibers (e.g., parallel, perpendicular). | No | Define as new field ElectrodeOrientation; include in electrodes.tsv. |
| SkinPreparation | String | Description of the skin preparation method before electrode placement (e.g., alcohol wipe, abrasive gel). | No | Define as new field SkinPreparation. |
| EMGPlacement | String | The name of a standardized electrode placement procedure (for example, \`"SENIAM"\`) or a description of the electrode placement procedure used. Descriptions SHOULD reflect the process used by the researcher(s) when placing electrodes, and SHOULD NOT simply give the name of the targeted muscle (use \`TargetMuscle\` for that). For example, EMG electrode sites may be chosen by visual reference to target muscles, by palpation of the skin to locate target muscles, by functional localization (temporary electrode placement at several sites during prescribed behavior, until a site yielding strong EMG signal is found), or by measured distances (either absolute or proportional) relative to skeletal landmarks. | No | Define as new field ElectrodePlacementMethod. |
| AmplifierType | String | Description of the amplifier used, including type (e.g., wired, wireless) and model. | No | Define as new field AmplifierType. |
| ElectrodeMaterial | String | Material of the electrodes (e.g., Ag/AgCl, gold). | Yes | Use existing field |
| ElectrodeType | String | Type of electrodes used (e.g., cylindrical, circular). | Yes  | Use existing field |
| ElectrodeManufacturer | String | Manufacturer of the EMG electrode modules (if different from amplifier manufacturer). | Yes | Define as new field ModuleManufacturer. |
| ElectrodeManufacturersModelName | String | Model name of the EMG electrode modules. | Yes | Define as new field ModuleModelName. |
| ~~RecordingDirection~~ | ~~String~~ | ~~Specifies the axis of bipolarity if recording is bipolar (e.g., longitudinal, transverse).~~ | ~~No~~ | ~~Define as new field RecordingDirection.~~ |
| ReferenceLocation | String | Location of the reference electrode if used (e.g., mastoid process, medial bony landmark of the elbow). | No | Define as new field ReferenceLocation. |

**UPDATE 4/12/2024**  
It seems that the community is more inclined to have a unified EMG-BIDS, spanning the high-density EMG, EMG, (and probably intramuscular EMG). The datatype column will be used to indicate which modality (sEMG, hdsEMG and iEMG) would be 

## 

## General discussion following from the examples

We discussed various ways to document the electrode placement and the montage in the different examples below.

* Option 1: (Sentence Description, human-readable, not machine readable)  
* Option 2: Coordinates expressed in numbers within a defined coordinate frame  
* Option 3: Using a standard such as [SENIAM.org](http://SENIAM.org) (not machine readable, not versioned, not explicit in the sense that you cannot say "SENIAM montage number 14" so still requires copying and pasting multiple pieces of text into a sentence)

We settled on a mix of option 1 and 3, use free text with (where possible) terminology from an external authoritative source like SENIAM. Besides a textual (human readable) description, there are minimally required metadata fields to be specified. 

RULE: If EMG recording is done using a single bipolar it is FORBIDDEN to mention the reference, If it is unipolar, the  reference MUST be documented. If it is double bipolar … (needs to be discussed but not now)  This also leads to the requirement to first document the recording type (single bipolar, unipolar, double bipolar, etc?) and based on that the reference (or not).

RULE: The "where on the muscle/body" are the electrodes placed is described in a free-format sentence. The sentence also goes in the emg.json but mayis not be machine-readable (for now, unless AI overtakes us) and requires human interpretation.  
Where and how EMG signals can be recorded:  
Single site, single/dual channel  
Single site, multi channel  
Mutli site, single channel per site  
Multi site, multi channel per site

RULE: electrode positions are described using a RECOMMENDED **photo or drawing**, and using a REQUIRED textual description of the placement procedure, and (sometimes, very rarely) using an OPTIONAL electrode.tsv file with the 3D position recording device like a Polhemus

DEFINITION question: what is a device? If multiple wireless units record synchronously at the same sampling rate, we decide here to refer to that as a "single device". BIDS-EMG only needs to be defined for a "single device". When multiple devices are used, these are in separate files, each with separate metadata.  

I (= Robert) have noticed both in this paper [https://sci-hub.se/10.1109/taee.2018.8476126](https://sci-hub.se/10.1109/taee.2018.8476126) and in [https://myoware.com/wp-content/uploads/2022/03/MyoWare\_v2\_QuickStartGuide.pdf](https://myoware.com/wp-content/uploads/2022/03/MyoWare_v2_QuickStartGuide.pdf) that the ground electrode is IMHO inconsistently called the reference electrode. If this is a more commonly occuring discrepancy between the EMG field and the other biopotential fields (like EEG, iEEG, which are already defined in BIDS), then we must make sure in the specification that ground and ref are properly defined (as we don't want people to mix them up. This is a search result from a random google that explains the difference consistent with how I have been trained in the terms: [https://www.biopac.com/knowledge-base/ground-vs-reference-for-eeg-recording/](https://www.biopac.com/knowledge-base/ground-vs-reference-for-eeg-recording/). The role of the ground electrode is also nicely explained here [http://eegget-it.nl/eeg\_electrodes.html](http://eegget-it.nl/eeg_electrodes.html). It introduces the terms "single ended" and "differential". These could be used instead of "without ground" and "with ground" that I introduced above. However, [https://en.wikipedia.org/wiki/Differential\_amplifier](https://en.wikipedia.org/wiki/Differential_amplifier) does make it more complex again, as not all schemas are explicit about the common ground.   
The example 1 (and the pursuant discussion) demonstrated that an important aspect is whether the EMG montage is monopolar or bipolar. **Considering N channels and M electrodes** for a single amplifier, then    
   
Bipolar setup: M \= 2\*N \+ 1  
Unipolar: M  \= N \+ 2

If N (number of channels) \= 1 as in this example, then M=3 in both cases and monopolar and bipolar cannot be distinguished. So this example can be documented either as monopolar or as bipolar. In the discussion it became clear that for a bipolar montage it is "not so" relevant to describe which electrode is the reference. In a monopolar montage the location of the reference MUST be documented, as very often the data must be re-referenced to a bipolar montage in the analysis.

Since in the discussion on how to document this dataset we did not reach agreement on documenting the reference, the agreement was to document this specific dataset it as a "bipolar" recording, making the reference optional. 

Number of channels, number of electrodes and monopolar/bipolar have some redundancy, since M\_bipolar \= 2\*N+1 and M\_monopolar \= N \+ 2\. We can choose to keep this redundancy, like a [CRC](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) it allows to check internal consistency.     

The examples in 6 and 7 actually don't fit these two equations, because they don't have a shared ground between sensors (in 7\) and/or don't even have a ground (as in 6). I do believe the equations to hold for examples 1, 2, 3, 4 and probably also 5\. The two equations are to be extended with

Bipolar without ground M \= 2\*N  
Unipolar without ground M \= N \+ 1

Should we therefore document the montage as a string that is taken from the list with length 4 \['bipolar with ground', 'unipolar with ground', 'bipolar without ground', 'unipolar without ground'\].

## Example 1 (custom-made bipolar system)

How would this be documented?

![][image1]  
See [https://www.semanticscholar.org/paper/Design-of-a-Low-Cost-Robotic-Arm-controlled-by-EMG-Artal-Sevil-Ac%C3%B3n/d8e92b61697c3f9c7aefef7c0ee687ce8166cd56](https://www.semanticscholar.org/paper/Design-of-a-Low-Cost-Robotic-Arm-controlled-by-EMG-Artal-Sevil-Ac%C3%B3n/d8e92b61697c3f9c7aefef7c0ee687ce8166cd56) for details.

### Key elements to document:

#### *Textual description*

"*EMG was recorded from the **flexors of the lower arm close to the elbow** using a **bipolar montage** with **one channel**. A pair of two electrodes was **placed 20 mm apart** where the **center of the pair was placed at 50 % on the line between the posterior crista of the acromion and the olecranon at 2 finger widths lateral to the line.** The **orientation of the electrode pair was aligned in parallel with the fiber orientation** of the muscle.. The third **ground electrode** was placed on the medial bony landmark of the elbow."*

#### *Proposed machine-readable metadata in a JSON or TSV file*

Which muscle was targeted \= flexor carpi radialis, pronator teres, brachioradialis  
What orientation \= along the direction of the muscle fibers  
How many electrodes are placed \= 3?  
How many channels result from this \= 2?   
is it a mono/bipolar montage \= bipolar 

### Discussion:

There are three electrodes and **one channel.**  Assumption: Two active electrodes (one the \+, the other one the \-), one Ground electrode

Technical aspects that are specified in this sentence above: **how many electrodes are placed (3)**, **how many channels result from these (1)**, **is it a mono/bipolar montage (bipolar)**, **how fast electrodes are from each other (20mm)**, **which muscle (biceps brachii), which orientation (along fiber direction)**. Besides the sentence itself, these six items are to  be considered to be added as separate items in the BIDS metadata  to make the data searchable and machine interpretable.

●      **MontageType**: Bipolar  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 1  
●      **TargetMuscle**: Flexor carpi radialis, pronator teres, brachioradialis  
●      **EMGPlacementScheme**: Center of electrode pair placed at 50% on the line between the posterior crista of the acromion and the olecranon, 2 finger widths lateral.  
●      **EMGElectrodeCount**: 3  
●      **InterElectrodeDistance**: 20 mm  
●      **ElectrodeOrientation**: Parallel to muscle fibers  
●      **RecordingDirection**: Longitudinal  
●      **EMGGround**: Medial bony landmark of the elbow  
●      **ElectrodePlacementMethod**: Anatomical landmarks  
●      **SkinPreparation**: Alcohol wipe  
●      **ElectrodeType**: Surface electrodes  
●      **ElectrodeMaterial**: Ag/AgCl  
●      **AmplifierType**: Wired custom amplifier  
●      **ReferenceLocation**: Not applicable (bipolar recording)

## Example 2 (custom bipolar pads, commercial modules)

![][image2]  
See [https://logemas.com/knowledge-base/faq/how-do-i-attach-my-emg-sensors/](https://logemas.com/knowledge-base/faq/how-do-i-attach-my-emg-sensors/) for details.

### Key elements to document:

#### *Textual description*

"6 bipolar EMG modules were placed on the right arm. 5 were placed on the lower arm and one was placed on the hand. See channels.tsv for the mapping between channels and muscles."  

#### *Proposed machine-readable metadata in a JSON or TSV file*

Which muscle was targeted \= here it is multiple, so this must be listed in the channels.tsv   
What orientation \= again multiple (for each site, in the direction of the muscle fibers)  
How many electrodes are placed \= 12  
How many channels result from this \= 6   
Is it a mono/bipolar montage \= bipolar  and there is no ground

### Discussion:

There appear to be six bipolar channels.

In this example, electrode locations may not be relevant. Individual electrode voltages are not transferred or recorded by the instrument.

This is bipolar as you can see the wireless EMG sensors connected to each pair of electrodes. With this setup the number of signals that are recorded would be equal to the number of muscles. Based on the figure, this would be **6 muscles** and hence **N= 6 channels**, M \= 2\*6+1=**13 electrodes** (or **12 electrodes** as there may be no ground), and 6 bipolar EMG signals. 

If you want to achieve the same with a monopolar amplifier, we also place 2\*6 electrodes on the 6 muscles and probably separate reference and ground electrodes so 14 electrodes. 12 monopolar EMG signals would be recorded. In this case, you would have the choice to store the data either as monopolar EMG or make offline bipolar derivatives and store those. The format of how the data would be stored and reported would be different, so I believe the distinction between monopolar and bipolar is not redundant.

●      **MontageType**: Bipolar  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 6  
●      **TargetMuscle**: Multiple (listed in channels.tsv)  
●      **EMGPlacementScheme**: Electrodes placed on lower arm and hand muscles; see channels.tsv for details.  
●      **InterElectrodeDistance**: n/a  
●      **EMGElectrodeCount**: 12  
●      **ElectrodeOrientation**: Parallel to muscle fibers  
●      **RecordingDirection**: Longitudinal  
●      **EMGGround**: n/a  
●      **ElectrodePlacementMethod**: Anatomical landmarks  
●      **SkinPreparation**: n/a  
●      **ElectrodeType**: Dry electrodes  
●      **ElectrodeMaterial**: n/a  
●      **AmplifierType**: Wireless amplifier with wires to the electrodes  
●      **ReferenceLocation**: n/a

## Example 3 (custom monopolar placement)

![][image3]  
See [https://www.isca-archive.org/interspeech\_2006/jou06\_interspeech.pdf](https://www.isca-archive.org/interspeech_2006/jou06_interspeech.pdf) for details.

### Key elements to document:

#### *Textual description:* 

"Multiple electrodes were placed over the lower face to record from the articulatory muscles."

#### *Proposed machine-readable metadata in a JSON or TSV file*

how many electrodes are placed \= 12 \+1  
how many channels result from this \= 6    
is it a mono/bipolar montage \= Assumed **bipolar**,  
which muscle \= See below, here it is multiple, so this must also be a list in the channels.tsv   
What orientation \= ???

The channels.tsv file would contain the following (one column with EMGx as channel\_name, one column with the **targetMuscle**):

EMG1 \= tongue, anterior belly of the digastric  
EMG2 \= levator angulis oris, zygomaticus major  
EMG3 \= levator angulis oris, zygomaticus major  
EMG4 \= platysma  
EMG5 \= orbicularis oris  
EMG6 \= tongue

### Discussion:

There is in general a ***many-to-many*** mapping between sensors and muscles: one muscle can be recorded by multiple channels, and multiple channels can record one muscle's activity. So, both target muscles and electrodes location wrt to the muscles are important.

Descriptions of electrode location should reflect the process by which electrodes were placed. For example, surface muscles on physically fit subjects may be located visually; smaller or deeper muscles (or subjects with less muscular definition) may require palpation to determine location of the muscle. In extreme cases, functional localization (temporary electrode placement during prescribed contractions to determine which location yields optimal EMG signal) may be employed.

Target Muscles and electrode placement are not necessarily identical. There might be different ways to record from a single muscle using different placements.

Skeletal (bony) references are used for EEG electrode placement. They can also be used for muscles that attach directly to the skeleton or skull. Many facial muscles (used for expression and therefore often studied in relation to cognitive neuroscience and communication) attach only to soft tissue. Also sphincter muscles are not attached to bone.      

Electrode (when monopolar) or electrode pair (aka channel) placement (when bipolar) can be according to a systematic procedure using landmarks and numerical coordinates (**Anatomical/Landmark localizer**), to a systematic procedure using fractions (that imply scaling to the participant, like "Slightly medial of the distal 1/4 of the 1st ossa metacarpalia (SENIAM)"), or according to a **functional localizer** and for example palpating.

Should we request the method that the fucntional/anatomical localizer is used? Example palpation may be functional but it is different from asking the perosn to move or contract their muscle and then locate the muscle.

. 

Functional localizer example:  
Here is an example dataset (through google dataset search):   
Example 3 (probably)

[https://data.mendeley.com/datasets/ckwc76xr2z/2](https://data.mendeley.com/datasets/ckwc76xr2z/2)  
The placement information that is provided is *"The approximate locations of four forearm muscles were determined by an expert physician." 😒*

Here another example:   
[10.5281/zenodo.5189274](https://doi.org/10.5281/zenodo.5189274)  
Placement information consists of: *"Each subject wore the Myo-armband on the forearm. Electrodes were aligned along the palm side of the wrist with Ch4 placed on Pronator Teres muscle as shown in Figure 1 (and a photo is shown)."*

Anatomical/landmark localizer example:

Example 5: The electrodes were placed approximately 3 cm from elbow (elbow to closest electrode corner) and 2 cm from ulna (edge of the ulna to edge of the electrode).

Recording from the back muscles usually use "anatomical" localizers, for example:  
[https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0287588](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0287588):Trigno EMGs sensors (Delsys Inc, Boston, MA) placed at L3 height and about 3cm left and right from the spinous process.

Placement according to SENIAM maybe also categorized as anatomical localizers:  
[https://www.sciencedirect.com/science/article/pii/S0966636223000711](https://www.sciencedirect.com/science/article/pii/S0966636223000711): Activity of lateral gastrocnemius (LG), medial gastrocnemius (MG), soleus (SOL), and tibialis anterior (TA) was measured simultaneously through surface electromyography (EMG) at 1000 Hz (ZeroWire EMG Aurion, Cometa, Italy). Electrodes (Ambu Blue Sensor, Ballerup, Denmark) were placed according to SENIAM guidelines \[23\].

This abstract ([https://doi.org/10.1016/j.gaitpost.2022.07.014](https://doi.org/10.1016/j.gaitpost.2022.07.014)) compares SENIAM (with measuring tape, anatomical localizer) with palpation (functional localizer) for kids with Cerebral Palsy. They found muscle activity duration for the muscles that anatomical and functional locations were significantly different, the activity duration was also significantly different but \[as one can expect\] not clinically relevant.  

     

The difference between this example and example 2 are:

1. Example 2 is a one-to-one mapping, and example 3 is one-to-many mapping.  
2. Electrode locations in example 3 might be harder to describe as **numerical values**. A **functional localizer** (i.e., putting electrodes based on muscle activity).  
     
   This was discussed in detail in a zoom call on 22 Oct 2024, but nothing was written down. On 6 Nov we discussed this again and added some notes. 

   ●      **MontageType**: Monopolar

   ●      **RecordingType**: Continuous

   ●      **EMGChannelCount**: 6

   ●      **TargetMuscle**: EMG1 \= tongue, anterior belly of the digastric  
   			EMG2 \= levator angulis oris, zygomaticus major  
   			EMG3 \= levator angulis oris, zygomaticus major

   EMG4 \= platysma  
   	EMG5 \= orbicularis oris

   EMG6 \= tongue

   ●      **EMGPlacementScheme**: Electrodes placed over articulatory muscles on the lower face.

   ●      **InterElectrodeDistance**: n/a

   ●      **EMGElectrodeCount**: 13

   ●      **ElectrodeOrientation**: n/a

   ●      **EMGGround**: n/a

   ●      **ReferenceLocation**: Behind the ear (Mastoid?)

   ●      **ElectrodePlacementMethod**: Functional localization

   ●      **SkinPreparation**: Alcohol wipe

   ●      **ElectrodeType**: Surface electrodes

   ●      **ElectrodeMaterial**: Ag/AgCl

   ●      **AmplifierType**: Wired

## 

## Example 4 (high-density grid)

![][image4]  
[https://info.tmsi.com/blog/facial-muscles-hd-emg-grids-sample-data](https://info.tmsi.com/blog/facial-muscles-hd-emg-grids-sample-data)

### Key elements to document:

#### *Textual description:*

"EMG was recorded on the face over the left cheek and jaw area with a high-density electrode grid" 

#### *Proposed machine-readable metadata in a JSON or TSV file*

how many electrodes are placed \= 64+2  
how many channels result from this \= 64   
is it a mono/bipolar montage \= monopolar  
which muscle \= multiple  
What orientation \= ???

### Discussion:

It is an 8x8 electrode grid with a common reference (on the left mastoid). The presence or placement of a ground electrode is not specified. Assuming data is stored in BIDS, how should we know which channel is which, and how would I make in the processing off-line bipolar montages in the horizontal and/or vertical direction? Is there any way of documenting this without a photo or drawing?

This example also requires documenting that most electrodes are arranged here in a grid, the number of rows and columns, IED along rows, IED along columns, how the grid is angled relative to the anatomy, and how channel numbers relate to the grid (row-first, column-first, etc). Do these details go in a controlled field, or in a free text string? One idea is to specify the anatomical location (e.g., relative to bony landmarks) of only one electrode in the grid (probably a corner electrode), and then describe the location of all other electrodes in the grid in `electrodes.tsv` (specified ***relative*** to the location of the landmarked electrode, which will have **coordinates (0,0)** in the `electrodes.tsv` file).  One advantage of this is that you get the *numbering scheme* of the electrodes (row-wise, column-wise, snake-wise, etc) for free, as this could be inferred from electrode names and coordinates in `electrodes.tsv`. This approach would require indicating that a given `electrodes.tsv` file included such relative coordinate values (probably in electrodes.json). If multiple relative-coordinate grids are present, the grouping of which electrodes are in which grid must be specified (probably with an extra column, `grid` or similar) within a single `electrodes.tsv` file (e.g., single file but with two grids at two different locations with two relative landmarks)? (note that this is a separate question from how the data are ultimately "packaged" by the downstream readers, i.e., they may choose to split up the electrode grids each into a separate array).  

A more difficult case is when the data from the grids are natively stored in separate files and *cannot easily be munged into a single data file (probably can be addressed in different acquisitions)*, which raises the question of whether they should *also* have separate corresponding `electrodes.tsv` files. This issue will become very prominent in Example 8, where the grids (or other multi-electrode collections) are of different manufacturers and may have different sampling frequencies, etc, making it near-impossible to munge the data into a single file.    

The sensor is placed with the lower right corner (electrode number 1\) on the bony process of the mandible. One of the edges of the array is parallel to the line from the mandible process to temporal bone process (cheekbone).

Interelectrode distance (IED) is 5 mm. Array configuration is 8 by 8 (TMSi, model XXX). The electrode count started from electrode 1 at the lower right corner going snake-wise vertically. The reference is on Mastoid process. The ground (probably virtual). Target muscles?

The electrode array was attached using double-sided tape and was in contact with the skin via conductive gel.

EMG Signal was recorded at 2000 Hz in a monopolar fashion, 16 bit, with a highpass filter at 10 Hz.

●      **MontageType**: Monopolar  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 64  
●      **TargetMuscle**: Facial muscles in cheek and jaw area  
●      **EMGPlacementScheme**: Grid placed over left cheek and jaw; lower right corner aligned with mandible process.  
●      **InterElectrodeDistance**: 5 mm  
●      **EMGElectrodeCount**: 66  
●      **ElectrodeOrientation**: Not specified (grid covers multiple orientations)  
●      **ElectrodeGroup**: Grid1  
●      **SkinPreparation**: Conductive gel  
●      **ElectrodeType**: High-density grid electrodes  
●      **ElectrodeMaterial**: Silver  
●      **AmplifierType**: Wired  
●      **ReferenceLocation**: Left mastoid process  
●      **ElectrodePlacementMethod**: Anatomical landmarks  
●      **ElectrodesDescription**: 8x8 grid, snake-wise numbering starting from lower right corner

## Example 5 (Two body part high-density Grid on forearm)

![][image5]  
Made in-house at NYU (by Yahya) to reproduce [s41597-021-00843-9](https://doi.org/10.1038/s41597-021-00843-9)

### Key elements to document:

#### *Textual description:*

"EMG was recorded with a high-density grid from both the palmar and the dorsal side of the lower arm." 

Two HD-sEMG electrodes were positioned on the dorsal and the volar aspects of the forearm with the inten- tion to cover, or partially cover, the main fingers flexors and extensors (flexor digitorum profundus - responsible  for flexion of fingers D2-D5, extensor digitorum communis - responsible for extension of fingers D2-D5), wrist  flexor/extensor (flexor carpi radialis, flexor carpi ulnaris - responsible for wrist flexion, extensor carpi radialis  longus, extensor carpi ulnaris - responsible for wrist extension) and pronator/supinator (pronator teres, supina- tor), and thumb flexor/extensor (flexor pollicis longus - responsible for thumb flexion, extensor pollicis longus  - responsible for thumb extension) and thumb abduction (abductor pollicis longus). As the HD-sEMG electrodes  can cover a relatively large area, the positioning of the electrodes was guided by physiological landmarks, such as  distance from the elbow for the distal placement, and distance from the ulna for radial orientation. The electrodes  were placed approximately 3 cm from elbow (elbow to closest electrode corner) and 2 cm from ulna (edge of the  ulna to edge of the electrode).

#### *Proposed machine-readable metadata in a JSON or TSV file*

how many electrodes are placed \= 64 x 2 \+ 1 x 2 reference electrodes at the wrist  
how many channels result from this \= 128 channels 2 grids of 64 \[8x8\]  
is it a mono/bipolar montage \= monopolar  
which muscle \= one array over the digit flexors and one array over the digit extensors  
What orientation \= n/a

### Discussion:

**This is similar to example 5, but consists of two EMG grids** (one not really visible on the other side of the arm).

The iEEG BIDS specification includes a grouping of channels (in grids or strips or shafts), since channels in a group can share noise. That is something we can reuse.

iEEG-BIDS specified the grids in two main locations:  The `ieeg.json` has two fields describing the placement and groups: [**iEEGElectrodeGroups**](https://bids-specification.readthedocs.io/en/stable/glossary.html#objects.metadata.iEEGElectrodeGroups), [**iEEGPlacementScheme**](https://bids-specification.readthedocs.io/en/stable/glossary.html#objects.metadata.iEEGPlacementScheme). The `electrodes.json` has [**group** and](https://bids-specification.readthedocs.io/en/stable/glossary.html#objects.columns.group__channel) [**dimension**](https://bids-specification.readthedocs.io/en/stable/glossary.html#objects.columns.dimension) keywords. The group keyword is a number or string indicating which group of channels (grid/strip/seeg/depth) this electrode belongs to. The dimension keyword indicates size of the group (grid/strip/probe) that this electrode belongs to. Must be of the form `[AxB]` with the smallest dimension first (for example, `[1x8]`).

**PlacementScheme** might be useful to define how and where the electrodes were placed (see the discussions above regarding functional/landmark-based placements). Probably similar to iEEG as a freeform field but with clear recommendations.

●      **MontageType**: Monopolar  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 128 \+ 2 (reference)  
●      **TargetMuscle**: Finger extensors (dorsal), finger flexors (volar)  
●      **EMGPlacementScheme**: Grids placed on dorsal and volar aspects of the forearm, approximately 3 cm from elbow and 2 cm from ulna.  
●      **InterElectrodeDistance**: 8 mm  
●      **ElectrodeOrientation**: Not applicable (grids cover multiple orientations)  
●      **EMGElectrodeCount**: 130  
●      **ElectrodeGroup**: Grid1 (dorsal), Grid2 (volar)  
●      **SkinPreparation**: Abrasive gel  
●      **ElectrodeType**: High-density grid electrodes  
●      **ElectrodeMaterial**: n/a  
●      **AmplifierType**: Wired  
●      **ReferenceLocation**: Reference electrodes at the wrist  
●      **ElectrodePlacementMethod**: Anatomical landmarks  
●      **ElectrodesDescription**: Two 8x8 grids

## Example 6 (commercial bipolar modules)

**![][image6]**  
Deluca 2010, 10.1016/j.jbiomech.2010.01.027

### Key elements to document:

#### *Textual description:*

TBD

#### *Proposed machine-readable metadata in a JSON or TSV file*

how many electrodes are placed \= 2 x 2  
how many channels result from this \= 2 channels  
is it a mono/bipolar montage \= bipolar  
which muscle \= tibialis anterior (TA) and the first dorsal interosseous (FDI  
What orientation \= along the muscle fibers

### Discussion:

**Does this example offer additional technical requirements for the BIDS metadata fields when compared to example 2?** Yes, this is a **wired** bipolar electrode placement with (shared amplifier) with **fixed** inter-electrode distance and **cylindrical electrode shape**.

Electrode shape (and IED) can be documented in `electrodes.tsv`.

System technology (wired/wireless) and amplifier configuration (how many electrodes go into an amplifier and how many channels are being produced, whether the amplifier is on the body) can be described in `emg.json`  
Techn

●      **MontageType**: Bipolar  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 2  
●      **TargetMuscle**: Tibialis anterior (TA), first dorsal interosseous (FDI)  
●      **EMGPlacementScheme**: Electrodes placed over TA and FDI muscles with fixed inter-electrode distance.  
●      **InterElectrodeDistance**: Manufacturer specified  
●      **ElectrodeOrientation**: Parallel to muscle fibers  
●      **EMGElectrodeCount**: 4  
●      **RecordingDirection**: Longitudinal  
●      **EMGGround**: n/a  
●      **ElectrodePlacementMethod**: Anatomical landmarks  
●      **SkinPreparation**: Alcohol wipe  
●      **ElectrodeType**: Cylindrical electrodes  
●      **ElectrodeMaterial**: As specified  
●      **AmplifierType**: Wired  
●      **ModuleManufacturer**: Specify manufacturer  
●      **ModuleModelName**: n/a  
●      **ReferenceLocation**: n/a

**EXAMPLE 7 is REMOVED as it did not provide more information beyond Example 2 and 8\.** 

## Example 8 (multiple recordings, hdsEMG, EMG, motion capture)

![][image7]

### Key elements to document:

#### *Textual description:*

Two 16x5 high-density grids over the vastus medialis and lateralis muscles. A bipolar electrode is placed on Rectus Femoris. High-density grids were placed according the innervation-zone atlas \[Cite\], with the long axis aligned to the muscle fibers. Each high-density grid had a wireless amplifier recording the data at 2k Hz with the reference electrode placed at the ankle.  The bipolar electrode was placed according to SENIAM \[Cite\] and recorded muscle activities at 2.2 kHz. The start of the recording was synchronized by a TTL pulse sent from the bipolar amplifier to the high-density amplifiers.

#### *Proposed machine-readable metadata in a JSON or TSV file*

how many electrodes are placed \= high-density 2 x 64 \[13 5\] and 2 reference electrodes. Bipolar: 4 electrodes  
how many channels result from this \= high-density: 128, bipolar: 1   
is it a mono/bipolar montage \= high-density is monopolar, bipolar is bipolar  
which muscle \= VL, VM, RF  
What orientation \= ???

Discussion:

**Would the recordings of all sensors/systems go in a single data file, or in multiple data files like for motion capture with different "tracking systems" (see below)?**

* If in multiple data files, then each data file has its own metadata sidecar files, and we only have to solve the metadata for each sensor/system separately.  
* Should we consider a case that all EMG recordings are in a single file? If no, what is the limit? Many systems (Delsys, TMSi, OTB) will record EMG files in a single file, irrespective of how many channels there are or if they are bipolar or unipolar, as long as they are from the same manufacturer.

The [BIDS-motion](https://bids-specification.readthedocs.io/en/stable/modality-specific-files/motion.html) standard defines a tracking system as: *"A tracking system is defined as a group of motion channels that share hardware properties (the recording device) and software properties (the recording duration and number of samples). For example, if the position time series of multiple optical markers is processed via one recording unit, this MAY be defined as a single tracking system. Note that it is not uncommon to have multiple tracking systems to record at the same time"* and specifies *"Motion data from one tracking system MUST be stored in a single \*\_motion.tsv file".* 

A separately placed IMU sensor with 3 accelerometers and 3 gyros like the ones in example 6/7 are considered a single tracking system. The motion capture with reflective spheres in example 7 is considered a single tracking system (since one pair of synchronized stereo cameras).

Currently-defined BIDS entity `acq-<label>` might be a good candidate here:

## [acq](https://bids-specification.readthedocs.io/en/stable/appendices/entities.html#acq)

**Full name**: Acquisition

**Format**: `acq-<label>`

**Definition**: The `acq-<label>` entity corresponds to a custom label the user MAY use to distinguish a different set of parameters used for acquiring the same modality.

Example:

sub-001\_task-jumping\_acq-Delsys\_emg.edf (this is for the bipolar recording)

sub-001\_task-jumping\_acq-Delsys\_emg.json

sub-001\_task-jumping\_acq-Delsys\_electrodes.tsv

sub-001\_task-jumping\_acq-Delsys\_channels.tsv

sub-001\_task \-jumping\_acq-OTB\_emg.edf (This for the high-density recording)

(if you want/need to save recordings from separate HD grids in separate files, they can also be categorized as separate `acq`s, e.g. `acq-VL` and `acq-VM`, or `acq-HD1` and `acq-HD2`, etc).

(Note: if recordings from 2 HD grids are stored in the same file, the metadata of EMGElectrodeGroups (similar to iEEG) is needed, but if the 2 HD grids are stored in separate files, the grouping is encoded in the `acq` label).

Metadata Keys:  
●      **MontageType**: Monopolar (HD grids), Bipolar (bipolar electrode)  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: HD grids: 128, Bipolar: 1  
●      **TargetMuscle**: Vastus medialis, vastus lateralis, rectus femoris  
●      **EMGPlacementScheme**: HD grids placed according to innervation-zone atlas; bipolar electrode placed according to SENIAM guidelines.  
●      **InterElectrodeDistance**: HD grids (10 mm), bipolar electrode (20 mm)  
●      **EMGElectrodeCount**: 130 (HD grids), 4 (biopolar electrode)  
●      **ElectrodeOrientation**: Aligned with muscle fibers  
●      **ElectrodeGroup**: Grid1, Grid2, BipolarElectrode  
●      **SkinPreparation**: Abrasive gel  
●      **ElectrodeType**: HD grids (wet), bipolar electrode (dry)  
●      **ElectrodeMaterial**: n/a  
●      **AmplifierType**: Wired to a worn amplifier (HD grids), Wireless (bipolar electrode)  
●      **ReferenceLocation**: Reference electrodes at the ankle (HD grids)  
●      **ElectrodePlacementMethod**: Anatomical landmark

## Example 9: EMG Wristband

![][image8]  
Paper: emg2qwerty: A Large Dataset with Baselines for Touch Typing using Surface Electromyography [https://arxiv.org/pdf/2410.20081](https://arxiv.org/pdf/2410.20081)

Description from paper:   
*Figure 1: Left: An example surface electromyographic (sEMG) recording for the prompt "the quick brown fox" showing 32-channel sEMG signals from left and right wristbands, along with key-press times. Vertical lines indicate keystroke onset. The signal from each electrode channel is high-pass filtered. Right: The sEMG research device (sEMG-RD) used for data collection together with a schematic denoting the electrode placement around the wrist circumference. The left and right wristbands are worn such that one is a mirror of the other, and therefore the positioning of the electrodes around the wrist physiology remains the same, albeit with a reversed electrode polarity with respect to the wrist.*

*All data were recorded using the sEMG research device (sEMG-RD) described in CTRL-labs at Reality Labs et al. (2024) and visualized in Figure 1\. Each sEMG-RD has 16 differential  electrode pairs utilizing dry gold-plated electrodes. Signals are sampled at 2 kHz with a bit depth of 12 bits and a maximum signal amplitude of 6.6 mV. Measurements are bandpass filtered with \-3 dB cutoffs at 20 Hz and 850 Hz before digitization. Data are digitized on the sEMG-RD and*  
*streamed via Bluetooth to the laptop that the subject is simultaneously typing on. Identical devices are worn on the left and right wrists, with the same electrode indices aligning with the same anatomical features, but the polarity of the differential sensing reversed.*

Metadata Keys:  
●      **MontageType**: Bipolar (differential electrode pairs)  
●      **RecordingType**: Continuous  
●      **EMGChannelCount**: 16 x 2 (left and right wrist)  
●      **TargetMuscle**: Forearm muscles around the wrist  
●      **EMGPlacementScheme**: sEMG research device worn on left and right wrists; electrodes placed circumferentially.  
●      **InterElectrodeDistance**: n/a (Device design specific)  
●      **EMGElectrodeCount**: 48 x 2  
●      **ElectrodeOrientation**: Along the muscle fibers (Encircling the wrist)  
●      **ElectrodeGroup**: WristbandLeft, WristbandRight  
●      **SkinPreparation**: n/a (None specified (dry electrodes))  
●      **ElectrodeType**: Dry gold-plated electrodes  
●      **ElectrodeMaterial**: Gold-plated  
●      **AmplifierType**: Wireless via Bluetoothn   
●      **ModuleManufacturer**: CTRL-labs at Reality Labs  
●      **ModuleModelName**: sEMG-RD  
●      **ReferenceLocation**: Polarity reversed on right wrist  
●      **ElectrodePlacementMethod**: Device-specific positioning  
●      **ElectrodesDescription**: See the sample image for sensor location

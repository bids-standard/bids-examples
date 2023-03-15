Overview
--------
This is the "Spot rotation" dataset.
It contains EEG and motion data collected from 20 subjects
collected at the Berlin Mobile Brain-Body Imaging Lab,
while they rotated their heading in physical space or on flat screen using a joystick.
Detailed description of the paradigm can be found in the following reference:

Gramann.K, Hohlefeld, F. U., Gehrke, L., and Klug, M. 
"Human cortical dynamics during full-body heading changes".
Scientific Reports 11, 18186 (2021). 
https://doi.org/10.1038/s41598-021-97749-8



Citing this dataset
-------------------
Please cite as follows:

Gramann, K., Hohlefeld, F.U., Gehrke, L. et al. Human cortical dynamics during full-body heading changes. Sci Rep 11, 18186 (2021). https://doi.org/10.1038/s41598-021-97749-8
For more information, see the `dataset_description.json` file.


License
-------
This motion_spotrotation dataset is made available under the Creative Commons CC0 license. 
Information on CC0 can be found here : https://creativecommons.org/share-your-work/public-domain/cc0/


Format
------
The dataset is formatted according to the Brain Imaging Data Structure. See the
`dataset_description.json` file for the specific version used.

Generally, you can find data in the .tsv files and descriptions in the
accompanying .json files.

An important BIDS definition to consider is the "Inheritance Principle", which
is described in the BIDS specification under the following link:

https://bids-specification.rtfd.io/en/stable/02-common-principles.html#the-inheritance-principle

The section states that:

> Any metadata file (such as .json, .bvec or .tsv) may be defined at any directory level,
> but no more than one applicable file may be defined at a given level [...]
> The values from the top level are inherited by all lower levels unless
> they are overridden by a file at the lower level.


Details about the experiment
----------------------------
For a detailed description of the task, see Gramann et al. (2021).
What follows is a brief summary.

Data were collected from 20 healthy adults (11 females) with a mean age of 30.25 years 
(SD = 7.68, ranging from ages 20 to 46) who received 10€/h or course credit for compensation. 
All participants reported normal or corrected to normal vision and no history of neurological disease. 
Eighteen participants reported being right-handed (two left-handed). 

To control for the effects of different reference frame proclivities on neural dynamics, 
the online version of the spatial reference frame proclivity test (RFPT44, 45) 
was administered prior to the experiment. 
Participants had to consistently use an ego- or allocentric reference frame 
in at least 80% of their responses. 
Of the 20 participants, nine preferentially used an egocentric reference frame, 
nine used an allocentric reference frame, and two used a mixed strategy. 
One participant (egocentric reference frame) dropped out of the experiment 
after the first block due to motion sickness and was removed from further data analyses. 
The reported results are based on the remaining 19 participants. 
The experimental procedures were approved by the local ethics committee 
(Technische Universität Berlin, Germany) 
and the research was performed in accordance with the ethics guidelines. 
The study was conducted in accordance to the Declaration of Helsinki 
and all participants signed a written informed consent. 

Participants performed a spatial orientation task in a sparse virtual environment 
(WorldViz Vizard, Santa Barbara, USA) consisting of an infinite floor granulated in green and black.
The experiment was self-paced and participants advanced the experiment 
by starting and ending each trial with a button press using the index finger of the dominant hand.
A trial started with the onset of a red pole, which participants had to face and align with.
Once the button was pressed the pole disappeared 
and was immediately replaced by a red sphere floating at eye level. 
The sphere automatically started to move around the participant 
along a circular trajectory at a fixed distance (30 m) 
with one of two different velocity profiles. 
Participants were asked to rotate on the spot and to follow the sphere, 
keeping it in the center of their visual field (outward rotation). 
The sphere stopped unpredictably at varying eccentricity between 30° and 150° and turned blue, 
which indicated that participants had to rotate back to the initial heading (backward rotation). 
When participants had reproduced their estimated initial heading, 
they confirmed their heading with a button press and the red pole reappeared for reorientation.

The participants completed the experimental task twice, 
using (i) a traditional desktop 2D setup (visual flow controlled through joystick movement; “joyR”), 
and (ii) equipped with a MoBI setup 
(visual flow controlled through active physical rotation with the whole body; “physR”). 
The condition order was balanced across participants. 
To ensure the comparability of both rotation conditions, 
participants carried the full motion capture system at all times. 
In the joyR condition participants stood in the dimly lit experimental hall in front of a standard TV monitor 
(1.5 m viewing distance, HD resolution, 60 Hz refresh rate, 40″ diagonal size) 
and were instructed to move as little as possible. 
They followed the sphere by tilting the joystick 
and were thus only able to use visual flow information to complete the task. 
In the physical rotation condition participants were situated in a 3D virtual reality environment 
using a head mounted display (HTC Vive; 2 × 1080 × 1200 resolution, 90 Hz refresh rate, 110° field of view). 
Participants’ movements were unconstrained, 
i.e., in order to follow the sphere they physically rotated on the spot, 
thus enabling them to use motor and kinesthetic information (i.e., vestibular input and proprioception) 
in addition to the visual flow for completing the task. 
If participants diverged from the center position as determined through motion capture of the head position, 
the task automatically halted and participants were asked to regain center position, 
indicated by a yellow floating sphere, before continuing with the task. 
Each movement condition was preceded by recording a three-minute baseline, 
during which the participants were instructed to stand still and to look straight ahead.

Data Recordings: EEG. 
EEG data was recorded from 157 active electrodes with a sampling rate of 1000 Hz 
and band-pass filtered from 0.016 Hz to 500 Hz (BrainAmp Move System, Brain Products, Gilching, Germany). 
Using an elastic cap with an equidistant design (EASYCAP, Herrsching, Germany), 
129 electrodes were placed on the scalp, and 28 electrodes were placed around the neck 
using a custom neckband (EASYCAP, Herrsching, Germany) in order to record neck muscle activity. 
Data were referenced to an electrode located closest to the standard position FCz. 
Impedances were kept below 10kΩ for standard locations on the scalp, and below 50kΩ for the neckband. 
Electrode locations were digitized using an optical tracking system (Polaris Vicra, NDI, Waterloo, ON, Canada).

Data Recordings: Motion Capture. 
Two different motion capture data sources were used: 19 red active light-emitting diodes (LEDs) were captured 
using 31 cameras of the Impulse X2 System (PhaseSpace Inc., San Leandro, CA, USA) with a sampling rate of 90 Hz. 
They were placed on the feet (2 x 4 LEDs), around the hips (5 LEDs), on the shoulders (4 LEDs), 
and on the HTC Vive (2 LEDs; to account for an offset in yaw angle between the PhaseSpace and the HTC Vive tracking). 
Except for the two LEDs on the HTC Vive, they were subsequently grouped together 
to form rigid body parts of feet, hip, and shoulders, enabling tracking with 
six degrees of freedom (x, y, and z position and roll, yaw, and pitch orientation) per body part. 
Head motion capture data (position and orientation) was acquired using the HTC Lighthouse tracking system 
with 90Hz sampling rate, since it was also used for the positional tracking of the virtual reality view. 

The original data was recorded in `.xdf` format using labstreaminglayer
(https://github.com/sccn/labstreaminglayer). It is stored in the `/sourcedata`
directory. To comply with the BIDS format, the .xdf format was converted to
BrainVision format (see the `.eeg` file for binary eeg data, the `.vhdr` as a
text header filer containing meta data, and the `.vmrk` as a text file storing
the eeg markers).



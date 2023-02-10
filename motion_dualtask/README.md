Overview
--------
This is the "Dual Task" dataset.
It contains EEG and motion data collected old and young participants
performing a cognitive task while walking or standing still.
Data was collected at the Berlin Mobile Brain-Body Imaging Lab.
This Study was realized by funding from the Federal Ministry of Education and Research (BMBF).

The data set was presented in MoBI workshop 2021 and 2022.

Authors: Protzak, Janna and Gramann, Klaus


License
-------
This dataset is made available under the Creative Commons CC0 license. 
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

These sets contain data from a 2x2 mixed-design study with the within-factor age group 
(< 35 years, > 60 years) and the between-factor motor task (standing and walking).

A visual discrimination task was used, requiring participants to respond to 
blue and yellow visual target LED stimuli. 
All targets were presented randomly in two different angels 
(40 degree or 60 degree from the sagittal midline of the participant's head) 
with a duration of 50ms in either the left or the right peripheral visual field. 

Responses were executed via left and right index finger button presses 
on Bluetooth gaming controllers congruent to the stimulus presentation site. 
Participants were asked to respond to either the blue or yellow light 
with a single button press and to the other color with a double button press.

During the walking condition, participants were asked to walk up and down 
a distance of 10m between two parallel horizontal LED line arrays 
with dynamic head position and target eccentricity estimation. 

During the standing condition, they were positioned in the middle of both LED arrays.







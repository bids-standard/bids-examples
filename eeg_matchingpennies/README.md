# Overview

This is the "Matching Pennies" dataset.
It was collected as part of a small scale replication project targeting the following reference:

> Matthias Schultze-Kraft et al.
> "Predicting Motor Intentions with Closed-Loop Brain-Computer Interfaces".
> In: Springer Briefs in Electrical and Computer Engineering.
> Springer International Publishing, 2017, pp. 79–90.

In brief, it contains EEG data for 7 subjects raising either their left or right hand,
thus giving rise to a lateralized readiness potential as measured with the EEG.
For details, see the `Details about the experiment` section.

# Citing this dataset

Please cite as follows:

> Appelhoff, S., Sauer, D. & Gill, S. S. Matching Pennies: A Brain Computer Interface Implementation Dataset. Open Science Framework, https://doi.org/10.17605/OSF.IO/CJ2DR (2018).

For more information, see the `dataset_description.json` file.

# License

The `eeg_matchingpennies` dataset is made available under the Public Domain Dedication and License (PDDL).

Copyright (c) 2018-2023, Stefan Appelhoff, Daryl Sauer, and Suleman Samuel Gill

See the `LICENSE` file.
A human readable information can be found at:

https://opendatacommons.org/licenses/pddl/1-0/

# Format

The dataset is formatted according to the Brain Imaging Data Structure (BIDS).
See the `dataset_description.json` file for the specific version used.

Generally, you can find metadata in the `.tsv` files and documentation thereof in the accompanying `.json` files.
For example `participants.tsv` contains metadata about the participants,
and `participants.json` contains documentation about the columns in `participants.tsv`

An important BIDS definition to consider is the "Inheritance Principle", which
is described in the BIDS specification under the following link:

https://bids-specification.readthedocs.io/en/latest/common-principles.html#the-inheritance-principle

In brief, the Inheritance Pinciple states that any metadata file (such as `.json`, `.tsv`)
may be defined at any directory level, but no more than one applicable file may be defined at a given level [...],
and the values from the top level are inherited by all lower levels --
unless they are overridden by a file at the lower level.

# Details about the experiment

For a detailed description of the task, see Schultze-Kraft et al. (2017)
and the supplied `task-matchingpennies_eeg.json` file.
What follows is a brief summary.

Participants were seated in front of a computer screen placed on a desk.
In front of the participants, two computer mice were glued to the desk:
One to the right of the current participant, the other one to their left.
On each trial in the experiment, participants were instructed to rest
their hands on the desk in front of them, using their left and
right ring-fingers to press a button on the computer mouse on their
left and right side respectively.
Pressing both mice buttons triggered a 3 second countdown that was
visually represented as a shrinking horizontal bar on the computer screen.
Participants were instructed to lift one (and only one!) hand, thereby
releasing a button of a computer mouse, at exactly the time when the
countdown reached 0 seconds.
After a short delay (see below), a feedback stimulus in the form of a
left or right hand was shown on the respective side of the computer screen.
When the hand shown on the computer screen and the hand raised by
the participant matched, this was counted as a "win" for the computer,
else it was counted as a "win" for the participant.
Participants were instructed to win as many trials against the computer
as possible.

Throughout the experiment, EEG data was recorded and analyzed in a closed-loop
BCI online setup. The computer made use of this data to predict which
hand a given study participant was about to raise, in order to win more trials.

For more information, you can also consult the events.tsv and events.json files.

Due to an inherent latency of the system, the data used in
the online analysis does not necessarily coincide with the offline data marked
through EEG triggers. Therefore, after each trial-wise online analysis, the
used data was saved separately as an "online chunk". Based on the online chunks
of data, it was possible to calculate a latency of each trial with respect to
the time difference between when an event happened at the electrode level and
when it arrived in digitized format at the classification function. These
latencies were calculated by sliding the online chunk of data across the data
recording until a perfect match was found. The index of this perfect match is
then compared to the timepoint of the event trigger and that difference
constitutes the latency. The values are included in the events.tsv files for
each subject.

The original data was recorded in `.xdf` format using labstreaminglayer
(https://github.com/sccn/labstreaminglayer). It is stored in the `/sourcedata`
directory. To comply with the BIDS format, the .xdf format was converted to
BrainVision format (see the `.eeg` file for binary eeg data, the `.vhdr` as a
text header filer containing meta data, and the `.vmrk` as a text file storing
the eeg markers).

Note that in the experiment, the only EEG TTL triggers that were recorded are
related to the participant raising their left (=value 1) or right (=value 2) hand,
and the button release associated with this movement.
The onset of the feedback stimulus (drawing of left or right hand shown on the screen)
was not recorded, however it can be crudely estimated to be around 50ms + ~10ms + ~8ms,
where 50ms were a hardcoded break before getting the online data from LSL, ~10ms was
the time to get a prediction from the BCI classifier, but this varied around 10ms,
and finally the ~8ms at the end come from the uncertainty of the refresh rate of the
screen (60fps = 1 screen every 16.66666ms)

Subjects 1 to 4 participated in the pilot testing only. Their data are not
included in this dataset.

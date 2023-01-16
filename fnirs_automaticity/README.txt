Overview
--------
This is an example and test version of the dataset that is scheduled to be published on https://doi.org/10.34973/vesb-mh30. As this example is shared prior to completion of the publication, the DOI may or may not yet work.

Cockx, H.M. (Helena), Robert Oostenveld, Tabor, M. (Merel), Savenco, E. (Ecaterina), Setten, A. van (Arne), Cameron, I.G.M. (Ian), Wezel, R.J.A. van (Richard) (2022).
Automatic and non-automatic finger and leg movements measured with functional near-infrared spectroscopy (fNIRS) [Data set].

Experiment description
----------------------
This dataset includes the data of 24 participants performing automatic and non-automatic finger tapping and foot stepping movements in a block design.

For the finger tapping tasks, participants needed to tap their right-hand fingers in the order of a 12-digit sequence on a numeric key pad, with 1, 2, 3, and 4 representing the index, middle, ring, and little finger respectively. For the foot stepping tasks, participants needed to step with their right foot on four floor pads in the order of a 12-digit sequence, with 1, 2, 3, and 4 representing a step in the middle, to the front, to the back, and to the side, respectively. Two different sequences of similar difficulty were learned (A:434141243212 and B:212321324241). One of the two was practiced 7 days before the experiment for 5 minutes a day each limb (considered the automatic sequences). The other sequence was only practiced for 5 minutes on the day of the experiment (considered the non-automatic sequence). Participants were pseudo-randomly assigned to start learning either sequence A or B in advance. Participants performed all four task under two conditions: either with or without a dual-task. The dual-task entailed performing the sequence while simultaneously counting the letter 'G' from a list of randomly appearing letters on the screen.

fNIRS data was sampled with a multichannel fNIRS device (24 long and 12 short separation channels) over the left primary motor cortex, the left premotor cortex, the left and right dorsolateral prefrontal cortex, and the left and right posterior parietal cortex.

Note for events.json
--------------------
During the dual-task conditions a random sequence of 8 letters (C, G, Q, or O) is shown (e.g. QGCQOGCG). The exact sequence of displayed letters is coded as 'shown_stimulus' in the events.tsv files.
However, the number of potential letter combinations was too high to report them all in the events.json file. We therefore only reported one example of a letter string as level for the 'shown_stimulus' column (QGCQOGCG).

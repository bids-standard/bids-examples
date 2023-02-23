# Datasets with and without deliberate head movements 

Used to evaluate the performance of markerless 
prospective motion correction and selective reacquisition 
in a general clinical protocol for brain MRI

Head motion is one of the most common sources of artefacts in brain MRI. In this
study, we evaluate the performance of markerless prospective motion correction
(PMC) and selective reacquisition in a complete clinical protocol for brain MRI,
comparing acquisitions with and without instructed intentional head motion.

MRI and head motion data were acquired between January and March 2021 from 22
healthy adults (16 females, 6 males) aged 19-36 (mean ± standard deviation: 23.5
± 4.3) years, recruited for the Cimbi database (www.cimbi.dk). The recruitment
was performed by advertisement for different research projects, with approval by
the Ethics Committee of Copenhagen and Frederiksberg, Denmark (protocol number
H-KF-2006-20). Written informed consent was obtained from each participant.

The MRI scan protocol consisted of six different 2D- and 3D-encoded sequences,
which were completed by a different number of participants: 3D T1 MPR (n=22), 3D
T2 dark fluid (FLAIR) (n=10), 2D T1 STIR (n=22), 2D T2 TSE (n=22), 2D T2\* GRE
(n=19) and 2D DWI (n=10). Note, currently the DWI are not shared yet, but they
will be shared asap. Four scans were acquired for each sequence: two without
intentional head motion (referred to as ‘still’) and two with a predefined
nodding motion (‘nod’). For the T1 MPR sequence, two additional scans with
shaking motion were acquired (‘shake’). The participants were instructed to
perform two periods of nodding or shaking motion for 40 seconds during the
middle of the acquisition, corresponding to the acquisition of the k-space
center for the 3D-encoded sequences.

The scans with and without PMC were acquired in the following order:

- Still, no correction
- Still, PMC
- Nod motion, no correction (+ selective reacquisition)
- Nod motion, PMC (+ selective reacquisition)
- Shake motion, no correction (+ selective reacquisition) - ONLY MPRAGE
- Shake motion, PMC (+ selective reacquisition) - ONLY MPRAGE

Note that:
- run-01 indicates the still scans, 
- run-02 indicates the nodding scans 
- run-03 indicates the shaking scans.

Nodding motion was chosen as the primary motion pattern based on results of a
[previous study](https://www.frontiersin.org/articles/10.3389/fradi.2021.789632/full) , where
nodding rotation was found to be significantly larger than the rotational
components around the other axes for awake children. Rigid-body head motion was
measured with the optical tracking system Tracoline (TracInnovations, Ballerup,
Denmark).

More details regarding the acquisition protocol can be seen in our preprint
https://psyarxiv.com/vzh4g.

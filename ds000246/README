# Brainstorm - Auditory Dataset

## License

This dataset (MEG and MRI data) was collected by the MEG Unit Lab, McConnell Brain Imaging Center, Montreal Neurological Institute, McGill University, Canada. The original purpose was to serve as a tutorial data example for the Brainstorm software project (http://neuroimage.usc.edu/brainstorm). It is presently released in the Public Domain, and is not subject to copyright in any jurisdiction.

We would appreciate though that you reference this dataset in your publications: please acknowledge its authors (Elizabeth Bock, Peter Donhauser, Francois Tadel and Sylvain Baillet) and cite the Brainstorm project seminal publication (also in open access): 
http://www.hindawi.com/journals/cin/2011/879716/
 


## Presentation of the experiment

#### Experiment

* One subject, two acquisition runs of 6 minutes each
* Subject stimulated binaurally with intra-aural earphones (air tubes+transducers)
* Each run contains:
    * 200 regular beeps (440Hz)
    * 40 easy deviant beeps (554.4Hz, 4 semitones higher)
* Random inter-stimulus interval: between 0.7s and 1.7s seconds, uniformly distributed
* The subject presses a button when detecting a deviant with the right index finger
* Auditory stimuli generated with the Matlab Psychophysics toolbox
* The specifications of this dataset were discussed initially on [the FieldTrip bug tracker][2]

#### MEG acquisition

* Acquisition at **2400Hz**, with a **CTF 275** system, subject in seating position
* Recorded at the Montreal Neurological Institute in December 2013
* Anti-aliasing low-pass filter at 600Hz, files saved with the 3rd order gradient
* Recorded channels (340):
    * 1 Stim channel indicating the presentation times of the audio stimuli: UPPT001 (#1)
    * 1 Audio signal sent to the subject: UADC001 (#316)
    * 1 Response channel recordings the finger taps in response to the deviants: UDIO001 (#2)
    * 26 MEG reference sensors (#5-#30)
    * 274 MEG axial gradiometers (#31-#304)
    * 2 EEG electrodes: Cz, Pz (#305 and #306)
    * 1 ECG bipolar (#307)
    * 2 EOG bipolar (vertical #308, horizontal #309)
    * 12 Head tracking channels: Nasion XYZ, Left XYZ, Right XYZ, Error N/L/R (#317-#328)
    * 20 Unused channels (#3, #4, #310-#315, #329-340)
* 3 datasets:
    * **S01_AEF_20131218_01.ds**: Run #1, 360s, 200 standard + 40 deviants

    * **S01_AEF_20131218_02.ds**: Run #2, 360s, 200 standard + 40 deviants

    * **S01_Noise_20131218_01.ds**: Empty room recordings, 30s long

    * File name: S01=Subject01, AEF=Auditory evoked field, 20131218=date(Dec 18 2013), 01=run
* Use of the .ds, not the AUX (standard at the MNI) because they are easier to manipulate in FieldTrip

#### Stimulation delays

* **Delay #1**: Production of the sound.   
Between the stim markers (channel UDIO001) and the moment where the sound card plays the sound (channel UADC001). This is mostly due to the software running on the computer (stimulation software, operating system, sound card drivers, sound card electronics). The delay can be measured from the recorded files by comparing the triggers in the two channels: Delay **between 11.5ms and 12.8ms** (std = 0.3ms) This delay is **not constant**, we will need to correct for it.
* **Delay #2**: Transmission of the sound.   
Between when the sound card plays the sound and when the subject receives the sound in the ears. This is the time it takes for the transducer to convert the analog audio signal into a sound, plus the time it takes to the sound to travel through the air tubes from the transducer to the subject's ears. This delay cannot be estimated from the recorded signals: before the acquisition, we placed a sound meter at the extremity of the tubes to record when the sound is delivered. Delay **between 4.8ms and 5.0ms** (std = 0.08ms). At a sampling rate of 2400Hz, this delay can be considered **constant**, we will not compensate for it.
* **Delay #3**: Recording of the signals.   
The CTF MEG systems have a constant delay of **4 samples** between the MEG/EEG channels and the analog channels (such as the audio signal UADC001), because of an anti-aliasing filtered that is applied to the first and not the second. This translate here to a **constant delay** of **1.7ms**.
* **Delay #4**: Over-compensation of delay #1.   
When correcting of delay #1, the process we use to detect the beginning of the triggers on the audio signal (UADC001) sets the trigger in the middle of the ramp between silence and the beep. We "over-compensate" the delay #1 by 1.7ms. This can be considered as **constant delay** of about **-1.7ms**.
* **Uncorrected delays**: We will correct for the delay #1, and keep the other delays (#2, #3 and #4). After we compensate for delay #1 our MEG signals will have a **constant delay** of about 4.9 + 1.7 - 1.7 = **4.9 ms**. We decide not to compensate for th3se delays because they do not introduce any jitter in the responses and they are not going to change anything in the interpretation of the data.

#### Head shape and fiducial points

* 3D digitization using a Polhemus Fastrak device driven by Brainstorm (S01_20131218_*.pos)
* More information: [Digitize EEG electrodes and head shape][3]
* The output file is copied to each .ds folder and contains the following entries:
    * The position of the center of CTF coils
    * The position of the anatomical references we use in Brainstorm: Nasion and connections tragus/helix, as illustrated [here][4].

* Around 150 head points distributed on the hard parts of the head (no soft tissues)

#### Subject anatomy
* Subject with 1.5T MRI
* Marker on the left cheek
* Processed with FreeSurfer 5.3


[1]: http://neuroimage.usc.edu/brainstorm/CiteBrainstorm
[2]: http://bugzilla.fcdonders.nl/show_bug.cgi?id=2300
[3]: http://neuroimage.usc.edu/brainstorm/Tutorials/TutDigitize
[4]: http://neuroimage.usc.edu/brainstorm/CoordinateSystems#Pre-auricular_points_.28LPA.2C_RPA.29
[5]: http://neuroimage.usc.edu/brainstorm/Tutorials/Auditory

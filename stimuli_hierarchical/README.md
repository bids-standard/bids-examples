# BEP044 hierarchical stimuli example

A /stimuli directory organized in subdirectories, with a dataset-wide catalog
at the /stimuli root and scoped catalogs in the subdirectories that amend it
following the Inheritance Principle (BEP044, Stim-BIDS).

## Layout

```Text
stimuli/
    stimuli.tsv, stimuli.json      dataset-wide catalog listing every stimulus
    annotations.tsv, annotations.json
                                   dataset-wide list of annotation sets
    faces/                         two face images with a scoped catalog
    sounds/                        one tone with a time-varying annotation
    nsd/                           three NSD images, catalog and HED only
```

## What each part demonstrates

- stimuli/stimuli.tsv lists all six stimuli with the recommended type,
  license, copyright and description columns, the optional URL column, and
  the present column. The three NSD images are not redistributed
  (present: false); their URL, license and copyright are given in the catalog
  instead of in a per-file sidecar.
- stimuli/faces/stimuli.tsv is a scoped catalog: it overrides the description
  of stim-face01 and stim-face02 and adds an emotion column that is defined in
  stimuli/faces/stimuli.json. The image files and their sidecars live in the
  same directory.
- stimuli/sounds/ holds an audio stimulus with its media metadata sidecar and
  a time-varying annotation, stim-tone01_annot-pitch_events.tsv. The
  annotation set is listed in stimuli/annotations.tsv.
- stimuli/nsd/ is a portable stimulus pack: a scoped catalog with a
  hand-written description, a HED annotation of the image content and the
  NSD_id column, but no image files. The pack can be copied between datasets
  as one unit.
- Two behavioral tasks reference the stimuli through stim_id:
  task-view (faces and tone) and task-images (NSD images).

## HED annotations

This dataset is the HED showcase of the three BEP044 examples. HED 8.4.0 is
declared in dataset_description.json and the validator checks every HED
string, including those under /stimuli. HED appears in four places, each
showing a different mechanism:

- stimuli/nsd/stimuli.tsv, HED column: a HED string per stimulus describing
  the image content (what is in the picture). This is the catalog-column
  form. HED is a predefined BIDS column, so it has no entry in
  stimuli/nsd/stimuli.json; the sidecar describes only the dataset-specific
  columns (here NSD_id).
- stimuli/faces/stimuli.json, emotion column: a HED dictionary that maps the
  categorical values neutral and happy of the scoped faces catalog to HED
  ((Image, Face) and (Image, (Face, Happy)); HED has no neutral emotion tag).
  This is the sidecar-dictionary form, and it lives in a subdirectory, so it
  is picked up through inheritance.
- stimuli/sounds/stim-tone01_annot-pitch_events.json, pitch_hz column: a HED
  string with a # placeholder that takes the numeric value of the column
  ((Sensory-event, Auditory-presentation, Tone, Pitch/# Hz)). This is the time-varying annotation form.
- task-view_events.json and task-images_events.json, trial_type column: HED
  for the events themselves (Sensory-event, Experimental-stimulus, and the
  presentation modality). The events describe that a stimulus was shown; the
  catalog describes what the stimulus contained. BIDS does not yet define how
  tools join the two through stim_id, so no HED is attached to stim_id.

Images are 1x1 pixel PNGs and the WAV holds 10 ms of silence; they are valid
files so that tools can read their headers.

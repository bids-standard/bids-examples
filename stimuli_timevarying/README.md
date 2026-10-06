# BEP044 time-varying stimuli example

Time-varying stimuli (films) referenced from an EEG recording, with several
annotation tables per stimulus, a stimulus split into parts, and a stimulus
whose file is not redistributed (BEP044, Stim-BIDS).

## Layout

```Text
stimuli/
    stimuli.tsv, stimuli.json          catalog of the two films
    annotations.tsv, annotations.json  the three annotation sets
    stim-thepresent_annot-action_events.tsv/json
    stim-thepresent_annot-auditory_events.tsv/json
    stim-thepresent_annot-LogLumRatio_events.tsv/json
    stim-bbb_part-1_audiovideo.mp4/json
    stim-bbb_part-2_audiovideo.mp4/json
sub-01/eeg/                            EEG recorded while watching The Present
```

## What this dataset demonstrates

- stim-thepresent is the animated short film The Present (Jacob Frey, 2014).
  The film is copyrighted and not redistributed, so stimuli/stimuli.tsv marks
  it present: false and carries its URL, license and copyright. Its three
  annotation tables are distributed.
- Three annotation sets for one stimulus, each a
  stim-<label>_annot-<label>_events.tsv file with the structure of an
  events.tsv file and a JSON sidecar with HED annotations: action (what the
  characters do), auditory (speech and sounds) and LogLumRatio (shot
  boundaries with a computed luminance feature). Each table is cut to ten
  rows; the complete annotations are not part of this example.
- stimuli/annotations.tsv lists the annotation sets by annot_id.
- stim-bbb is Big Buck Bunny (Blender Foundation, 2008, CC-BY-3.0), used to
  show the part-<label> entity: the film is split into two files,
  stim-bbb_part-1_audiovideo.mp4 and stim-bbb_part-2_audiovideo.mp4, each
  with a sidecar carrying the video and audio stream metadata (VideoCodec,
  VideoFrameRate, ImageWidth, AudioSampleRate, ...). The partDescription
  column of stimuli.tsv says how the split was made. As everywhere in
  bids-examples the media files are empty placeholders.
- sub-01/eeg/sub-01_task-ThePresent_events.tsv references the film through
  the stim_id column; the EEG file is an empty placeholder.

The annotation rows for The Present are excerpts from the annotations
created at the Swartz Center for Computational Neuroscience for the
Healthy Brain Network EEG recordings of the film. HED strings are validated
against HED 8.4.0 (HEDVersion in dataset_description.json): the three
annotation sidecars under stimuli/ annotate the film content, and
task-ThePresent_events.json annotates the recording events (fixation, movie).

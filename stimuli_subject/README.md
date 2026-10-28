# BEP044 subject-specific stimuli example

Stimuli that differ across participants or presentations are stored in the
participant's directories, next to the data they align with, and named with
the stim-<label> entity (BEP044, Stim-BIDS).

## What this dataset demonstrates

- A dyadic task: in sub-01/beh and sub-02/beh,
  sub-<label>_task-dyad_stim-partner_audio.wav holds the partner's speech as
  played to that participant. The stimulus has no counterpart in /stimuli and
  is not listed in stimuli/stimuli.tsv, which is OPTIONAL for subject-specific
  stimuli.
- A screen capture: sub-01/beh/sub-01_task-watch_stim-clip01_video.mp4 records
  how stim-clip01 was displayed to sub-01. Its sidecar lists the presented
  file in /stimuli in the Sources field, using a BIDS URI, and describes the
  captured video stream, which differs from the original file.
- The stim entity follows task in the file name, and the media sidecars carry
  TaskName and the media stream metadata.
- The events files reference both kinds of stimuli through the stim_id column.
- stimuli/stimuli.tsv lists the shared stimulus with the required
  stimulus_id, type, license and present columns.

The WAV files hold 10 ms of silence and the MP4 files are empty placeholders;
the durations in the events files describe the original recordings.

See stimuli_basic for a minimal /stimuli catalog and stimuli_timevarying for
time-varying stimuli with annotation tables.

# BEP044 basic stimuli example

The smallest dataset that uses the BEP044 (Stim-BIDS) organization of the
/stimuli directory: a flat /stimuli directory with a stimulus catalog and two
stimulus files, referenced from a behavioral events file.

## What this dataset demonstrates

- stimuli/stimuli.tsv and stimuli/stimuli.json: the dataset-wide stimulus
  catalog with the required stimulus_id column, the recommended type column,
  and the optional filename column.
- stim-<label>_<suffix>.<extension> naming for stimulus files: an image
  (stim-face01_image.png) and an audio file (stim-tone01_audio.wav).
- One JSON sidecar per stimulus file carrying the media metadata (ImageWidth,
  AudioSampleRate, ...) and the License, Copyright and Description fields.
- sub-01/beh/sub-01_task-view_events.tsv references stimuli through the
  stim_id column. The legacy stim_file column is kept in the same file to show
  that both ways of pointing at a stimulus can coexist; the two columns point
  at the same files.
- task-view_events.json describes the stim_id and stim_file columns.

The PNG is a 1x1 pixel image and the WAV holds 10 ms of silence; both are
valid files so that tools can read their headers.

See the other two BEP044 examples for subdirectories and scoped catalogs
(stimuli_hierarchical) and for time-varying stimuli with annotation tables
(stimuli_timevarying).

import pandas as pd
import mne

events_fname = "/Users/alex/mne_data/MNE-sample-data/MEG/sample/sample_audvis_raw-eve.fif"
raw_fname = "sub-01_task-audiovisual_run-01_meg.fif"

events = mne.read_events(events_fname).astype(int)
raw = mne.io.read_raw_fif(raw_fname)

event_id = {'Auditory/Left': 1, 'Auditory/Right': 2, 'Visual/Left': 3,
            'Visual/Right': 4, 'Smiley': 5, 'Button': 32}
events[:, 0] -= raw.first_samp

event_id_map = {v: k for k, v in event_id.items()}

df = pd.DataFrame(events[:, [0, 2]], columns=['Sample', 'Condition'])
df.Condition = df.Condition.map(event_id_map)

print(df.head())

df.to_csv('sub-01_task-audiovisual_run-01_events.tsv', sep='\t', index=False)

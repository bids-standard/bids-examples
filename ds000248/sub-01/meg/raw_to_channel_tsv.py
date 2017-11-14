import pandas as pd

import mne
from mne.io.pick import channel_type

raw_fname = "sub-01_task-audiovisual_run-01_meg.fif"

raw = mne.io.read_raw_fif(raw_fname)

map_chs = dict(grad='MEG', mag='MEG', stim='TRIG', eeg='EEG',
               eog='EOG', misc='MISC')
map_desc = dict(grad='sensor gradiometer', mag='magnetometer',
                stim='analogue trigger', eeg='electro-encephalography channel',
                eog='electro-oculogram', misc='miscellaneous channel')

status, ch_type, description = list(), list(), list()
for idx, ch in enumerate(raw.info['ch_names']):
    status.append('bad' if ch in raw.info['bads'] else 'good')
    ch_type.append(map_chs[channel_type(raw.info, idx)])
    description.append(map_desc[channel_type(raw.info, idx)])

onlinefilter = '%0.2f-%0.2f' % (raw.info['highpass'], raw.info['lowpass'])
df = pd.DataFrame({'name': raw.info['ch_names'], 'type': ch_type,
                   'description': description,
                   'onlinefilter': onlinefilter,
                   'samplingrate': '%f' % raw.info['sfreq'], 'status': status
                   })

print(df.head())

df.to_csv('sub-01_task-audiovisual_run-01_channel.tsv', sep='\t', index=False)

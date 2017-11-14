import pandas as pd
from datetime import datetime
import mne

raw_fname = "sub-01_task-audiovisual_run-01_meg.fif"

raw = mne.io.read_raw_fif(raw_fname)

acq_time = datetime.fromtimestamp(raw.info['meas_date'][0]
                                  ).strftime('%Y-%m-%dT%H:%M:%S')

df = pd.DataFrame({'filename': ['meg/%s' % raw_fname],
                   'acq_time': [acq_time]})

print(df.head())

df.to_csv('sub-01_scans.tsv', sep='\t', index=False)

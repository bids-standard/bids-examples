"""Utility script to remove subjects from the phenotype dataset.

Helps to generate them from openneuro datasets.
"""

from pathlib import Path
import pandas as pd
import shutil

root_dir = Path(__file__).parent
source_ds = root_dir / 'ds004215'
agg_ds = root_dir / 'ds004130'
seg_ds = root_dir / 'ds004129'

# list of subjects to keep
subjects_to_keep = [x.name for x in source_ds.glob('sub-*')]
subjects_to_keep = subjects_to_keep[:3]
if "sub-ON01016" not in subjects_to_keep:
    subjects_to_keep.append('sub-ON01016')

# remove subjects from datasets
for ds in [source_ds, agg_ds, seg_ds]:
    list_subjects = [x.name for x in ds.glob('sub-*')]
    for subject in list_subjects:
        subject_dir = ds / subject
        if subject not in subjects_to_keep and subject_dir.exists():
            print(f'Removing {subject_dir}')
            shutil.rmtree(subject_dir)

# remove subject from participants.tsv
for ds in [source_ds, agg_ds, seg_ds]:
    participants_tsv = ds / 'participants.tsv'
    participants_df = pd.read_csv(participants_tsv, sep='\t')   
    participants_df = participants_df[participants_df['participant_id'].isin(subjects_to_keep)]
    print(participants_df)
    participants_df.to_csv(participants_tsv, sep='\t', index=False)

# remove subject from all tsv in phenotype folder
for ds in [source_ds, agg_ds, seg_ds]:
    phenotype_dir = ds / 'phenotype'
    for tsv in phenotype_dir.glob('*.tsv'):
        tsv_df = pd.read_csv(tsv, sep='\t')
        tsv_df = tsv_df[tsv_df['participant_id'].isin(subjects_to_keep)]
        tsv_df.to_csv(tsv, sep='\t', index=False)
        # if tsv is empty, remove it
        if tsv_df.shape[0] == 0:
            print(f'Removing {tsv}')
            tsv.unlink()

# remove sourcedata from each ds
for ds in [source_ds, agg_ds, seg_ds]:
    sourcedata_dir = ds / 'sourcedata'
    if sourcedata_dir.exists():
        print(f'Removing {sourcedata_dir}')
        shutil.rmtree(sourcedata_dir)

# remove .git and .datalad from each ds
for ds in [source_ds, agg_ds, seg_ds]:
    git_dir = ds / '.git'
    if git_dir.exists():
        print(f'Removing {git_dir}')
        shutil.rmtree(git_dir)
    datalad_dir = ds / '.datalad'
    if datalad_dir.exists():
        print(f'Removing {datalad_dir}')
        shutil.rmtree(datalad_dir)

# delete each .nii.gz file in each ds and touch a file with its name instead:
for ds in [source_ds, agg_ds, seg_ds]:
    for nii in ds.glob('**/*.nii.gz'):
        print(f'Removing {nii}')
        nii.unlink()
        nii.touch()
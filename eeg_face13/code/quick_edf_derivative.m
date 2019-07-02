fnames = {'derivatives/lossless/sub-s01/eeg/sub-s01_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s02/eeg/sub-s02_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s03/eeg/sub-s03_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s04/eeg/sub-s04_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s05/eeg/sub-s05_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s06/eeg/sub-s06_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s07/eeg/sub-s07_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s08/eeg/sub-s08_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s09/eeg/sub-s09_task-faceO_eeg_qcr.set',
'derivatives/lossless/sub-s10/eeg/sub-s10_task-faceO_eeg_qcr.set'};

for f=1:length(fnames)
    EEG.etc.eeglabvers = 'development head'; % this tracks which version of EEGLAB is being used, you may ignore it
    EEG = eeg_checkset( EEG );
    EEG = pop_loadset('filename',fnames{f},'filepath','');
    EEG = eeg_checkset( EEG );
    pop_writeeeg(EEG, strrep(fnames{f},'.set','.edf'), 'TYPE','EDF');
end
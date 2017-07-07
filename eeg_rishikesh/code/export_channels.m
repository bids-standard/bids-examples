EEG = pop_biosig('sub-Expert01/ses-01/eeg/sub-Expert01_ses-01_task-medprobe_eeg.bdf');

fid = fopen('channel2.tsv','w');
fprintf(fid,'chan_id\ttype\n');
for iChan = 1:length(EEG.chanlocs)
    fprintf(fid,'%s\t%s\n', EEG.chanlocs(iChan).labels, 'EEG');
end
fclose(fid);

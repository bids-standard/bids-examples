scalp_ud=get(findobj('Tag','ve_eeg'),'UserData');

comp_ud=get(findobj('Tag','ve_ica'),'UserData');
comp_keep=~comp_ud.chan_marks_struct(1).flags;

comp_proj=EEG.data;
comp_proj(EEG.icachansind,:) = EEG.icawinv(:, find(comp_keep))*eeg_getdatact(EEG, 'component', find(comp_keep));

scalp_ud.data2=comp_proj;

set(findobj('Tag','ve_eeg'),'UserData',scalp_ud)

ve_eegplot('drawp',0);
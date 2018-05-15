%% CHECK FOR OUTPUT PATH AND CRETAE IF NECESSARY
if ~exist('bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg','dir');
    disp('Making directory bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg');
    mkdir bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg
end

EEG = pop_loadset('filename','bids/derivatives/lossless/sub-s02/eeg/sub-s02_task-faceFO_eeg_ll.set','filepath','');
EEG = eeg_checkset( EEG );

%Collect STUDY information...
subj='ub-s02/eeg/sub-s02';

% Removed flagged channels and time segments
sprintf('%s','Purging flagged channels...\n');
EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual'},'remove','on');
EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
EEG = pop_marks_select_data(EEG,'component marks',[],'labels',{'manual'},'remove','on');
EEG = eeg_checkset(EEG);

%purge unnecessary fields...
for i=1:length(EEG.marks.time_info);
    EEG.marks.time_info(i).flags=[];
end
EEG=rmfield(EEG,'amica');
    
tmpEEG=EEG;

%face-inverted...
EEG = pop_epoch( tmpEEG, {'face-inverted'}, [-1 2], 'newname', 'faci', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0]);
EEG.subject=subj;
EEG.session='inv';
EEG.condition='face';
EEG.group=01;
EEG = pop_saveset( EEG, 'filename','bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg/sub-s02_task-faceFO_eeg_faci.set');

%face-upright...
EEG = pop_epoch( tmpEEG, {'face-upright'}, [-1 2], 'newname', 'facu', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0]);
EEG.subject=subj;
EEG.session='up';
EEG.condition='face';
EEG.group=01;
EEG = pop_saveset( EEG, 'filename','bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg/sub-s02_task-faceFO_eeg_facu.set');

%house-inverted...
EEG = pop_epoch( tmpEEG, {'house-inverted'}, [-1 2], 'newname', 'housi', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0]);
EEG.subject=subj;
EEG.session='inv';
EEG.condition='house';
EEG.group=01;
EEG = pop_saveset( EEG, 'filename','bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg/sub-s02_task-faceFO_eeg_housi.set');

%house-upright...
EEG = pop_epoch( tmpEEG, {'house-upright'}, [-1 2], 'newname', 'housu', 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-200 0]);
EEG.subject=subj;
EEG.session='up';
EEG.condition='house';
EEG.group=01;
EEG = pop_saveset( EEG, 'filename','bids/derivatives/lossless/derivatives/segmentation/sub-s02/eeg/sub-s02_task-faceFO_eeg_housu.set');


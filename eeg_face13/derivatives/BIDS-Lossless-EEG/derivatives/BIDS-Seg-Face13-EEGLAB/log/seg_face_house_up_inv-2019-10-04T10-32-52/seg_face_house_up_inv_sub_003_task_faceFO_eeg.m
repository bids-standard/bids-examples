%LOAD BIDS FILES
sphereLoc = 'derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_icasphere.tsv'
weightsLoc = 'derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_icaweights.tsv'
annoFile = 'derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_desc-qc_annotations.tsv'

elecFile = '././sub-003/eeg/sub-003_task-faceFO_electrodes.tsv'
eventsFile = '././sub-003/eeg/sub-003_task-faceFO_events.tsv'

EEG = pop_bidsload('derivatives/BIDS-Lossless-EEG/./sub-003/eeg/sub-003_task-faceFO_eeg.edf','elecLoc',elecFile,'eventLoc',eventsFile,'icaSphere',sphereLoc,'icaWeights',weightsLoc,'annoLoc',annoFile);

% add STUDY variables
% legacy mode for finding subject number.
myStr = './sub-003/eeg/sub-003_task-faceFO_eeg.edf';
indexStart = regexp(myStr,'\-(.*?)\/');
EEG.subject = str2num(myStr(indexStart+1:indexStart+3));
%session
EEG.session = 1;

% Removed flagged time segments and Independent Components
EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual', 'rank'},'remove','on');
EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
EEG = pop_marks_select_data(EEG,'component marks',[],'labels',{'manual'},'remove','on');
EEG = eeg_checkset(EEG);

%average rereference.
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual','rank'},'indexes','invert','on');
EEG = warp_locs( EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc','transform',[0,0,0,0,0,-1.57,1,1,1],'manual','off');
EEG = interp_ref(EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc','chans',chan_inds);
EEG.chaninfo.nosedir='+Y';
EEG = eeg_checkset(EEG);

% Interpolate flagged channels
%manual_mark_ind=find(strcmp('manual',{EEG.marks.chan_info.label}));
%rank_mark_ind=find(strcmp('rank',{EEG.marks.chan_info.label}));
%flags=EEG.marks.chan_info(manual_mark_ind).flags+EEG.marks.chan_info(rank_mark_ind).flags;
%chan_inds=find(flags);
%EEG = pop_interp(EEG,chan_inds,'spherical');

%purge unnecessary fields...
for i=1:length(EEG.marks.time_info);
    EEG.marks.time_info(i).flags=[];
end
EEG.data_sd_ep=[];
EEG.c_data_sd_ep=[];
EEG.data_sd_ch=[];
EEG.c_data_sd_ch=[];
EEG.m_neigbr_r_ch=[];
EEG.c_neigbr_r_ch=[];
EEG.m_neigbr_r_lat=[];
EEG.c_neigbr_r_lat=[];
EEG.amica=[];
EEG.icaact_sd1_lat=[];
EEG.c_icaact1_sd_lat=[];
EEG.icaact_sd2_lat=[];
EEG.c_icaact_sd2_lat=[];
EEG.icaact_ta_lat=[];
EEG.c_icaact_ta_lat=[];
EEG.icaact_b_lat=[];
EEG.c_icaact_b_lat=[];
% EEG.icaact = [];
% EEG.icawinv = [];
% EEG.icasphere = [];
% EEG.icaweights = [];
% EEG.icachansind = [];

%lowpass filter
%EEG = pop_eegfiltnew(EEG,[], 1,[],1,[],0);
EEG = pop_eegfiltnew(EEG,[],30,[],0,[],0);

% ICA information must be valid across all segmented files
%icaFileName = 'derivatives/BIDS-Lossless-EEG/derivatives/BIDS-Seg-Face13-EEGLAB/sub-003/eeg/sub-003_task-faceFO_icaweights.tsv';
%[outpath outname outext] = fileparts(icaFileName);
%if ~exist(outpath,'dir')
%    mkdir(outpath);
%end
%dlmwrite(icaFileName,EEG.icaweights,'\t');
%dlmwrite(strrep(icaFileName,'_icaweights.tsv','_icasphere.tsv'),EEG.icasphere,'\t');
%s = {};
%s.algorithm = 'amica15';
%s.icachansind = EEG.icachansind;
%s.intendedFor = 'derivatives/BIDS-Lossless-EEG/derivatives/BIDS-Seg-Face13-EEGLAB/sub-003/eeg/sub-003_task-faceFO';
%savejson('',s,strrep(icaFileName,'_icaweights.tsv','_icaweights.json'));

tmpEEG=EEG;

% face-upright
outfname='derivatives/BIDS-Lossless-EEG/derivatives/BIDS-Seg-Face13-EEGLAB/sub-003/eeg/sub-003_task-faceFO_desc-SEGfaceu_eeg.edf'
[outpath outname outext] = fileparts(outfname);
if ~exist(outpath,'dir')
    mkdir(outpath);
end
try
    EEG = pop_epoch( tmpEEG, { 'face-upright' }, ...
                 [-2 3], 'newname', 'direct', 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-1000    0]);
    EEG.condition = 'faceu';
    EEG = pop_saveset( EEG, 'filename',outfname);
    %pop_writeeeg(EEG, outfname, 'TYPE','EDF');
    %event_helper(outfname,EEG,{});
catch
    disp(['problem with ', outfname]);
end

% house-upright
outfname='derivatives/BIDS-Lossless-EEG/derivatives/BIDS-Seg-Face13-EEGLAB/sub-003/eeg/sub-003_task-faceFO_desc-SEGhousu_eeg.edf'
[outpath outname outext] = fileparts(outfname);
if ~exist(outpath,'dir')
    mkdir(outpath);
end
try
    EEG = pop_epoch( tmpEEG, { 'house-upright' }, ...
                 [-2 3], 'newname', 'direct', 'epochinfo', 'yes');
    EEG = pop_rmbase( EEG, [-1000    0]);
    EEG.condition = 'houseu';
    EEG = pop_saveset( EEG, 'filename',outfname);
    %pop_writeeeg(EEG, outfname, 'TYPE','EDF');
    %event_helper(outfname,EEG,{});
catch
    disp(['problem with ', outfname]);
end
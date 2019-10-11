warning off;

pkg load signal;
pkg load parallel;
pkg load io;

file_path = fileparts(mfilename('fullpath'));

addpath([file_path '/../../code/dependencies/eeglab_lossless'], ...
  [file_path '/../../code/dependencies/matlog'], ...
  [file_path '/../../code/tools']);
cd '/scratch/tk11br/Face13/';

% eeglab auto loads the path correctly instead of shotgun blasting with
% addpath(genpath(<>)) as we were doing prior
if ~exist('EEG', 'var')
  eeglab;
end
% Use matlog disp function override
logging_override_disp(true);
% Use matlog INFO level debugging
logging_set_log_level('INFO')

% Don't run with traditional but enable some of the options
save_default_options ('-mat-binary');
confirm_recursive_rmdir(false);

% This makes | and & || and && in earlier version of Octave where
% | and & dont short curcuit by default
if exist('do_braindead_shortcircuit_evaluation', 'builtin')
    do_braindead_shortcircuit_evaluation(true);
end

% Options
pop_editoptions('option_savetwofiles', 1,'option_single',0);

%% SCRIPT DESCRIPTION
% This script features the main preprocessing and cleaning of the data before the ICA process begin. Data is flagged for high standard deveiavtion
% by channel to remove comically bad channels. The data is then rereferenced to the average site, and high/low pass filtered.
% Channel neighbor correlations are then calculated to find odd channels and bridged channels. The outermost channel is also flagged to reduce the rank of the data.
% After another rereference channel correlations are calculated by time epoch and flagged. The file is saved containing the, marks structure, then saved again 
% with all of the mentioned flags puregd from the data in order to prime it for ICA.
%
%% From Config          key_strswap         Description
%-----------------------------------------------------------------------------------------------------------------------------
%    in_path =           []           Relative path to input data files assuming cd = work_path
%    montage_info =      [0.500 -22.000 -48.000 -0.065 0.000 -1.580 1060.000 1260.000 1220.000]      Montage information to fit channel locations on a standard surface.
%                                            This can be a transformations matrix (e.g. [-.14,-22,-48,-.07,0,-1.57,1080,1260,1240])
%                                            ... or a a file containing a transformation matrix (e.g. ./sub-009/eeg/sub-009_task-faceFO_eeg.edf_transmat.mat).
%                                            ... or a BIDS channel location tsv file (assuming that during BIDS init the channels were coregistered to the standard surface).
%    staging_script =    derivatives/BIDS-Lossless-EEG/code/scripts/face13_staging.m    Script file path/name that creates marks based on events in the raw data file. 
% 	 recur_sec =         1         Recurrence (sec) for artifact detection epoching (e.g. .5, Default 1)
%    limit_sec =         [0 1]         Limits (sec) for artifact detection epoching (e.g. [-.5 0], Default [0 recur_sec])
%    sd_t_meth =         na         Method used for flagging epochs (e.g. 'q' (quantiles), or 'na' (default))
%    sd_t_vals  =        [.3 .7]         Percentage trim for confidence intervals during epoch standard deviation criteria (e.g. [.3 .7])
%    sd_t_o =            16            z threshold for flagging epochs during standard deviation criteria (e.g. 6)
%    sd_t_f_meth =       fixed       Fixed method used for flagging epochs (should be 'fixed')
%    sd_t_f_vals  =             Percentage trim for confidence intervals during epoch standard deviation criteria (e.g. [.3 .7], leave empty for 'fixed')
%    sd_t_f_o =          .2          z threshold for flagging epochs during fixed standard deviation criteria (e.g. .2)
%    sd_t_pad =          1          Number of windows to pad onto each side of the ch_sd time flag
%    sd_ch_meth =        q        Method used for flagging channels (e.g. 'q' (quantiles), or 'na' (default))
%    sd_ch_vals  =       [.3 .7]        Percentage trim for confidence intervals during channel standard deviation criteria (e.g. [.3 .7])
%    sd_ch_o =           16           z threshold for flagging channels during standard deviation criteria (e.g. 6)
%    sd_ch_f_meth =      fixed      Fixed method used for flagging channels (should be 'fixed')
%    sd_ch_f_vals  =           Percentage trim for confidence intervals during channel standard deviation criteria (e.g. [.3 .7], leave empty for 'fixed')
%    sd_ch_f_o =         .2         z threshold for flagging channel during fixed standard deviation criteria (e.g. 6)
%    ref_loc_file =      derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc      Name of file containing the reference locations (including the relative path)    
%    low_bound_hz =      1      Lower bound of the filter bass-band
%    high_bound_hz =     100     Upper bound of the filter bass-band
%    save_f_res =        1        1 if you want to save the filter residuals (Default: 1)
%    n_nbr_ch =          3          Number of channels to use in nearest neighbour r calculation (for channel criteria)
%    r_ch_meth =         q         Method used for flagging low r channels (e.g. 'q' (quantiles), or 'na' (default))
%    r_ch_vals  =        [.3,.7]         Percentage trim for confidence intervals during low r channel standard deviation criteria (e.g. [.3 .7])
%    r_ch_o =            16            z threshold for flagging channel during neighbour r criteria (e.g. 3)
%    r_ch_f_meth =       fixed       Fixed method used for flagging low r channels (should be 'fixed')
%    r_ch_f_vals  =             Percentage trim for confidence intervals during low r channel standard deviation criteria (e.g. [.3 .7], leave empty for 'fixed')
%    r_ch_f_o =          .2          z threshold for flagging channel during fixed neighbour r criteria (e.g. 3)
%    bridge_trim =       40       Percentage trim for z calculation of bridged channels (e.g. 40 = 20% top and bottom)
%    bridge_z =          6          z threshold for flagging channel during bridging criteria (e.g. 8)
%    n_nbr_t =           3           Number of channels to use in nearest neighbour r calculation (for epoch criteria)
%    r_t_meth =          q          Method used for flagging low r epochs (e.g. 'q' (quantiles), or 'na' (default))
%    r_t_vals  =         [.3 .7]          Percentage trim for confidence intervals during low r epoch standard deviation criteria (e.g. [.3 .7])
%    r_t_o =             16             z threshold for flagging epochs during neighbour r criteria (e.g. 3)
%    r_t_f_meth =        fixed        Fixed method used for flagging low r epochs (should be 'fixed')
%    r_t_f_vals  =               Percentage trim for confidence intervals during low r epoch standard deviation criteria (e.g. [.3 .7], leave empty for 'fixed')
%    r_t_f_o =           .2           z threshold for flagging epochs during fixed neighbour r criteria (e.g. 3)
%    min_gap_ms =        2000        Minimum time (ms) to allow between periods marked for rejection
%    out_path =          derivatives/BIDS-Lossless-EEG          Relative path to output data files assuming cd = work_path
%    amica_param_file =  derivatives/BIDS-Lossless-EEG/code/misc/amica15_default.param  template amicadefs.param file to modify
%    amica_threads_s02 = 8 number of threads to use for running s02 amica script (Default: 8)

%% CHECK FOR OUTPUT PATH AND CRETAE IF NECESSARY
if ~exist('derivatives/BIDS-Lossless-EEG/./sub-009/eeg','dir');
    disp('Making directory derivatives/BIDS-Lossless-EEG/./sub-009/eeg');
    mkdir derivatives/BIDS-Lossless-EEG/./sub-009/eeg
end

%% LOAD DATASET
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
EEG = pop_bidsload('./sub-009/eeg/sub-009_task-faceFO_eeg.edf','gui',0);

if ~isfield(EEG,'marks');
    if isempty(EEG.icaweights)
        EEG.marks=marks_init(size(EEG.data));
    else
        EEG.marks=marks_init(size(EEG.data),min(size(EEG.icaweights)));
    end
end

EEG.marks = marks_add_label(EEG.marks,'time_info', ...
{'init_ind',[0,0,1],[1:EEG.pnts]});

%execute the staging script if specified.
if exist('derivatives/BIDS-Lossless-EEG/code/scripts/face13_staging.m');
    [ssp,ssn,sse]=fileparts('derivatives/BIDS-Lossless-EEG/code/scripts/face13_staging.m');
    addpath(ssp);
    eval(ssn);
end

%add channel coregistration procedure here.
%warp locations to standard head surface:
if ~isempty('[0.500 -22.000 -48.000 -0.065 0.000 -1.580 1060.000 1260.000 1220.000]');
    if isempty(str2num('[0.500 -22.000 -48.000 -0.065 0.000 -1.580 1060.000 1260.000 1220.000]'));
        %if it is a BIDS channel tsv, load the tsv,sd_t_f_vals
        %else read the file that is assumed to be a transformation matrix.
    else
        EEG = warp_locs( EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc', ...
            'transform',[[0.500 -22.000 -48.000 -0.065 0.000 -1.580 1060.000 1260.000 1220.000]], ...
            'manual','off');
    end
end

% Apply average re-reference
%chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
%chan_m = mean(EEG.data(chan_inds,:),1);
%chan_m_mat = repmat(chan_m,size(EEG.data,1),1);
%EEG.data = EEG.data - chan_m_mat;
%clear chan_m_mat;

% Window the continuous data
logging_log('INFO', 'Windowing the continous data...');
EEG = marks_continuous2epochs(EEG,'recurrence',[1],'limits',[[0 1]]);
logging_log('INFO', 'LOADED DATASET...');

% rereference to selected channels..
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
[EEG,trim_ch_sd]=chan_variance(EEG,'data_field','data', ...
         'chan_inds',chan_inds, ...
         'epoch_inds',epoch_inds, ...
         'plot_figs','off');

chan_dist=zeros(size(trim_ch_sd));
for i=1:size(trim_ch_sd,2);
    chan_dist(:,i)=(trim_ch_sd(:,i)-median(trim_ch_sd(:,i)))/diff(quantile(trim_ch_sd(:,i),[.3,.7]));
end
mean_chan_dist=mean(chan_dist,2);
m=median(mean_chan_dist);
q=quantile(mean_chan_dist,[.3,.7]);

refchans=find(mean_chan_dist<m+6*diff(q));

EEG.data=EEG.data-repmat(mean(EEG.data(chan_inds(refchans),:,:),1),size(EEG.data,1),1);

%% CALCULATE DATA SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This flag calculates the standard deviation  of the channels. Epochs are flagged if they
% are above the SD critical value. This flag identifies comically bad epochs.

% Calculate standard deviation of activation on non-'manual' flagged channels and epochs...
logging_log('INFO', 'Calculating the data sd array for time criteria...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
[EEG,data_sd_t]=chan_variance(EEG,'data_field','data', ...
    'chan_inds',chan_inds, ...
    'epoch_inds',epoch_inds, ...
    'plot_figs','off');
logging_log('INFO', 'CALCULATED EPOCH SD...');

% Create the window criteria vector for flagging ch_sd time_info...
logging_log('INFO', 'Assessing window data sd distributions...')
if strcmp('na','na');
    flag_sd_t_inds=[];
else
    [~,flag_sd_t_inds]=marks_array2flags(data_sd_t, ...
        'flag_dim','col', ...
        'init_method','na', ...
        'init_vals',[.3 .7], ...
        'init_crit',16, ...
        'flag_method','fixed',... % 'fixed', ...
        'flag_vals',[  ], ... % NEW
        'flag_crit',.2, ... % 'flag_val',[sd_t_p], ...
        'plot_figs','off');
end
logging_log('INFO', 'CREATED EPOCH CRITERIA VECTOR...');

% Edit the time flag info structure
logging_log('INFO', 'Updating epflaginfo structure...');
chsd_epoch_flags = zeros(size(EEG.data(1,:,:)));
chsd_epoch_flags(1,:,epoch_inds(flag_sd_t_inds))=1;
chsd_epoch_flags=padflags(EEG,chsd_epoch_flags,1,'value',.5);
EEG.marks = marks_add_label(EEG.marks,'time_info', ...
{'ch_sd',[0,0,1],chsd_epoch_flags});
logging_log('INFO', 'EDITED TIMEFLAGINFO STRUCT...');

% Combine ch_sd time_info flags into 'manual'...
EEG = pop_marks_merge_labels(EEG,'time_info',{'ch_sd'},'target_label','manual');
logging_log('INFO', 'COMBINED MARKS STRUCTURE INTO MANUAL FLAGS...');

%% CALCULATE DATA SD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This flag calculates the standard deviation  of the channels. Channels are flagged if they
% are above the SD critical value. This flag identifies comically bad channels.

% Calculate standard deviation of activation on non-'manual' flagged channels and epochs...
logging_log('INFO', 'Calculating the data sd array for channel criteria...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
[EEG,data_sd_ch]=chan_variance(EEG,'data_field','data', ...
    'chan_inds',chan_inds, ...
    'epoch_inds',epoch_inds, ...
    'plot_figs','off');
logging_log('INFO', 'CALCULATED CHAN SD...');

% Create the window criteria vector for flagging ch_sd chan_info...
logging_log('INFO', 'Assessing window data sd distributions...')
[~,flag_sd_ch_inds]=marks_array2flags(data_sd_ch, ...
    'flag_dim','row', ...
    'init_method','q', ...
    'init_vals',[.3 .7], ...
    'init_crit',16, ...
    'flag_method','fixed', ... %fixed
    'flag_vals',[  ], ...
    'flag_crit',.2, ...
    'plot_figs','off');
logging_log('INFO', 'CREATED CHANNEL CRITERIA VECTOR...');

% Edit the channel flag info structure
logging_log('INFO', 'Updating chflaginfo structure...');
chsd_chan_flags = zeros(EEG.nbchan,1);
chsd_chan_flags(chan_inds(flag_sd_ch_inds)) = 1;
EEG.marks = marks_add_label(EEG.marks,'chan_info', ...
{'ch_sd',[.7,.7,1],[.2,.2,1],-1,chsd_chan_flags});
logging_log('INFO', 'EDITED CHANFLAGINFO STRUCT...');

% Combine ch_sd chan_info flags into 'manual'...
EEG = pop_marks_merge_labels(EEG,'chan_info',{'ch_sd'},'target_label','manual');
logging_log('INFO', 'COMBINED MARKS STRUCTURE INTO MANUAL FLAGS...');

% Concatenate epoched data back to continuous data
logging_log('INFO', 'Concatenating windowed data...');
EEG = marks_epochs2continuous(EEG);
EEG = eeg_checkset(EEG,'eventconsistency');
logging_log('INFO', 'CONCATENATED THE WINDOWED DATA INTO CONTINUOUS DATA...');

%% REREFERENCE TO INTERPOLATED AVERAGE SITE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rereference the data to an average interpolated site containing 19 channels
% ... excluding 'manual' flagged channels from the calculation

logging_log('INFO', 'Rereferencing to averaged interpolated site...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
EEG = interp_ref(EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc','chans',chan_inds);
EEG = eeg_checkset(EEG);
logging_log('INFO', 'REREFERENCED TO INTERPOLATED AVERAGE SITE...');

%% FILTER HIGH PASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filters the data to remove frequencies lower than the selected value. The residuals that
% were removed can be saved for further analysis if needed.
logging_log('INFO', 'High pass filtering the data...');
if([1]);
    pre_hp_data = EEG.data;
    EEG = pop_eegfiltnew(EEG,[],[1],[],true,[],0);
    EEG.setname = 'filtHP';
    EEG = eeg_checkset( EEG );
    if 1
        % Save high pass filter residual data array
        logging_log('DEBUG', 'Saving file: derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_hpd.mat...');
        data = pre_hp_data - EEG.data;
        try OCTAVE_VERSION;
            save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_hpd.mat','data');
        catch
            save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_hpd.mat','data');
        end
        logging_log('DEBUG', 'TIME TO: SAVE derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_hpd.mat FILE...');
    end
    logging_log('INFO', 'FILTERED HIGH PASS...');
    clear pre_hp_data
else
    logging_log('INFO', 'High pass step skipped...');
end



%% FILTER LOW PASS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filters the data to remove frequencies higher the selected value. The residuals that
% were removed can be saved for further analysis if needed.
logging_log('INFO', 'Low pass filtering the data...');
if([100]);
    pre_lp_data = EEG.data;
    EEG = pop_eegfiltnew(EEG,[],[100],[],0,[],0);
    EEG.setname = 'filtLP';
    EEG = eeg_checkset( EEG );
    if 1
        % Save high pass filter residual data array
        logging_log('DEBUG', 'Saving file: derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_lpd.mat...');
        data = pre_lp_data - EEG.data;
        try OCTAVE_VERSION;
            save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_lpd.mat','data');
        catch
            save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_lpd.mat','data');
        end
        logging_log('DEBUG', 'TIME TO: SAVE derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_lpd.mat FILE...');
    end
    logging_log('INFO', 'FILTERED LOW PASS...');
    clear pre_lp_data
else
    logging_log('INFO', 'Low pass filtering skipped...');
end

%% CALCULATE NEAREST NEIGHBOUR R VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Checks neighboring channels for too high or low of a correlation.

% Window the continuous data
logging_log('INFO', 'Windowing the continous data...');
EEG = marks_continuous2epochs(EEG,'recurrence',[1],'limits',[[0 1]]);
logging_log('INFO', 'WINDOWED THE CONTINUOUS DATA...');

% Calculate nearest neighbout correlation on non-'manual' flagged channels and epochs...
logging_log('INFO', 'Calculating nearst neighbour r array for channel criteria...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
[EEG,data_r_ch,~,~,~] = chan_neighbour_r(EEG, ...
    3,'max', ...
    'chan_inds',chan_inds, ...
    'epoch_inds',epoch_inds, ...
    'plot_figs','off');

% Create the window criteria vector for flagging low_r chan_info...
logging_log('INFO', 'Assessing channel r distributions criteria...')
[~,flag_r_ch_inds]=marks_array2flags(data_r_ch, ...
    'flag_dim','row', ...
    'init_method','q', ...
    'init_vals',[.3,.7], ...
    'init_dir','neg', ...
    'init_crit',16, ...
    'flag_method','fixed', ...
    'flag_vals',[  ], ...
    'flag_crit',.2, ...
    'plot_figs','off');

% Edit the channel flag info structure
logging_log('INFO', 'Updating chflaginfo structure...');
lowr_chan_flags = zeros(EEG.nbchan,1);
lowr_chan_flags(chan_inds(flag_r_ch_inds))=1;
EEG.marks = marks_add_label(EEG.marks,'chan_info', ...
    {'low_r',[1,.7,.7],[1,.2,.2],-1,lowr_chan_flags});

logging_log('INFO', 'CALCULATED NEAREST NEIGHBOUR R VALUES...');

%% IDENTIFY BRIDGED CHANNELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uses the correlation of neighboors calculated to flag bridged channels.

logging_log('INFO', 'Examing nearest neighbour r array for linked channels...');
mr = median(data_r_ch,2);
iqrr = iqr(data_r_ch,2);
msr = mr./iqrr;
flag_b_chan_inds = find(msr>ve_trimmean(msr,40,1)+ve_trimstd(msr,40,1)*6);
logging_log('INFO', 'IDENTIFIED BRIDGED CHANNELS...');

% Edit the channel flag info structure
logging_log('INFO', 'Updating chflaginfo structure...');
lnkflags = zeros(EEG.nbchan,1);
lnkflags(chan_inds(flag_b_chan_inds))=1;
EEG.marks = marks_add_label(EEG.marks,'chan_info', ...
    {'bridge',[.7,1,.7],[.2,1,.2],-1,lnkflags});
logging_log('INFO', 'EDITED CHANFLAGINFO STRUCT...');

% Combine low_rand bridge chan_info flags into 'manual'...
EEG = pop_marks_merge_labels(EEG,'chan_info',{'low_r','bridge'},'target_label','manual');
logging_log('INFO', 'COMBINED MARKS STRUCTURE INTO MANUAL FLAGS...');

%% FLAG RANK CHAN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flags the channel that is the least unique (the best channel to remove prior 
% to ICA in order to account for the rereference rank deficiency.

logging_log('INFO', 'Updating chflaginfo structure...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
[r_max,rank_ind] = max(data_r_ch(chan_inds));
rankflags = zeros(EEG.nbchan,1);
rankflags(chan_inds(rank_ind))=1;
EEG.marks = marks_add_label(EEG.marks,'chan_info', ...
    {'rank',[.1,.1,.24],[.1,.1,.24],-1,rankflags});
logging_log('INFO', 'EDITED CHANFLAGINFO STRUCT...');

%% REREFERENCE TO INTERPOLATED AVERAGE SITE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rereference the data to an average interpolated site containined 19 channels
logging_log('INFO', 'Rereferencing to averaged interpolated site...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
EEG = interp_ref(EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1020_ll_ref19.elc','chans',chan_inds);
EEG = eeg_checkset(EEG);
logging_log('INFO', 'REREFERENCED TO INTERPOLATED AVERAGE SITE...');

%% CALCULATE NEAREST NEIGHBOUR R VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Similarly to the neighbor r calculation done between channels this section looks
% at the correlation, but between all channels and for epochs of time. Time segmenents 
% are flagged for removal.

logging_log('INFO', 'Calculating nearest neighbour r array for window criteria...');
chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
[EEG,data_r_t,~,~,~] = chan_neighbour_r(EEG, ...
    3,'max', ...
    'chan_inds',chan_inds, ...
    'epoch_inds',epoch_inds, ...
    'plotfigs','off');
logging_log('INFO', 'CALCULATED NEAREST NEIGHBOUR R VALUES...');

% Create the window criteria vector for flagging low_r time_info...
logging_log('INFO', 'Assessing epoch r distributions criteria...')
[~,flag_r_t_inds]=marks_array2flags(data_r_t, ...
    'flag_dim','col', ...
    'init_method','q', ...
    'init_vals',[.3 .7], ...
    'init_dir','neg', ...
    'init_crit',16, ...
    'flag_method','fixed', ...
    'flag_vals',[  ], ...
    'flag_crit',.2, ...
    'plot_figs','off');
logging_log('INFO', 'CREATED EPOCH CRITERIA VECTOR...');

% Edit the time flag info structure
logging_log('INFO', 'Updating latflaginfo structure...');
lowr_epoch_flags = zeros(size(EEG.data(1,:,:)));
lowr_epoch_flags(1,:,epoch_inds(flag_r_t_inds))=1;
EEG.marks = marks_add_label(EEG.marks,'time_info', ...
    {'low_r',[0,1,0],lowr_epoch_flags});
clear lowr_epoch_flags;
logging_log('INFO', 'TIME TO: UPDATE REJECTION STRUCTURE...');

% Combine low_r time_info flags into 'manual'...
EEG = pop_marks_merge_labels(EEG,'time_info',{'low_r'},'target_label','manual');
logging_log('INFO', 'COMBINED MARKS STRUCTURE INTO MANUAL FLAGS...');

% Concatenate epoched data back to continuous data
logging_log('INFO', 'Concatenating windowed data...');
EEG = marks_epochs2continuous(EEG);
EEG = eeg_checkset(EEG,'eventconsistency');
logging_log('INFO', 'CONCATENATED THE WINDOWED DATA INTO CONTINUOUS DATA...');

EEG=pop_marks_flag_gap(EEG,{'manual'},2000,'mark_gap',[.8,.8,.8],'offsets',[0 0],'ref_point','both');

% Combine mark_gap time_info flags into 'manual'...
EEG = pop_marks_merge_labels(EEG,'time_info',{'mark_gap'},'target_label','manual');
logging_log('INFO', 'COMBINED MARKS STRUCTURE INTO MANUAL FLAGS...');

%%%-----------------------------------------------------------------------
%% SAVE sa.set FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
logging_log('INFO', 'Saving file: ./sub-009/eeg/sub-009_task-faceFO_sa.set...');
if ~exist('derivatives/BIDS-Lossless-EEG/./sub-009/eeg','dir');
    mkdir('derivatives/BIDS-Lossless-EEG/./sub-009/eeg');
end
EEG = pop_saveset( EEG, 'filename','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_sa.set');
logging_log('INFO', 'SAVED sa FILE...');

%%%-----------------------------------------------------------------------
%% PREPARE FILE FOR AMICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purges the flagged data to make sure it is primed for ICA and creates the amica paramaeter file.

% Removed flagged channels and time segments
sprintf('%s','Purging flagged channels...\n');
EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual','rank'},'remove','on');
EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
EEG = eeg_checkset(EEG);
logging_log('INFO', 'TIME TO: PURGE DATA...');

% Make sure EEG.data is doubles for use in amica
EEG.data = double(EEG.data);

% Save the SA purge file
logging_log('INFO',sprintf('%s','Saving file: derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_sa_purge.set...'));
EEG = pop_saveset( EEG, 'filename','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_sa_purge.set');

% Save diagnostic arrays
try OCTAVE_VERSION;
    save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_sd_t.mat','data_sd_t');
    save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_sd_ch.mat','data_sd_ch');
    save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_r_ch.mat','data_r_ch');
    save('-mat7-binary','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_r_t.mat','data_r_t');
catch
    save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_sd_t.mat','data_sd_t');
    save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_sd_ch.mat','data_sd_ch');
    save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_r_ch.mat','data_r_ch');
    save('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_data_r_t.mat','data_r_t');
end

% Save the AMICA parameter file
swapstr = file_strswap('derivatives/BIDS-Lossless-EEG/code/misc/amica15_default.param', ...
    '[repstr_fdt_fname]','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_sa_purge.fdt', ...
    '[repstr_outpath]','derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_amicaout_init', ...
    '[repstr_nbchan]', num2str(EEG.nbchan), ...
    '[repstr_pnts]', sprintf('%12.0f',EEG.pnts), ...
    '[repstr_tpp]', '8', ...
    '[repstr_pca]', num2str(EEG.nbchan));
fidparam = fopen('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_init.param','w');
fprintf(fidparam,'%s',swapstr);
fclose(fidparam);

% CREATE THE AMICA OUTPUT FOLDER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Needed for MPI jobs on cluster only in order to prevent a race effect bug.

[~] = rmdir('derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_amicaout_init','s');
mkdir derivatives/BIDS-Lossless-EEG/./sub-009/eeg/sub-009_task-faceFO_amicaout_init;
logging_log('INFO', 'Created Amica Output Folder');

logging_log('INFO', 'Scalpart complete');
logging_log('INFO', 'Scheduler: sbatch');
print_chan_sample(EEG);

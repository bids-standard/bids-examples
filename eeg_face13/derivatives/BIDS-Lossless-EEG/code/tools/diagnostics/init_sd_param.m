function grp_out_dist = init_sd_param(infnames,outfname)

%% LOAD DATASET
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grp_out_dist=[];
for i=1:length(infnames);
    infnames{i}
    %Load the .set file (this will need to be BIDS data file format compliant)
    EEG = pop_loadset('filename',infnames{i});
    EEG = eeg_checkset( EEG );
    
    %% add channel coregistration procedure here.
    %warp locations to standard head surface:
    if ~isempty('[montage_info]');
        if isnumeric([-.14,-22,-48,-.07,0,-1.57,1080,1260,1240])
            EEG = warp_locs( EEG, ...
                'transform',[-.14,-22,-48,-.07,0,-1.57,1080,1260,1240], ...
                'manual','off');
        else
            %if it is a BIDS channel tsv, load the tsv,
            %else read the file that is assumed to be a transformation matrix.
        end
    end
    
    %% execute the event marks initiation script.
    %if exist('[event_marks_script]');
    %    run [event_marks_script]
    %end
    
    EEG.marks = marks_init(size(EEG.data));
    % Apply trimmed average re-reference
    chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
    trm_m = ve_trimmean(EEG.data(chan_inds,:),30,1);
    trm_m_mat = repmat(trm_m,size(EEG.data,1),1);
    EEG.data = EEG.data - trm_m_mat;
    clear trm_m_mat;
    
    %% Window the continuous data
    EEG = marks_continuous2epochs(EEG,'recurrence',[1],'limits',[0 1]);
    
    %% CALCULATE DATA SD
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % This flag calculates the standard deviation  of the channels. Epochs are flagged if they
    % are above the SD critical value. This flag identifies comically bad epochs.
    
    % Calculate standard deviation of activation on non-'manual' flagged channels and epochs...
    chan_inds = marks_label2index(EEG.marks.chan_info,{'manual'},'indexes','invert','on');
    epoch_inds = marks_label2index(EEG.marks.time_info,{'manual'},'indexes','invert','on');
    [EEG,data_sd_t]=chan_variance(EEG,'data_field','data', ...
        'chan_inds',chan_inds, ...
        'epoch_inds',epoch_inds, ...
        'plot_figs','off');
    
    %% Create the window criteria vector for flagging ch_sd time_info...
    if strcmp('q','na');
        flag_sd_t_inds=[];
    else
        [~,~,out_dist]=marks_array2flags(data_sd_t, ...
            'flag_dim','col', ...
            'init_method','q', ...
            'init_vals',[.3 .7], ...
            'init_crit',9, ...
            'flag_method','fixed', ...
            'flag_val',.2, ...
            'plot_figs','off');
    end
    logging_log('INFO', 'CREATED EPOCH CRITERIA VECTOR...');
    
    if isempty(grp_out_dist);
        grp_out_dist=out_dist;
    else
        grp_out_dist=[grp_out_dist,out_dist];
    end
    
    %% save output
    try OCTAVE_VERSION;
        save('-mat7-binary',[outfname,'.mat'],'grp_out_dist');
    catch
        save([outfname,'.mat'],'grp_out_dist');
    end
    
    nchans(i)=size(grp_out_dist,2);
    try OCTAVE_VERSION;
        save('-mat7-binary',[outfname,'_nch.mat'],'nchans');
    catch
        save([outfname,'_nch.mat'],'nchans');
    end
    
end
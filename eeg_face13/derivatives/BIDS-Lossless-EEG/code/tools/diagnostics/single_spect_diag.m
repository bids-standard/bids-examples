% This function loads a single file and gathers all of the needed
% information. fOutID should be the output file handle from
% main_diagnostics. singleSetFile should reflect its name.
function single_spect_diag(singleSetFile)
    % Storing what's going to be written to the csv in a variable to act as

    % Load:
    EEG = pop_loadset('filepath','','filename',singleSetFile);
    EEG = eeg_checkset( EEG );
    
    % Removed flagged channels and time segments
    sprintf('%s','Purging flagged channels...\n');
    EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual'},'remove','on');
    EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
%    EEG = pop_marks_select_data(EEG,'component marks',[],'labels',{'manual'},'remove','on');
    EEG = eeg_checkset(EEG);
    
    EEG= warp_locs(EEG,'derivatives/lossless/code/misc/standard_1020_Fpz_FT7_FT8_Cz_PO7_PO8_Oz.elc','transform',[0,0,0,0,0,-1.57,1,1,1],'manual','off');
    EEG = interp_mont(EEG,'derivatives/lossless/code/misc/standard_1020_Fpz_FT7_FT8_Cz_PO7_PO8_Oz.elc','manual','off');
    EEG = eeg_checkset(EEG);
    
    EEG.icaact=[];
    EEG.icawinv=[];
    EEG.icasphere=[];
    EEG.icaweights=[];
    EEG.icachansind=[];
    
    % Window the continuous data
    logging_log('INFO', 'Windowing the continous data...');
    EEG = marks_continuous2epochs(EEG,'recurrence',0.5,'limits',[0,1],'keepboundary','off');
    EEG = eeg_checkset(EEG);
    
    if EEG.srate==500;
        EEG.data=EEG.data(:,1:2:end,:);
        %EEG.srate=250;
    end
    %EEG = eeg_checkset(EEG);    

    h=hanning(250);
    hr=repmat(h,1,EEG.trials);

    for i=1:size(EEG.data,1);
        d=squeeze(EEG.data(i,:,:));    
        dh=d.*hr;
        f=fft(dh);
        out.tfm(:,i)=mean(abs(f(1:125,:)),2);
    end

    
    
    % Load:
    EEG = pop_loadset('filepath','','filename',singleSetFile);
    EEG = eeg_checkset( EEG );
    
    % Removed flagged channels and time segments
    sprintf('%s','Purging flagged channels...\n');
    EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual'},'remove','on');
    EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
    EEG = pop_marks_select_data(EEG,'component marks',[],'labels',{'manual'},'remove','on');
    EEG = eeg_checkset(EEG);
    
    EEG= warp_locs(EEG,'derivatives/lossless/code/misc/standard_1020_Fpz_FT7_FT8_Cz_PO7_PO8_Oz.elc','transform',[0,0,0,0,0,-1.57,1,1,1],'manual','off');
    EEG = interp_mont(EEG,'derivatives/lossless/code/misc/standard_1020_Fpz_FT7_FT8_Cz_PO7_PO8_Oz.elc','manual','off');
    EEG = eeg_checkset(EEG);
    
    EEG.icaact=[];
    EEG.icawinv=[];
    EEG.icasphere=[];
    EEG.icaweights=[];
    EEG.icachansind=[];
    
    % Window the continuous data
    logging_log('INFO', 'Windowing the continous data...');
    EEG = marks_continuous2epochs(EEG,'recurrence',0.5,'limits',[0,1],'keepboundary','off');
    EEG = eeg_checkset(EEG);
    
    if EEG.srate==500;
        EEG.data=EEG.data(:,1:2:end,:);
        %EEG.srate=250;
    end
    %EEG = eeg_checkset(EEG);
    
    h=hanning(250);
    hr=repmat(h,1,EEG.trials);

    for i=1:size(EEG.data,1);
        d=squeeze(EEG.data(i,:,:));    
        dh=d.*hr;
        f=fft(dh);
        out.pfm(:,i)=mean(abs(f(1:125,:)),2);
    end

    
    [path, name, ~]= fileparts(singleSetFile);
    outfname = [path,'/',name, '_spect_diag.mat'];
    disp(['Saving ' outfname '...']);
    save(outfname,'out');
end


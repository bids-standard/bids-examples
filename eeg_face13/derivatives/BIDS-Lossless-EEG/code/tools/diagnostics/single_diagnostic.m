% This function loads a single file and gathers all of the needed
% information. fOutID should be the output file handle from
% main_diagnostics. singleSetFile should reflect its name.
function single_diagnostic(fOutID, singleSetFile)
    % Storing what's going to be written to the csv in a variable to act as
    % a buffer. Line starts with filename.
    outString = [singleSetFile, ','];

    % Quantile breakdown used as a constant:
    quantBreakdown = [0.05,0.15,0.25,0.5,0.75,0.85,0.95];
    
    % Load:
    EEG = pop_loadset('filepath','','filename',singleSetFile);
    EEG = eeg_checkset( EEG );
    
    % Basic row info:
    outString = [outString, num2str(EEG.nbchan), ','];
    outString = [outString, num2str(EEG.pnts), ','];
    outString = [outString, num2str(EEG.srate), ','];
    
    % All time_info flags in seconds:
    % Manual
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags== 1)) / EEG.srate), ','];
    % ch_s_sd_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(3).flags == 1)) / EEG.srate), ','];
    % ch_s_sd_b_m (padding of ch_s_sd_m)
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(3).flags == 0.5)) / EEG.srate), ','];
    % ch_sd_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(4).flags == 1)) / EEG.srate), ','];
    % ch_sd_b_m (padding of ch_sd_m)
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(4).flags == 0.5)) / EEG.srate), ','];
    % low_r_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(5).flags == 1)) / EEG.srate), ','];
    % ic_sd1_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(8).flags == 1)) / EEG.srate), ','];
    % ic_sd1_b_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(8).flags == 0.5)) / EEG.srate), ','];
    % ic_sd2_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(12).flags == 1)) / EEG.srate), ','];
    % mark_gap
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(6).flags == 1)) / EEG.srate), ','];
    % overlap between ch_s_sd_b_m  and ch_sd_b_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(3).flags == 0.5 & EEG.marks.time_info(4).flags == 0.5)) / EEG.srate), ','];
    % overlap between ch_s_sd_b_m  and ic_sd1_b_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(3).flags == 0.5 & EEG.marks.time_info(8).flags == 0.5)) / EEG.srate), ','];
    % overlap between ch_sd_b_m and ic_sd1_b_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(4).flags == 0.5 & EEG.marks.time_info(8).flags == 0.5)) / EEG.srate), ','];
    % overlap between low_r_m and ic_sd1_b_m
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(5).flags == 1 & EEG.marks.time_info(8).flags == 0.5)) / EEG.srate), ','];
    % manual only
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 1 & EEG.marks.time_info(3).flags == 0 & EEG.marks.time_info(4).flags == 0 & ...
            EEG.marks.time_info(5).flags == 0 & EEG.marks.time_info(6).flags == 0 & EEG.marks.time_info(8).flags == 0 & EEG.marks.time_info(12).flags == 0)) / EEG.srate), ','];
    % non-manual but flagged for other reason
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 0 & (EEG.marks.time_info(3).flags > 0 | EEG.marks.time_info(4).flags > 0 | EEG.marks.time_info(5).flags > 0 | EEG.marks.time_info(6).flags > 0 | EEG.marks.time_info(8).flags > 0 | EEG.marks.time_info(12).flags > 0))) / EEG.srate), ','];
    % all non-manual
    outString = [outString, num2str(length(find(EEG.marks.time_info(1).flags == 0)) / EEG.srate), ','];

    % Single chan_info flag enables in seconds:
    for i=2:5 % [2,5] are ch_s_sd, ch_sd, low_r, and bridge respectively.
        outString = [outString, num2str(length(find(EEG.marks.chan_info(i).flags==1))), ','];
    end
    
    % Amica diagnostic info:
    outString = [outString, num2str(mean(EEG.amica(2).models.Lt)), ','];
    outString = [outString, num2str(std(EEG.amica(2).models.Lt)), ','];
    quants = quantile(EEG.amica(2).models.Lt,quantBreakdown);
    for i=1:length(quants)
        outString = [outString, num2str(quants(i)), ','];
    end
    % Manual QC comp count:
    outString = [outString, num2str(length(find(EEG.marks.comp_info(1).flags == 1))), ','];
    % Components marked as ic_rt
    outString = [outString, num2str(length(find(EEG.marks.comp_info(2).flags == 1))), ','];
    
    % ISCtest:
    a = [];
    for i=2:length(EEG.amica);
        a(:,:,i-1)=EEG.amica(i).models(1).A;
    end
    [~,~,linkpvalues,~] = isctest(a,0.05,0.05,'mixing');
    outString = [outString, num2str(mean(linkpvalues)), ','];
    outString = [outString, num2str(std(linkpvalues)), ','];
    quants = quantile(linkpvalues,quantBreakdown);
    for i=1:length(quants)
        outString = [outString, num2str(quants(i)), ','];
    end
    
    % Varianc measures:
    % Total data:
    EEG = pop_marks_select_data(EEG,'channel marks',[],'labels',{'manual'},'remove','on');
    EEG = pop_marks_select_data(EEG,'time marks',[],'labels',{'manual'},'remove','on');
    tvar=std(EEG.data,[],1);
    outString = [outString, num2str(mean(tvar)), ','];
    outString = [outString, num2str(std(tvar)), ','];
    quants = quantile(tvar,quantBreakdown);
    for i=1:length(quants)
        outString = [outString, num2str(quants(i)), ','];
    end

    % Projected data:
    EEG = pop_marks_select_data(EEG,'component marks',[],'labels',{'manual'},'remove','on');
    pvar=std(EEG.data,[],1);
    outString = [outString, num2str(mean(pvar)), ','];
    outString = [outString, num2str(std(pvar)), ','];
    quants = quantile(pvar,quantBreakdown);
    for i=1:length(quants)
        outString = [outString, num2str(quants(i)), ','];
    end
    
    % disp('hold');
    
    % Final write - includes newline
    fprintf(fOutID,'%s\n',outString);
end
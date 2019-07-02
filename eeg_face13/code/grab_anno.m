files = {'derivatives/lossless/sub-s01/eeg/sub-s01_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s02/eeg/sub-s02_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s03/eeg/sub-s03_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s04/eeg/sub-s04_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s05/eeg/sub-s05_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s06/eeg/sub-s06_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s07/eeg/sub-s07_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s08/eeg/sub-s08_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s09/eeg/sub-s09_task-faceO_eeg_qcr.set',...
'derivatives/lossless/sub-s10/eeg/sub-s10_task-faceO_eeg_qcr.set'};

%files = {'derivatives/lossless/sub-s01/eeg/sub-s01_task-faceO_eeg_qcr.set'};

for f=1:length(files)
    EEG.etc.eeglabvers = 'development head';
    EEG = eeg_checkset( EEG );
    EEG = pop_loadset('filename',files{f},'filepath','');
   
    annoOut = sprintf('onset\tduration\tlabel\tchannels\n%s',parseMarks(EEG.marks.chan_info,'EEG','chan'));
    annoOut = sprintf('%s%s',annoOut,parseMarks(EEG.marks.comp_info,'ICA','comp'));

    s = {};
    s.Description = 'Lossless state channel and component annotations.';
    s.IntendedFor = files{f};
    s.Sources = 'See BUCANL GitHub';
    s.Author = 'Lossless';
    s.LabelDescription.chan_manual = 'The interactive label (modified by analysts interactively or by a pipeline decision along with other labels) typically used to indicate which channels are considered artifactual for any reason.';
    s.LabelDescription.chan_ch_sd = 'Pipeline decision flag indicating that channels were too often outliers compared to other channels for the measure of standard deviation of voltage within one second epochs.';
    s.LabelDescription.chan_low_r = 'Pipeline decision flag indicating that channels were too often outliers compared to other channels for the measure of correlation coefficient to spatially neighbouring channels within one second epochs.';
    s.LabelDescription.chan_bridge = 'Pipeline decision flag indicating that channels were outliers for in terms of having high and invariant correlation coefficients to spatially neighbouring channels.';
    s.LabelDescription.chan_rank = 'Pipeline decision identifying the channel that has the least amount of unique information (highest average correlation coefficient to spatially neighbouring channels) to be ignored by ICA in order to account for the rank deficiency of the average referenced data.';
    s.LabelDescription.comp_manual = 'The interactive label (modified by analysts interactively or by a pipeline decision along with other labels) typically used to indicate which components are considered artifactual for any reason.';
    s.LabelDescription.comp_ic_rt = 'Pipeline decision flag indicating that components had a poor dipole fit (typically > %15 residual variance).';
    s.LabelDescription.comp_brain = 'ICLabel 0.3 Mark indicating that the compnents have cortical characteristics.';
    s.LabelDescription.comp_muscle = 'ICLabel 0.3 Mark indicating that the compnents have EMG characteristics.';
    s.LabelDescription.comp_eye = 'ICLabel 0.3 Mark indicating that the compnents have EOG characteristics.';
    s.LabelDescription.comp_heart = 'ICLabel 0.3 Mark indicating that the compnents have ECG characteristics.';
    s.LabelDescription.comp_line_noise = 'ICLabel 0.3 Mark indicating that the compnents have electrical mains noise characteristics.';
    s.LabelDescription.comp_chan_noise = 'ICLabel 0.3 Mark indicating that the compnents have channel independence characteristics.';
    s.LabelDescription.comp_other = 'ICLabel 0.3 Mark indicating that the compnents could not be confidently classified within any other ICLabel classification.';
    s.LabelDescription.comp_ambig = 'QC procedure rater markup indicating that the compnents are difficult to classify as either artifact or not.';
    
    % File IO
    savejson('',s,strrep(files{f},'.set','_annotations.json'));
    fID = fopen(strrep(files{f},'.set','_annotations.tsv'),'w');
    fprintf(fID,annoOut);
    fclose(fID);
    
    columnList = cell(1,length(EEG.marks.time_info));
    for i=1:length(EEG.marks.time_info)
        columnList{i} = EEG.marks.time_info(i).label;
    end
    
    s = {};
    s.SamplingFrequency = EEG.srate;
    s.StartTime = 0.0;
    s.Columns = columnList;
    s.ColumnDescription.manual = 'The interactive label (modified by analysts interactively or by a pipeline decision along with other labels) typically used to indicate which time points are considered artifactual for any reason.';
    s.ColumnDescription.init_ind = 'Continuous variable indicating the initial time point index within the session.';
    s.ColumnDescription.in_task_fhbc_onset = 'Based on experimental task events indicating time points within the duration of the fhbc_onset tasks (Face House Butterfly Checkerboard typical onset stimulus series).';
    s.ColumnDescription.in_leadup_fhbc_onset = 'Based on experimental task events indicating time points leading into (a few second before and a few seconds after the first experimental event in a block of trials) the duration of the fhbc_onset tasks (Face House Butterfly Checkerboard typical onset stimulus series).';
    s.ColumnDescription.out_task = 'Based on experimental task events indicating time points outside the duration of any experimental tasks (e.g. breaks, start up and end off times, etc).';
    s.ColumnDescription.mark_gap = 'Pipeline decision flag indicating that time points are within a short gap between other annotations.';
    s.ColumnDescription.ch_sd = 'Pipeline decision flag indicating that time points were too often outliers across channels compared to other time points for the measure of standard deviation of voltage within one second epochs.';
    s.ColumnDescription.low_r = 'Pipeline decision flag indicating that time points were too often outliers across channels compared to other time points for the measure of correlation coefficient to spatially neighbouring channels within one second epochs.';
    s.ColumnDescription.logl_init = 'Log likelihood of initial AMICA decomposition.';
    s.ColumnDescription.ic_sd1 = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component standard deviation of voltage within one second epochs.';
    s.ColumnDescription.logl_A = 'Log likelihood of final AMICA decomposition (replication A).';
    s.ColumnDescription.logl_B = 'Log likelihood of final AMICA decomposition (replication B).';
    s.ColumnDescription.logl_C = 'Log likelihood of final AMICA decomposition (replication C).';
    s.ColumnDescription.ic_sd2 = 'Pipeline decision flag indicating that time points were too often outliers across final components compared to other time points for the measure of component standard deviation of voltage within one second epochs.';
    s.ColumnDescription.ic_dt = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component spectral Theta within one second epochs.';
    s.ColumnDescription.ic_a = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component spectral Alpha within one second epochs.';
    s.ColumnDescription.ic_b = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component spectral Beta within one second epochs.';
    s.ColumnDescription.ic_lg = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component spectral Low Gama within one second epochs.';
    s.ColumnDescription.ic_hg = 'Pipeline decision flag indicating that time points were too often outliers across initial components compared to other time points for the measure of component spectral High Gama within one second epochs.';
    
    % Time info json io
    savejson('',s,strrep(files{f},'.set','_time_info.json'));
    
    % Time info gz output
    tFileName = strrep(files{f},'.set','_time_info.tsv');
    fID = fopen(tFileName,'w');
    for i=1:length(EEG.marks.time_info(1).flags)
        rowOut = '';
        for j=1:length(EEG.marks.time_info)
            rowOut = sprintf('%s%d\t',rowOut,EEG.marks.time_info(j).flags(i));
        end
        fprintf(fID,'%s\n',rowOut);
    end
    fclose(fID);
    
    % Zip and delete for storage - be careful with this
    gzip(tFileName);
    system(['rm ' tFileName]);
    
    disp([files{f} ' COMPLETE']);
end

function outStr = parseMarks(markStruct, labelPrefix, chanLabel)
    outStr = '';
    for i=1:length(markStruct)
        enabledList = '[';
        enabled = find(markStruct(i).flags);
        if length(enabled) < 1
            continue
        end
        for j=1:length(enabled)
            enabledList = sprintf('%s"%s%03d",',enabledList,labelPrefix,enabled(j));
        end
        enabledList(end) = ']';
        outStr = sprintf('%sn/a\tn/a\t%s\t%s\n',outStr,[chanLabel '_' markStruct(i).label],enabledList);
    end
end
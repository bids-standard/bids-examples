%clear
% convert all event data files
% Arnaud Delorme, 2017

files = {
'sub-Badsubject01/ses-01/eeg/sub-Badsubject01_ses-01_task-medprobe_event.txt' 0;
'sub-Expert01/ses-01/eeg/sub-Expert01_ses-01_task-medprobe_event.txt' 0; % check
'sub-Expert01/ses-02/eeg/sub-Expert01_ses-02_task-medprobe_event.txt' 0;
'sub-Expert02/ses-01/eeg/sub-Expert02_ses-01_task-medprobe_event.txt' 0;
'sub-Expert02/ses-02/eeg/sub-Expert02_ses-02_task-medprobe_event.txt' 0;
'sub-Expert03/ses-01/eeg/sub-Expert03_ses-01_task-medprobe_event.txt' 0;
'sub-Expert03/ses-02/eeg/sub-Expert03_ses-02_task-medprobe_event.txt' 0;
'sub-Expert04/ses-01/eeg/sub-Expert04_ses-01_task-medprobe_event.txt' 0;
'sub-Expert04/ses-02/eeg/sub-Expert04_ses-02_task-medprobe_event.txt' 0;
'sub-Expert05/ses-01/eeg/sub-Expert05_ses-01_task-medprobe_event.txt' 0;

'sub-Expert05/ses-02/eeg/sub-Expert05_ses-02_task-medprobe_event.txt' 0;
'sub-Expert06/ses-01/eeg/sub-Expert06_ses-01_task-medprobe_event.txt' 0;
'sub-Expert06/ses-02/eeg/sub-Expert06_ses-02_task-medprobe_event.txt' 0;
'sub-Expert07/ses-01/eeg/sub-Expert07_ses-01_task-medprobe_event.txt' 0;
'sub-Expert07/ses-02/eeg/sub-Expert07_ses-02_task-medprobe_event.txt' 0;
'sub-Expert08/ses-01/eeg/sub-Expert08_ses-01_task-medprobe_event.txt' 0;
'sub-Expert09/ses-01/eeg/sub-Expert09_ses-01_task-medprobe_event.txt' 0;
'sub-Expert09/ses-02/eeg/sub-Expert09_ses-02_task-medprobe_event.txt' 0;
'sub-Expert10/ses-01/eeg/sub-Expert10_ses-01_task-medprobe_event.txt' 0;
'sub-Expert10/ses-02/eeg/sub-Expert10_ses-02_task-medprobe_event.txt' 0;

'sub-Expert11/ses-01/eeg/sub-Expert11_ses-01_task-medprobe_event.txt' 1;
'sub-Expert11/ses-02/eeg/sub-Expert11_ses-02_task-medprobe_event.txt' 1; 
'sub-Expert12/ses-01/eeg/sub-Expert12_ses-01_task-medprobe_event.txt' 1; 
'sub-Novice01/ses-01/eeg/sub-Novice01_ses-01_task-medprobe_event.txt' 0;
'sub-Novice02/ses-02/eeg/sub-Novice02_ses-02_task-medprobe_event.txt' 0;
'sub-Novice03/ses-01/eeg/sub-Novice03_ses-01_task-medprobe_event.txt' 0;
'sub-Novice04/ses-01/eeg/sub-Novice04_ses-01_task-medprobe_event.txt' 0;
'sub-Novice04/ses-02/eeg/sub-Novice04_ses-02_task-medprobe_event.txt' 0;
'sub-Novice05/ses-01/eeg/sub-Novice05_ses-01_task-medprobe_event.txt' 0;
'sub-Novice05/ses-02/eeg/sub-Novice05_ses-02_task-medprobe_event.txt' 0;

'sub-Novice06/ses-01/eeg/sub-Novice06_ses-01_task-medprobe_event.txt' 0;
'sub-Novice06/ses-02/eeg/sub-Novice06_ses-02_task-medprobe_event.txt' 0;
'sub-Novice07/ses-01/eeg/sub-Novice07_ses-01_task-medprobe_event.txt' 0;
'sub-Novice08/ses-01/eeg/sub-Novice08_ses-01_task-medprobe_event.txt' 0;
'sub-Novice09/ses-01/eeg/sub-Novice09_ses-01_task-medprobe_event.txt' 1;
'sub-Novice10/ses-01/eeg/sub-Novice10_ses-01_task-medprobe_event.txt' 0;
'sub-Novice10/ses-02/eeg/sub-Novice10_ses-02_task-medprobe_event.txt' 0;
'sub-Novice10/ses-03/eeg/sub-Novice10_ses-03_task-medprobe_event.txt' 1;
'sub-Novice11/ses-01/eeg/sub-Novice11_ses-01_task-medprobe_event.txt' 0;
'sub-Novice11/ses-02/eeg/sub-Novice11_ses-02_task-medprobe_event.txt' 0;

'sub-Novice12/ses-01/eeg/sub-Novice12_ses-01_task-medprobe_event.txt' 0};

for iFile = 1:length(files)
    fileNameEEG = [ files{iFile,1}(1:end-10) '_eeg.bdf' ];
    fprintf('************************\nProcessing file %s\n************************\n', fileNameEEG);
    EEG = pop_biosig(fileNameEEG);
    
    % load event file
    % ---------------
    fileName  = files{iFile,1};
    alignVal  = files{iFile,2};
    evt = fopen(fileName,'r');
    events = [];
    while ~feof(evt)
        ln = fgetl(evt);
        
        % decode time
        tInd = findstr('time', ln);
        sInd = findstr('second', ln);
        timeVal = str2num(ln(tInd+4:sInd-1));
        if isempty(timeVal)
            error('Cannot decode time')
        end
        
        if ln(1) == 'M'
            events(end+1).latency = timeVal*EEG.srate;
            events(end).type = 'audio_probe';
        else
            key     = ln(5);
            if ~ismember(str2num(key), [0 1 2 3])
                error('Issue with key press');
            end
            status  = ln(end);
            events(end+1).latency = timeVal*EEG.srate;
            switch status
                case '1', events(end).type = ['Mind-wandering_response-' key];
                case '2', events(end).type = ['Meditation_response-' key];
                case '3', events(end).type = ['Tiredness_response-' key];
                otherwise error('Issue with status');
            end;
        end
    end
    fclose(evt);
    
    % write events as text file
    % -------------------------
    fid = fopen('tmp.txt', 'w');
    for iEvent = 1:length(events)
        fprintf(fid, '%1.6f\t%s\n', events(iEvent).latency/EEG.srate, events(iEvent).type);
    end
    fclose(fid);
    EEG = pop_importevent( EEG, 'append','no','event','tmp.txt','fields',{'latency' 'type'},'timeunit',1,'align',alignVal,'optimmeas', 'median');
    
    % save event file
    % ---------------
    fid = fopen([ fileName(1:end-4) '.tsv' ], 'w');
    fprintf(fid, 'onset\tduration\ttrial_type\n');
    for iEvent = 1:length(EEG.event)
        fprintf(fid, '%1.3f\t0\t%s\n', EEG.event(iEvent).latency/EEG.srate, EEG.event(iEvent).type);
    end
    fclose(fid);
end

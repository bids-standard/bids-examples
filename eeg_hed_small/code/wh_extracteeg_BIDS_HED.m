% Wakeman-Henson data EEG extraction from FIF files to be saved into BIDS
% format.
%
% Channel locatons are extracted and saved without modification. For use in EEGLAB is recomended to 
%  1) Rotate the nose direction to match the +Y axes. For this use: EEG = pop_chanedit(EEG,'nosedir','+Y');
%     This line is commented below
%  2) Recompute the center of the electrode coordinates
%     For this use: EEG = pop_chanedit(EEG, 'eval','chans = pop_chancenter( chans, [],[])');
%     This line is commented below
%
% Authors: Ramon Martinez-Cancino, SCCN, 2019
%          Arnaud Delorme, SCCN, 2019
%          Dung Truong, SCCN, 2019
%
% Copyright (C) 2019  Ramon Martinez-Cancino,INC, SCCN
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
% script folder, this must be updated to the files on your enviroment.
clear;                                      % clearing all is recommended to avoid variable not being erased between calls
currentPath = fileparts( which('wh_extracteeg_BIDS') );
path2code = currentPath;

% path2data = fullfile(currentPath, 'ds117'); % Arno's path
path2data      = '/data/projects/WakemanHensonData/r00_rawdata/rawdata_unzip'; % Path to  the original unzipped data files

% path2stim = fullfile(currentPath, 'face_images');
path2stim      = '/data/projects/WakemanHensonData/r00_rawdata/ds117_R0.1.1_metadata/stimuli/meg';

path2save = fullfile(fileparts(currentPath), 'ds117forbids-HED'); % Arno's path
% path2save = fullfile(fileparts(fileparts(currentPath)), 'ds117forbids');

dInfo;                              % load dataset information (datInfo)
% addpath('/data/projects/BIDSfiles/HED-wakeman-henson/code/eeglab-lite');
[ALLEEG, EEG, CURRENTSET] = eeglab; % start EEGLAB

if ~exist(path2data,'dir'), error('Data folder not found, edit script to indicate data location'); end
if ~exist(path2save,'dir'), mkdir(path2save); end % check if folders exist
if ~exist('ft_read_data','file'), error('You must install the File-IO plugin'); end

% Copy stimulus file (This can be done with command 'dir' but there may be tons of hidden files, then we'll need more code to filter out this files)
files1 = dir(fullfile(path2stim,'f*.bmp'));
files2 = dir(fullfile(path2stim,'s*.bmp'));
files3 = dir(fullfile(path2stim,'u*.bmp'));
allstimfiles = [files1 ;files2 ;files3];
mkdir(fullfile(fileparts(fileparts(currentPath)), 'faces_images'));
for i = 1:length(allstimfiles)
    copyfile(fullfile(allstimfiles(i).folder, allstimfiles(i).name),fullfile(fileparts(fileparts(currentPath)), 'faces_images'));
end


% Extract EEG data from the FIF file and importing it to EEGLAB
parfor isubj = 2:length(datInfo)    % Loop accross subjects (Subject 0001 was taken out of the analysis)
    ALLEEG = []; CURRENTSET = 0; % Initializing/clearing variables for each subject in the loop
    
    for irun = 1:6            % Loop accross runs
        
        % Step 1: Importing data with FileIO
        EEG = pop_fileio(fullfile(path2data, datInfo(isubj).name,'MEG',['run_0' num2str(irun) '_raw.fif']));
        
        % Step 2: Selecting EEG data and event (STI101) channels
        % EEG channels 1-60 are EEG, as are 65-70, but channels 61-64 are actually HEOG, VEOG and two floating channels (EKG). 
        eeg_mask = cellfun(@(x) logical(~isempty(x)), regexp({EEG.chanlocs.labels},'EEG.*'));
        meg_mask = cellfun(@(x) logical(~isempty(x)), regexp({EEG.chanlocs.labels},'MEG.*'));
        stim_chan_mask = strcmp({EEG.chanlocs.labels},'STI101');
        selected_chans = find(eeg_mask | meg_mask | stim_chan_mask);
%         EEGtest = pop_select(EEG, 'channel', {'EEG001' 'EEG002' 'EEG003' 'EEG004' 'EEG005' 'EEG006' 'EEG007' 'EEG008' 'EEG009' 'EEG010' 'EEG011' 'EEG012' 'EEG013' 'EEG014' 'EEG015'...
%                                           'EEG016' 'EEG017' 'EEG018' 'EEG019' 'EEG020' 'EEG021' 'EEG022' 'EEG023' 'EEG024' 'EEG025' 'EEG026' 'EEG027' 'EEG028' 'EEG029' 'EEG030'...
%                                           'EEG031' 'EEG032' 'EEG033' 'EEG034' 'EEG035' 'EEG036' 'EEG037' 'EEG038' 'EEG039' 'EEG040' 'EEG041' 'EEG042' 'EEG043' 'EEG044' 'EEG045'...
%                                           'EEG046' 'EEG047' 'EEG048' 'EEG049' 'EEG050' 'EEG051' 'EEG052' 'EEG053' 'EEG054' 'EEG055' 'EEG056' 'EEG057' 'EEG058' 'EEG059' 'EEG060'...
%                                           'EEG061' 'EEG062' 'EEG063' 'EEG064' 'EEG065' 'EEG066' 'EEG067' 'EEG068' 'EEG069' 'EEG070' 'EEG071' 'EEG072' 'EEG073' 'EEG074' 'STI101'});
        EEG = pop_select(EEG, 'channel', selected_chans);
        % Correcting channel type to be EEG
       for ichan = 1:length(EEG.chanlocs)-1 % ignoring STI101
           if isempty(regexp(EEG.chanlocs(ichan).labels,'MEG.*','once'))
               EEG = pop_chanedit(EEG,'changefield',{ichan  'type' 'EEG'});
           else
               EEG = pop_chanedit(EEG,'changefield',{ichan  'type' 'MEG'});
           end
       end
       
       % Correcting reference label
       EEG.ref = 'nose';
                                      
        % Step 3: Adding fiducials and rotating montage. Note:The channel location from this points were extracted from the FIF 
        % files (see below) and written in the dInfo file. The reason is that File-IO does not import these coordinates.
        EEG = pop_chanedit(EEG,'append',{length(EEG.chanlocs) 'LPA' [] [] datInfo(isubj).fid(1,1) datInfo(isubj).fid(1,2) datInfo(isubj).fid(1,3) [] [] [] 'FID' '' [] 0 [] []});
        EEG = pop_chanedit(EEG,'append',{length(EEG.chanlocs) 'Nz'  [] [] datInfo(isubj).fid(2,1) datInfo(isubj).fid(2,2) datInfo(isubj).fid(2,3) [] [] [] 'FID' '' [] 0 [] []});
        EEG = pop_chanedit(EEG,'append',{length(EEG.chanlocs) 'RPA' [] [] datInfo(isubj).fid(3,1) datInfo(isubj).fid(3,2) datInfo(isubj).fid(3,3) [] [] [] 'FID' '' [] 0 [] []});
        %EEG = pop_chanedit(EEG,'nosedir','+Y'); % Not used here
        
        % Changing Channel types and removing channel locations for channels 61-64 (Raw data types are incorrect)
        EEG = pop_chanedit(EEG,'changefield',{find(strcmp({EEG.chanlocs.labels}, 'EEG061'))  'type' 'HEOG'  'X'  []  'Y'  []  'Z'  []  'theta'  []  'radius'  []  'sph_theta'  []  'sph_phi'  []  'sph_radius'  []});
        EEG = pop_chanedit(EEG,'changefield',{find(strcmp({EEG.chanlocs.labels}, 'EEG062'))  'type' 'VEOG'  'X'  []  'Y'  []  'Z'  []  'theta'  []  'radius'  []  'sph_theta'  []  'sph_phi'  []  'sph_radius'  []});  
        EEG = pop_chanedit(EEG,'changefield',{find(strcmp({EEG.chanlocs.labels}, 'EEG063'))  'type' 'EKG'   'X'  []  'Y'  []  'Z'  []  'theta'  []  'radius'  []  'sph_theta'  []  'sph_phi'  []  'sph_radius'  []});  
        EEG = pop_chanedit(EEG,'changefield',{find(strcmp({EEG.chanlocs.labels}, 'EEG064'))  'type' 'EKG'   'X'  []  'Y'  []  'Z'  []  'theta'  []  'radius'  []  'sph_theta'  []  'sph_phi'  []  'sph_radius'  []});                                                   
                                                             
        % Recomputing head center  % Not used here
        % EEG = pop_chanedit(EEG, 'eval','chans = pop_chancenter( chans, [],[])');
        
        % Step 4: Re-import events from STI101 channel (the original ones are incorect)
        stim_chan_index = find(strcmp({EEG.chanlocs.labels}, 'STI101'));
        EEG = pop_chanevent(EEG, stim_chan_index,'edge','leading','edgelen',datInfo(isubj).edgelenval,'delevent','on','delchan','off','oper','double(bitand(int32(X),31))'); % first 5 bits
                
        % Step 5: Cleaning artefactual events (keep only valid event codes)
        EEG = pop_selectevent( EEG, 'type',[5 6 7 13 14 15 17 18 19],'deleteevents','on'); 
%         EEG = pop_selectevent( EEG, 'type',[arrayfun(@num2str,[5 6 7 13 14 15 17 18 19],'UniformOutput',false) 'circle'] ,'deleteevents','on'); 
        if isubj== 3 && irun == 4, EEG = pop_editeventvals(EEG, 'delete', 24); end
        
        % Step 6: Importing info from image presented into event structure
        EEG = pop_importevent(EEG, 'skipline', 1, 'fields', {'stimtype' 'nested' 'ignore' 'imgcode' 'imgfile' }, 'event', fullfile(path2data, datInfo(isubj).name,'MEG',[datInfo(isubj).name '_' num2str(irun) '.txt']));
 
        % Circle onset
        EEG = pop_chanevent(EEG, stim_chan_index,'edge','trailing','edgelen',datInfo(isubj).edgelenval,'delevent','off','delchan','off','nbtype',1,'typename','0','oper','double(bitand(int32(X),31))'); % first 5 bits

        % Step 7:Importing  button press info
        EEG = pop_chanevent(EEG, stim_chan_index,'edge','leading','edgelen',datInfo(isubj).edgelenval, 'delevent','off','delchan','off','oper','double(bitand(int32(X),8160))'); % bits 5 to 13
        
        % Step 8: Event manipulation (not necessary in standard analysis)
        % Here fixing overlapped buttonpressing events
        event4352 = find([EEG.event.type]==4352); % overlapping of events 256 and 4096
        if ~isempty(event4352)
            for ievt =1: length(event4352)
                event4352_1 = find([EEG.event.type]==4352,1);
                if EEG.event(event4352_1 - 1).type == 256 || EEG.event(event4352_1 - 1).type == 4096
                    EEG = pop_editeventvals( EEG,'changefield', { event4352_1 'type'  4352-EEG.event(event4352_1 -1).type});
                else
                    EEG = pop_editeventvals( EEG, 'delete', event4352_1);
                end
            end
        end
        
        % Renaming, adding and removing event fields
        % EEG = pop_editeventfield( EEG, 'rename', 'imgcode->stim_file'); % Note: Code kept for further analysis. DO NOT USE
         EEG = pop_editeventfield( EEG, 'rename', 'imgfile->stim_file');
         EEG = pop_editeventfield( EEG,'rename', 'ignore->face_type');
%          EEG = pop_editeventfield( EEG,'rename', 'ignore->event_type');       
         EEG = pop_editeventfield( EEG, 'nested', [], 'stimtype',[],'imgcode', [], 'trigger', {EEG.event.type});
        
        % Renaming button press events in field event type 
%         EEG = pop_selectevent( EEG, 'type',256, 'renametype',datInfo(isubj).event256 ,'deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',4096,'renametype',datInfo(isubj).event4096,'deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',256, 'renametype','left_press' ,'deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',4096,'renametype','right_press','deleteevents','off');
%         
%         % Updating  field stimtype for the button press event
%         indx1 = find(strcmp({EEG.event.type}, 'right_finger'));
%         indx2 = find(strcmp({EEG.event.type}, 'left_finger'));
%         allindx = sort([indx1, indx2]);
%         
%         for iButton = 1:length(allindx)
%             EEG = pop_editeventvals( EEG,'changefield', { allindx(iButton) 'event_type' 'button_press'});
%         end
        
        % Rename face presentation events
%         EEG = pop_selectevent( EEG, 'type',5,'renametype','famous_new','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',6,'renametype','famous_second_early','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',7,'renametype','famous_second_late','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',13,'renametype','unfamiliar_new','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',14,'renametype','unfamiliar_second_early','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',15,'renametype','unfamiliar_second_late','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',17,'renametype','scrambled_new','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',18,'renametype','scrambled_second_early','deleteevents','off');
%         EEG = pop_selectevent( EEG, 'type',19,'renametype','scrambled_second_late','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',0,'renametype','show_circle','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',5,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',6,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',7,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',13,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',14,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',15,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',17,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',18,'renametype','show_face','deleteevents','off');
        EEG = pop_selectevent( EEG, 'type',19,'renametype','show_face','deleteevents','off');
        
        % Time and trial distance between face presentation events
        EEG = pop_editeventfield( EEG, 'trial_dist','0');
        EEG = pop_editeventfield( EEG, 'time_dist' ,'0');
        myevents   = arrayfun(@num2str,[ 5 6 7 13 14 15 17 18 19], 'UniformOutput', false);
%         allevents  = [EEG.event.value]; % Retreiving events indices
        allevents  = [EEG.event.trigger]; % Retreiving events indices
        indx2insert = find(ismember(allevents, myevents));
        
        for ievents = 1 : length(indx2insert)
%             if ~ismember(EEG.event(indx2insert(ievents)).value,[5 13 17]) && ievents ~= 1
            if ~ismember(EEG.event(indx2insert(ievents)).trigger,{'5' '13' '17'}) && ievents ~= 1
                tmpeventlist =  indx2insert(1:ievents-1);
                tmpevent = EEG.event(indx2insert(ievents)).stim_file;
                allprev_event = find(~cellfun(@isempty,strfind({EEG.event(tmpeventlist).stim_file},tmpevent)));
                
                if ~isempty(allprev_event)
                    timedist  =  (EEG.event(indx2insert(ievents)).latency - EEG.event(tmpeventlist(allprev_event(end))).latency)/EEG.srate;
                    trialdist =   (length(tmpeventlist)-allprev_event(end)) + 1;
                    
                    EEG = pop_editeventvals(EEG,'changefield',{indx2insert(ievents) 'trial_dist' trialdist});
                    EEG = pop_editeventvals(EEG,'changefield',{indx2insert(ievents) 'time_dist'  timedist});
                end
            end
        end
        
        % Presentation order
        EEG = pop_editeventfield( EEG, 'event_order','0');
        uniquefaces = unique({EEG.event.stim_file});
        for ievents =1: length(uniquefaces)
            evtindx = find(~cellfun(@isempty,strfind({EEG.event.stim_file},uniquefaces(ievents))));
            if ~isempty(evtindx)
                for i=1:length(evtindx)
                EEG = pop_editeventvals(EEG,'changefield',{evtindx(i) 'event_order' i});
                end
            end
        end
        
        % Repetition type condition
        EEG = pop_editeventfield( EEG, 'repetition_type','n/a');
        for ievents=1:length(EEG.event)
            if EEG.event(ievents).event_order == 1
                EEG = pop_editeventvals(EEG,'changefield',{ievents 'repetition_type' 'first_show'});
            elseif EEG.event(ievents).event_order == 2
                if EEG.event(ievents).trial_dist == 1
                    EEG = pop_editeventvals(EEG,'changefield',{ievents 'repetition_type' 'immediate_repeat'});
                elseif EEG.event(ievents).trial_dist > 1
                    EEG = pop_editeventvals(EEG,'changefield',{ievents 'repetition_type' 'delayed_repeat'});
                end
            end
        end
        
        % Face type
        EEG = pop_editeventfield( EEG, 'face_type','n/a');
        for i=1:length(allevents)            
            % Type of face
            if strcmp(EEG.event(i).trigger, '5') || strcmp(EEG.event(i).trigger, '6') || strcmp(EEG.event(i).trigger, '7')
                evttmp = 'famous_face';
            elseif strcmp(EEG.event(i).trigger, '13') || strcmp(EEG.event(i).trigger, '14') || strcmp(EEG.event(i).trigger, '15')
                evttmp = 'unfamiliar_face';
            elseif strcmp(EEG.event(i).trigger, '17') || strcmp(EEG.event(i).trigger, '18') || strcmp(EEG.event(i).trigger, '19')
                evttmp = 'scrambled_face';    
            else
                evttmp = 'n/a';    
            end
                
            EEG = pop_editeventvals(EEG,'changefield',{i 'face_type' evttmp}); 
        end
        
        
        % Updating path to stimulus        
        for ievt =1: length(indx2insert)
            [path2stim,filename, fileext] = fileparts(EEG.event(indx2insert(ievt)).stim_file);
            EEG = pop_editeventvals(EEG,'changefield',{indx2insert(ievt) 'stim_file' [filename, fileext]});
        end
        
        % Add fixation-cross events 1700ms after circle onset
        nevents = length(EEG.event);
        for index = 1 : nevents
            if ischar(EEG.event(index).type) && strcmpi(EEG.event(index).type, 'show_circle')
            % Add events relative to existing events
                EEG.event(end+1) = EEG.event(index); % Add event to end of event list
                % Specifying the event latency to be 1.7 sec after the referent event (in real data points)
                EEG.event(end).latency = EEG.event(index).latency + 1.7*EEG.srate;
                EEG.event(end).type = 'show_cross'; % Make the type of the new event cue
                EEG.event(end).trigger = {'n/a'}; % Mark that cross events doesn't exist in actual trigger channel
                EEG.event(end).stim_file = 'cross.bmp';
            end
        end
        EEG = eeg_checkset(EEG, 'eventconsistency'); % Check all events for consistency
        
        % Step 9: Correcting event latencies (events have a shift of 34 ms)
        EEG = pop_adjustevents(EEG,'addms',34);
        
        % Remove/rename event fields
        EEG = pop_editeventfield( EEG, 'urevent',[], 'duration', [], 'event_order', [], 'trial_dist', [], 'time_dist', []);

        % Correct and fill up empty fields for event 'stim_file'
        for iEvent = 1:length(EEG.event)
            if ischar(EEG.event(iEvent).type) && strcmpi(EEG.event(iEvent).type, 'show_circle')
                EEG.event(iEvent).stim_file = 'circle.bmp';
            end
            if isempty(EEG.event(iEvent).stim_file)
                EEG.event(iEvent).stim_file = 'n/a';
%             else
%                 EEG.event(iEvent).stim_file = EEG.event(iEvent).stim_file(14:end);
            end
        end
        % Step 10: Replacing original imported channels
        % Note: This is a very unusual step that should not be done lightly. The reason here is because
        %       of the original channels were wrongly labeled at the time of the experiment
        EEG = pop_chanedit(EEG, 'rplurchanloc',1);
        
        % Step 11: Resample the data to 250Hz
        EEG = pop_resample( EEG, 250);
        
        % Add setup event at beginning of the event file
        EEG.event(end+1) = EEG.event(1);
        EEG.event(end).latency = 1;
        EEG.event(end).type = 'setup';
        EEG.event(end).face_type = 'n/a';
        EEG.event(end).repetition_type = 'n/a';
        EEG.event(end).trigger = {'n/a'};
        EEG.event(end).stim_file = 'n/a';
        
        EEG.event(end+1) = EEG.event(1);
        EEG.event(end).latency = 1;
        if strcmp(datInfo(isubj).event256,'left_nonsym')
            EEG.event(end).type = 'right_sym';
        elseif strcmp(datInfo(isubj).event256,'left_sym')
            EEG.event(end).type = 'left_sym';
        end
        EEG.event(end).face_type = 'n/a';
        EEG.event(end).repetition_type = 'n/a';
        EEG.event(end).trigger = {'n/a'};
        EEG.event(end).stim_file = 'n/a';
        EEG = eeg_checkset(EEG, 'eventconsistency'); 
        
        % Step 12: Creating subject folder if does not exist and save dataset
        if ~exist(fullfile(path2save,datInfo(isubj).name), 'dir'), mkdir(path2save,datInfo(isubj).name); end
        
%         % Step 13: storing run into ALLEEG
%         ALLEEG = eeg_store(ALLEEG, EEG);
            % Saving data
        % Saving concatenated runs using.set format
        if ~exist(fullfile(path2save,datInfo(isubj).name, 'SET'),'dir'), mkdir(fullfile(path2save,datInfo(isubj).name), 'SET'); end
        pop_saveset(EEG, 'filename', ['ds000117_' datInfo(isubj).name '_run-' num2str(irun) '.set'], 'filepath', fullfile(path2save,datInfo(isubj).name, 'SET'));
        
        %     % Saving MRI anat
        if ~exist(fullfile(path2save,datInfo(isubj).name, 'anat'),'dir'), mkdir(fullfile(path2save,datInfo(isubj).name), 'anat'); end 
        copyfile(fullfile(path2data,datInfo(isubj).name, 'anatomy', 'highres001.nii.gz'),fullfile(path2save,datInfo(isubj).name, 'anat', ['anat_' datInfo(isubj).name '.nii.gz']),'f')
    end
end
    

    

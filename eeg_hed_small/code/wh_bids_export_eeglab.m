% Script to import Wakeman-Henson data to BIDS
% Authors: Ramon Martinez-Cancino SCCN 2020
%          Dung Truong, SCCN 2020
%          Arnaud Delorme, 2020
%
%% Raw data files path
% -----------------------------------------------------|
clear
currentPath = fileparts( which('code_wh_extracteeg_BIDS_HED') );
path2code = currentPath;

% path2data = fullfile(currentPath, 'ds117forbids'); % Arno's path
path2data = fullfile(fileparts(currentPath), 'ds117forbids-HED');

% path2bids = fullfile(currentPath, 'bids_export'); % Arno's path
path2bids      = fullfile(fileparts(currentPath), 'bids_export_with_HED2');

% path2stimfiles = fullfile(currentPath, 'faces_images'); % Arno's path
path2stimfiles = fullfile(fileparts(currentPath), 'faces_images');

subjindx  = 2:19; % range of subject to export
for isubj=1:length(subjindx)
    filenames = {};
    for irun=1:6
        subjfilename = sprintf('sub%3.3d/SET/ds000117_sub%3.3d_run-%d.set', subjindx(isubj), subjindx(isubj), irun);
        filenames{end+1} = fullfile(path2data, subjfilename);
    end    
    subject(isubj).file = filenames;
    subject(isubj).session = [1 1 1 1 1 1];
    subject(isubj).run     = [1 2 3 4 5 6];
    subject(isubj).anat    = fullfile(path2data, sprintf('sub%3.3d/anat/anat_sub%3.3d.nii.gz', subjindx(isubj), subjindx(isubj)));
end

% Anatomical MRI files
anattype     = 'T1w';
defacedflag  = 'on';

% Creating array of stimulus files
tmpfiles = dir(path2stimfiles);
stimfiles = [{tmpfiles(3:end).folder}' {tmpfiles(3:end).name}'];

%% Code Files used to preprocess and import to BIDS
% -----------------------------------------------------|
codefiles = { fullfile(path2code, 'wh_extracteeg_BIDS_HED.m') ...
              fullfile(path2code, 'wh_bids_export_eeglab.m') ...
              fullfile(path2code, 'dInfo.m')};
         
%% General information for dataset_description.json file
% -----------------------------------------------------|
generalInfo.Name = 'Face processing MEEG dataset with HED annotation';
generalInfo.BIDSVersion = 'v1.4.0';
generalInfo.License = 'CC0';
generalInfo.Authors = {'Daniel G. Wakeman', 'Richard N Henson'};
generalInfo.ReferencesAndLinks = {'Wakeman, D., Henson, R. A multi-subject, multi-modal human neuroimaging dataset. Sci Data 2, 150001 (2015). https://doi.org/10.1038/sdata.2015.1'};
generalInfo.Funding = {'This work was supported by the UK Medical Research Council (MC_A060_5PR10) and Elekta Ltd.'};

%% Participant information for participants.tsv file
% -------------------------------------------------|   
%% Subjects missing information in WH BIDS 1.0.0: [4 6 7 13 19]
pInfo = {'participant_id'    'age'  'gender';...
         'sub-002'            31    'M';
         'sub-003'            25    'M';
         'sub-004'            'n/a' 'n/a'   
         'sub-005'            30    'M';
         'sub-006'            'n/a' 'n/a' 
         'sub-007'            'n/a' 'n/a' 
         'sub-008'            23    'F';
         'sub-009'            26    'M';
         'sub-010'            31    'F';
         'sub-011'            26    'M';
         'sub-012'            29    'M';
         'sub-013'            'n/a' 'n/a' 
         'sub-014'            26    'F';
         'sub-015'            23    'M';
         'sub-016'            24    'F';
         'sub-017'            24    'F';
         'sub-018'            25    'F';
         'sub-019'            'n/a' 'n/a' };
     
pInfo = pInfo([1 subjindx], :);
     
%% Participant column description for participants.json file
% ---------------------------------------------------------|
% participant_id
pInfoDesc.participant_id.LongName    = 'Participant identifier';
pInfoDesc.participant_id.Description = 'Unique subject identifier';

% sex
pInfoDesc.gender.Description = 'Sex of the subject';
pInfoDesc.gender.Levels.M    = 'male';
pInfoDesc.gender.Levels.F    = 'female';

% age
pInfoDesc.age.Description = 'Age of the subject';
pInfoDesc.age.Units       = 'years';

     
%% Event column description for xxx-events.json file
% ---------------------------------------------------
eInfo = {'event_type'  'type';
         'face_type'  'face_type';
         'repetition_type' 'repetition_type';
         'trigger'   'trigger';
         'stim_file' 'stim_file'};
     

% Event Onset     
eInfoDesc.onset.Description = 'Onset of the event in seconds relative to the start of the recording.';
eInfoDesc.onset.Units       = 'miliseconds';

% Event Duration     
eInfoDesc.onset.Description = 'Duration of the event in seconds.';
eInfoDesc.onset.Units       = 's';

% Event types
eInfoDesc.event_type.LongName               = 'Event category';
eInfoDesc.event_type.Description            = 'The main category of the event.';
eInfoDesc.event_type.Levels.setup           = 'Mark start of experiment and document applicable metadata.'; 
eInfoDesc.event_type.Levels.('show_cross')  = 'Display only a white cross to mark start of trial and fixation.';
eInfoDesc.event_type.Levels.('show_face')   = 'Display a face to mark end of pre-stimulus and start of blink-inhibition.';
eInfoDesc.event_type.Levels.('show_circle') = 'Display a white circle to mark end of the stimulus and blink inhibition.';
eInfoDesc.event_type.Levels.('left_press')  = 'Experimental participant presses a key with left index finger.';
eInfoDesc.event_type.Levels.('right_press') = 'Experimental participant presses a key with right index finger.';
eInfoDesc.event_type.Levels.('left_sym')    = 'Pressing key with left index finger means a face with above average symmetry.';
eInfoDesc.event_type.Levels.('right_sym')   = 'Pressing key with right index finger means a face with above average symmetry.';
eInfoDesc.event_type.('HED').setup           = 'Experiment-structure, (Def/Initialize-recording, Onset)'; 
eInfoDesc.event_type.('HED').('show_cross')  = 'Sensory-event, (Intended-effect, Cue), (Def/Cross-only, Onset),(Def/Fixation, Onset), (Def/Trial, Onset), (Def/Circle-only, Offset)';
eInfoDesc.event_type.('HED').('show_face')   = 'Sensory-event, Experimental-stimulus, (Def/Face-image, Onset),(Def/Blink-inhibition-task,Onset),(Def/Cross-only, Offset)';
eInfoDesc.event_type.('HED').('show_circle') = 'Sensory-event, (Intended-effect, Cue), (Def/Circle-only, Onset),(Def/Face-image, Offset), (Def/Blink-inhibition-task, Offset),(Def/Fixation-task, Offset)';
eInfoDesc.event_type.('HED').('left_press')  = 'Agent-action, Participant-response, Def/Press-left-finger';
eInfoDesc.event_type.('HED').('right_press') = 'Agent-action, Participant-response, Def/Press-right-finger';
eInfoDesc.event_type.('HED').('left_sym')    = 'Experiment-structure, (Def/Left-sym-cond, Onset)';
eInfoDesc.event_type.('HED').('right_sym')   = 'Experiment-structure, (Def/Right-sym-cond, Onset)';

% Face Type
eInfoDesc.face_type.Description         = 'Factor indicating type of face image being displayed.';
eInfoDesc.face_type.Levels.('famous_face')      = 'A face that should be recognized by the participants.';
eInfoDesc.face_type.Levels.('unfamiliar_face')  = 'A face that should not be recognized by the participants.';
eInfoDesc.face_type.Levels.('scrambled_face')   = 'A scrambled face image generated by taking face 2D FFT.';
eInfoDesc.face_type.('HED').('famous_face')      = 'Def/Famous-face-cond';
eInfoDesc.face_type.('HED').('unfamiliar_face')  = 'Def/Unfamiliar-face-cond';
eInfoDesc.face_type.('HED').('scrambled_face')   = 'Def/Scrambled-face-cond';

% Repetition Type
eInfoDesc.repetition_type.Description         = 'Factor indicating whether this image has been already seen.';
eInfoDesc.repetition_type.Levels.('first_show')      = 'Factor level indicating the first display of this face.';
eInfoDesc.repetition_type.Levels.('immediate_repeat')  = 'Factor level indicating this face was the same as previous one.';
eInfoDesc.repetition_type.Levels.('delayed_repeat')   = 'Factor level indicating face was seen 5 to 15 trials ago.';
eInfoDesc.repetition_type.('HED').('first_show')      = 'Def/First-show-cond';
eInfoDesc.repetition_type.('HED').('immediate_repeat')  = 'Def/Immediate-repeat-cond';
eInfoDesc.repetition_type.('HED').('delayed_repeat')   = 'Def/Delayed-repeat-cond';

% Stim Files
eInfoDesc.stim_file.Description = 'Path of the stimulus file in the stimuli directory.';
eInfoDesc.stim_file.('HED') = '(Image, Path-name/#)';

% HED definitions
eInfoDesc.hed_def_sensory.Description = 'Metadata dictionary for gathering sensory definitions';
eInfoDesc.hed_def_sensory.('HED').('Cross_only_def') = '(Definition/Cross-only, (Visual, (Foreground-view, (White, Cross), (Center-of, Screen)), (Background-view, Black),Description/A white fixation cross on a black background in the center of the screen.))';
eInfoDesc.hed_def_sensory.('HED').('Face_image_def') = '(Definition/Face-image, (Visual, (Foreground-view, ((Image, Face, Hair), Color/Achromatic), ((White, Cross), (Center-of, Screen))), (Background-view, Black), Description/A happy or neutral face in frontal or three-quarters frontal pose with long hair cropped presented as an achromatic foreground image on a black background with a white fixation cross superposed.))';
eInfoDesc.hed_def_sensory.('HED').('Circle_only_def') = '(Definition/Circle-only, (Visual, (Foreground-view, ((White, Circle), (Center-of, Screen))), (Background-view, Black), Description/A white circle on a black background in the center of the screen.))';

eInfoDesc.hed_def_actions.Description = 'Metadata dictionary for gathering participant action definitions';
eInfoDesc.hed_def_actions.('HED').('Press_left_finger_def') = '(Definition/Press-left-finger, (Experimental-participant, (Index-finger, Left-side), (Press, Keyboard-key), Description/The participant presses a key with the left index finger to indicate a face symmetry judgment.))';
eInfoDesc.hed_def_actions.('HED').('Press_right_finger_def') = '((Definition/Press-right-finger, (Experimental-participant, (Index-finger, Right-side), (Press, Keyboard-key), Description/The participant presses a key with the right index finger to indicate a face symmetry evaluation.))';

eInfoDesc.hed_def_conds.Description = 'Metadata dictionary for gathering experimental condition definitions';
eInfoDesc.hed_def_conds.('HED').('Famous_face_cond_def') = '(Definition/Famous-face-cond, (Experimental-condition, Label/Face-type, (Image, (Face, Famous)), Description/A face that should be recognized by the participants))';
eInfoDesc.hed_def_conds.('HED').('Unfamiliar_face_cond_def') = '(Definition/Unfamiliar-face-cond, (Experimental-condition, Label/Face-type, (Image, (Face, Unfamiliar)), Description/A face that should not be recognized by the participants.))';
eInfoDesc.hed_def_conds.('HED').('Scrambled_face_cond_def') = '(Definition/Scrambled-face-cond, (Experimental-condition,Label/Face-type, (Image, (Face, Disordered)), Description/A scrambled face image generated by taking face 2D FFT.))';
eInfoDesc.hed_def_conds.('HED').('First_show_cond_def') = '(Definition/First-show-cond, (Experimental-condition, Label/Repetition-type, (First-item, Repetition/1), Description/Factor level indicating the first display of this face.))';
eInfoDesc.hed_def_conds.('HED').('Immediate_repeat_cond_def') = '(Definition/Immediate-repeat-cond, (Experimental-condition,Label/Repetition-type, (Next-item, Repetition/2), Description/Factor level indicating this face was the same as previous one.))';
eInfoDesc.hed_def_conds.('HED').('Delayed_repeat_cond_def') = '(Definition/Delayed-repeat-cond, (Experimental-condition, Label/Repetition-type, (Later-item, Repetition/2), Description/Factor level indicating face was seen 5 to 15 trials ago.))';
eInfoDesc.hed_def_conds.('HED').('Left_sym_cond_def') = '(Definition/Left-sym-cond, (Experimental-condition, Label/Key-assignment, ((Button, Left-side), Symmetric), ((Button, Right-side), Asymmetric),Description/Left finger key press means above average symmetry.))';
eInfoDesc.hed_def_conds.('HED').('Right_sym_cond_def') = '(Definition/Right-sym-cond, (Experimental-condition, Label/Key-assignment, ((Button, Right-side), (Behavioral-evidence, Symmetric)), ((Button, Left-side), (Behavioral-evidence, Asymmetric)), Description/Right finger key press means above average symmetry.))';

eInfoDesc.hed_def_tasks.Description = 'Metadata dictionary for gathering task definitions';
eInfoDesc.hed_def_tasks.('HED').('Face_symmetry_evaluation_task_def') = '(Definition/Face-symmetry-evaluation-task, (Task, Experimental-participant, (Look, Face), (Discriminate, (Face, Symmetric)),(Press, Keyboard-key), Description/Evaluate degree of image symmetry and respond with key press evaluation.))';
eInfoDesc.hed_def_tasks.('HED').('Blink_inhibition_task_def') = '(Definition/Blink-inhibition-task, (Task, Experimental-participant, Inhibit-blinks, Description/Don’t blink while the face image is displayed.))';
eInfoDesc.hed_def_tasks.('HED').('Fixation_task_def') = '(Definition/Fixation-task, (Task, Experimental-participant, (Fixate, Cross), Description/Fixate on the cross at the screen center.))';
eInfoDesc.hed_def_tasks.('HED').('Face_novelty_detection_task_def') = '(Definition/Face-novelty-detection-task, ((Task, Implicit), Experimental-participant, (Look, Face), (Detect, (Face, Novel)), Description/Recognize presentations of previously unseen face images-implicit task.))';

eInfoDesc.hed_def_setup.Description = 'Metadata dictionary for gathering setup definitions';
eInfoDesc.hed_def_setup.('HED').('Initialize_recording_def') = '(Definition/Initialize-recording, (Description/Stuff and setup stuff.))';

% Event values
eInfoDesc.value.Description = 'Numerical event marker';
eInfoDesc.value.Levels.x0   = 'Disappearance of face image and display of the interstimulus circle simultaneously';
eInfoDesc.value.Levels.x5   = 'Initial presentation of famous face';
eInfoDesc.value.Levels.x6   = 'Immediate repeated  presentation of famous face';
eInfoDesc.value.Levels.x7   = 'Delayed repeated  presentation of famous face';

eInfoDesc.value.Levels.x13   = 'Initial presentation of unfamiliar face';
eInfoDesc.value.Levels.x14   = 'Immediate repeated  presentation of unfamiliar face';
eInfoDesc.value.Levels.x15   = 'Delayed repeated  presentation of unfamiliar face';

eInfoDesc.value.Levels.x17   = 'Initial presentation of scrambled face';
eInfoDesc.value.Levels.x18   = 'Immediate repeated  presentation of scrambled face';
eInfoDesc.value.Levels.x19   = 'Delayed repeated  presentation of scrambled face';

eInfoDesc.value.Levels.x256    = 'Left button press';
eInfoDesc.value.Levels.x4096   = 'Right button press';

%% Content for README file
% ------------------------
README = [ 'Multi-subject, multi-modal (sMRI+EEG) neuroimaging dataset' 10 ...
           'on face processing. Original data described at https://www.nature.com/articles/sdata20151' 10 ...
           'This is repackaged version of the EEG data in EEGLAB format. The data has gone through' 10 ...
           'minimal preprocessing including (see wh_extracteeg_BIDS.m):' 10 ...
           '- Ignoring fMRI and MEG data (sMRI preserved for EEG source localization)' 10 ...
           '- Extracting EEG channels out of the MEG/EEG fif data' 10 ...
           '- Adding fiducials' 10 ...
           '- Renaming EOG and EKG channels' 10 ...
           '- Extracting events from event channel' 10 ...
           '- Removing spurious events 5, 6, 7, 13, 14, 15, 17, 18 and 19' 10 ...
           '- Removing spurious event 24 for subject 3 run 4' 10 ...
           '- Renaming events taking into account button assigned to each subject' 10 ...
           '- Correcting event latencies (events have a shift of 34 ms)' 10 ...
           '- Resampling data to 250 Hz (this is a step that is done because' 10 ...
           '  this dataset is used as tutorial for EEGLAB and need to be lightweight' 10 ...
           '- Merging run 1 to 6' 10 ...
           '- Removing event fields urevent and duration ' 10 ...
           '- Filling up empty fields for events boundary and stim_file.' 10 ...
           '- Saving as EEGLAB .set format' 10 10  ...
           'Ramon Martinez, Dung Truong, Kay Robbins, Scott Makeig, Arnaud Delorme (UCSD, La Jolla, CA, USA)' 10 ...
           ];

%% Content for CHANGES file
% ------------------------
CHANGES = sprintf([ 'Revision history for Face Recognition experiment by Wakeman-Henson\n\n' ...
                    'version 1.0 - April 2021\n' ...
                    ' - Initial release of EEG data in this experiment for HED education purposes \n' ...
                    '\n'
                    ]);

% ---------------------------------------|
tInfo.TaskName = 'FacePerception';
tInfo.TaskDescription = sprintf(['Subjects viewed stimuli on a screen during six, 7.5 minute runs. The stimuli were photographs ' ...
                                 'of either a famous face (known to most of British or a scrambled face, and appeared for a random duration between 800 and 1,000 ms. ' ...
                                 'Subjects were instructed to fixate centrally throughout the experiment. To ensure attention to each ' ...
                                 'stimulus, participants were asked to press one of two keys with either their left or right index ' ...
                                 'finger (assignment counter-balanced across participants). Their key-press was based on how symmetric ' ...
                                 'they regarded each image: pressing one or the other key depending whether they thought the image was ' ...
                                 '''more'' or ''less symmetric'' than average.']);
tInfo.InstitutionAddress = '15 Chaucer Road, Cambridge, UK';
tInfo.InstitutionName = 'MRC Cognition & Brain Sciences Unit';

% EEG-specific fields
% ---------------------------------------|
tInfo.EEGReference = 'nose';
tInfo.EEGGround = 'left collar bone';
tInfo.SamplingFrequency = 1100;
tInfo.PowerLineFrequency = 50; 
tInfo.SoftwareFilters = struct('LowPassFilter', struct ('cutoff', '350 (Hz)'));
tInfo.EEGPlacementScheme = 'extended 10-10% system';
tInfo.CapManufacturer = 'Easycap';
tInfo.EEGChannelCount = 70; 
tInfo.EOGChannelCount = 2; 
tInfo.RecordingType = 'continuous';

% call to the export function
% ---------------------------
bids_export(subject, 'targetdir', path2bids, 'eInfo', eInfo, 'taskName', tInfo.TaskName, 'gInfo', generalInfo, 'pInfo', pInfo, 'pInfoDesc', pInfoDesc, 'eInfoDesc', eInfoDesc, 'README', README, 'CHANGES', CHANGES,'tInfo', tInfo,'codefiles',codefiles,'defaced', defacedflag,'anattype', anattype, 'copydata', 1);
copyfile(path2stimfiles, fullfile(path2bids, 'stimuli'));

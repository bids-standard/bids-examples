% MATLAB SCRIPT FOR THE AUTOMATICITY TEST
% A dual-task paradigm in which we test whether a 12 digit prelearned
% sequence (sequenceauto) has become an automatic movement for a finger
% tapping and a foot stomping task.

%Before starting the automaticity test, clear the workspace.
clear all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ZMQ & LSL
% raspberry names
zmq_proxy='lsldert00.local';
% lsl_hosts={'lsldert00', 'lsldert04', 'lsldert05'};
lsl_hosts={'lsldert00', 'lsldert04'};

% add lsl streams
trigstr=cell(1);
nstr=0;
for ii=1:numel(lsl_hosts)
    host=lsl_hosts{ii};
    info_type=sprintf('type=''Digital Triggers @ %s''',host);
    info=lsl_resolver(info_type);
    desc=info.list();
    if isempty(desc)
        warning('lsl stream on host ''%s'' not found', host);
    else
        nstr=nstr+1;
        fprintf('%d: name: ''%s'' type: ''%s''\n',nstr,desc(1).name,desc(1).type);
        trigstr{nstr}=lsl_istream(info{1});
    end
    delete(info);
end
trig = lsldert_pubclient(zmq_proxy);
cleanupObj=onCleanup(@()cleanupFun);

% create session
ses=lsl_session();
for ii=1:nstr
    ses.add_stream(trigstr{ii});
end

% add listener
for ii=1:nstr
    addlistener(trigstr{ii}, 'DataAvailable', @triglistener);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INITIALISATION
% start lsl session
ses.start();
trig.digitalout(0, 'TTL_init'); % ensures that the output is set to 0
trig.pulseIR(3, 0.2); % start trigger for the nirs recording

%Open Phsychtoolbox.
PsychDefaultSetup(2);
KbName('UnifyKeyNames'); %Links the key presses to the key board names
KbQueueCreate;
KbQueueStart; 

%Skip screen synchronization to prevent Pyshtoolbox for freezing
Screen('Preference', 'SkipSyncTests', 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LOAD METRONOME SOUNDS (PsychToolbox)
audio_dir='C:\Users\Helena\Documents\Experiment_ME\metronomesounds';
cd(audio_dir)
[WAVMetronome8.wave,WAVMetronome8.fs]       = audioread('Metronome8.wav');

% change rows<>columns
WAVMetronome8.wave = WAVMetronome8.wave';         WAVMetronome8.nrChan=2;

% CREATE AND FILL AUDIO BUFFER
% Initialize Sounddriver
% This routine loads the PsychPortAudio sound driver for high precision, low latency,
% multichannel sound playback and recording
% Call it at the beginning of your experiment script, optionally providing the
% 'reallyneedlowlatency'-flag set to 1 to push really hard for low latency
InitializePsychSound(1);

priority = 0;                       % 0 = better quality, increased latency; 1 = minimum latency
duration = 1;                       % number of repetitions of the wav-file
PsychPortAudio('Verbosity',1);      % verbosity = "wordiness" -> 1= print errors

% Get audio device
h_device = PsychPortAudio ('GetDevices');

% Open handle
h_Metronome8   = PsychPortAudio('Open', [], [], priority, WAVMetronome8.fs, WAVMetronome8.nrChan);

% Fill buffer
PsychPortAudio('FillBuffer', h_Metronome8, WAVMetronome8.wave);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SAVE FILES IN FOLDER

fprintf('Select the project directory \n')
root_dir=uigetdir('C:\Users\Helena\Documents\Data_ME\', 'Select the project directory');

complete=0;
while complete==0
    sub_ID=input('What is the subject ID (2 digit number) \n', 's');
    sub=sprintf('sub-%s', sub_ID);
        rec_n=input('What is the number of the recording? \n');
        rec=sprintf('rec-%.2d', rec_n);

    inf=fprintf('\n root_dir = %s \n sub = %s \n rec = %s \n', root_dir, sub, rec);
    correct=input('Is the above information correct? (y/n) \n', 's');
    if strcmp(correct, 'y')
        complete=1;
    else
        continue
    end
end

% go to subject folder
sub_dir=fullfile(root_dir, sub);
if ~exist(sub_dir)
    mkdir(sub_dir)
end
cd(sub_dir)

logname=sprintf('%s_%s_triggers.log', sub, rec); diary(logname);
% save current script in subject directory
script=mfilename('fullpath');
script_name=mfilename;
copyfile(sprintf('%s.m', script), fullfile(sub_dir, sprintf('%s_%s.m', sub, script_name)))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SET UP PARAMETERS

%The sequences used for this study (automatic and non-automatic sequences
%randomized between participants)
sequenceA = '4 3 4 1 4 1 2 4 3 2 1 2';
sequenceB = '2 1 2 3 2 1 3 2 4 2 4 1';
%Sequences used in order to be able to print in the command window if
%sequences performed by the participant were right (see also end of script)
sequenceprintA = {'BackSpace','6','BackSpace','4','BackSpace','4','5','BackSpace','6','5','4','5'};
sequenceprintB = {'5','4','5','6','5','4','6','5','BackSpace','5','BackSpace','4'};

%Parameters for the resting period in between the trials
t1 = 20; %Resting period in seconds
t2 = 5;  %Random interval around the resting period time

%Amount of letters presented during test for automaticity for one trial.
%Should be adjusted when letter presenting speed is changed!
N_letters=8; % 8 letters presented during a trial
N_trials=11; % number of trials performed for each limb

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANDOMIZATION

%Set the right sequence that was studied at home (= automatic)
sequenceauto = sequenceB;
sequenceautoprint = sequenceprintB;

%Create a vector to represent the two different options (1=finger tapping
%test, 2= foot stomping test). This order is randomized between
%participants
order_autodual=[2,1];
%Save the order of the automaticity test experiment
%save('order_autodual.mat', 'order_autodual');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCREEN PREPARATION

% Get the screen numbers.
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Preparations for the fixation cross so we only need to do this once
fixCrossDimPix = 40; % Here we set the size of the arms of our fixation cross
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0]; % Set the coordinates (these are all relative to zero we will let the drawing routine center the cross in the center of our monitor for us)
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];
lineWidthPix = 4;% Set the line width for the fixation cross

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START TEST FOR AUTOMATICITY

%Empty structure for key presses, -> use later again so it saves the key
%presses within this structure -> save at the end
events_handautodual=struct([]); % same for the presented letters of the hand + the answer
events_footautodual=struct([]); % same for the presented letters of the foot + the answer

%Instruction automaticity test
Screen('TextSize',window,25);
DrawFormattedText(window,'You will now start with the automaticity test. \n You will either start with the finger tapping or foot stomping task. \n Detailed instructions will be given at the start of each task. \n Press any key to continue.','center', 'center', white);
vbl = Screen('Flip', window);
KbStrokeWait; %wait for response to terminate instructions

%Start the randomization loop
for i=order_autodual; %Either [1,2] or [2,1] -> determines the order of the tasks
    
    % Finger tapping test -> 11 trials, dual task, in which a participant
    % taps a prelearned sequence, while also letters are presented on the
    % screen in a randomized speed
    if i==1;
        %Instruction automaticity task finger tapping
        trig.beep(440, 0.2, 'instructions');
        Screen('TextSize',window,25);
        DrawFormattedText(window, sprintf('You will now perform the pre-learned sequence for the FINGER tapping task: \n %s \n\n  While you perform the task, letters will be shown on the screen (C,G,O,Q). \n In between each letter a red fixation cross will appear shortly. \n The goal is to perform the sequence tapping while counting how many times G is presented. \n After each time you tapped the full sequence, you should tell us how many times G was presented. \n For answering this question, keep in mind that \n you press the right key on your keyboard according to your answer (not the number of the sequence!). \n\n We will perform 11 trails. \n For each trial you perform the sequence once. \n Note that during the tapping task you cannot talk. \n Try to keep your body movements as still as possible exept for the right hand. \n Keep your eyes open (also during the rest periods). \n\n In between the trials you will see a white fixation cross for 20 seconds. \n During the first few seconds you will hear a metronome sound. \n Tap the sequence on this rhythm, which is the same as you studied at home. \n\n We will start with a white fixation cross on the screen for 20 seconds. \n After that the first trial will start automatically. \n So start tapping the sequence as soon as a RED fixation cross appears on the screen. \n When ready: press any key to continue and start the test.', sequenceauto),'center','center', white);
        vbl = Screen('Flip', window);
        KbStrokeWait; %wait for response to terminate instructions
        
        %Start loop for the trials
        for j=1:N_trials;
            %Presentation of the letters on the screen (dual task). -> is random.
            %Participant has to count the amount that G was presented.
            Letterlist='CGOQ';
            letter_order=randi(length(Letterlist), 1, N_letters);
            value={Letterlist(letter_order)};
            
            %Always start with a 20-25 seconds fixation cross with 8 seconds of metronome
            %sound
            trig.beep(440, 0.2, 'rest');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            PsychPortAudio('Start', h_Metronome8, 1, [], []); % Play metronome sound file (8 seconds)
            WaitSecs(t1+randi(t2));
            
            %Presentation of random letters on the screen during the finger
            %tapping test + recording of the key presses
            trig.beep(440, 0.2, 'finger_auto_dual');
            onset=GetSecs;
            %preallocate table with key presses
            keypresses=table('Size', [12, 3], 'VariableNames', {'onset', 'duration', 'value'}, 'VariableTypes', {'double', 'double', 'cell'});
            m=1; %first key press
            KbQueueFlush; % clear all previous key presses from the list
            %Start loop for letter presenting during a trial
            for n=1:N_letters;
                %Between each letter show a red fixation cross
                Screen('DrawLines', window, allCoords,...
                  lineWidthPix, [1 0 0], [xCenter yCenter], 2);
                vbl = Screen('Flip', window);
                time_cross=rand(1)+0.5; %Speed with which the letters are presented
                
                %Meanwhile record key presses
                start_timer=GetSecs;
                while GetSecs-start_timer<time_cross
                    [ pressed, firstPress, ~, lastPress, ~]=KbQueueCheck;
                    if m<13 && GetSecs-start_timer<time_cross && pressed %not more than 12 keys can be saved
                        if isempty(find(firstPress~=lastPress)) % no key was pressed twice
                            keys=KbName(find(firstPress)); % find the pressed keys
                            [timing, idx]=sort(firstPress(find(firstPress))); % get timing of key presses in ascending order
                            if length(idx)>1
                                keys=keys(idx); % sort the pressed keys in ascending order
                            else
                                keys={keys};
                                key_n=length(keys); % number of pressed keys
                            end
                            for q=1:key_n
                                keypresses.onset(m)=timing(q); %store and record the timing
                                keypresses.value(m)=keys(q);  %store and record the presses
                                m=m+1;
                                if m>12
                                    break
                                end
                            end
                        else
                            error('key was pressed twice')
                        end
                    end
                end
                
                %Present random letter on the screen
                Screen('TextSize', window, 100);
                DrawFormattedText(window, value{1}(n),'center','center', white);
                Screen('Flip', window);
                WaitSecs (0.2);
            end
            
            %Present white fixation cross for some seconds to show that
            %trial is over
            duration=GetSecs-onset;
            trig.beep(440, 0.2, 'rest');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            WaitSecs(5); % 5 seconds, so the nirs signal has time to go back to baseline
            
            %Ask how many G's were presented
            Screen('TextSize',window,30);
            DrawFormattedText(window, 'How many times was G presented? ','center','center', white);
            vbl = Screen('Flip', window);
            [secs, keyCode, deltaSecs]=KbWait;
            % save the response and the key presses
            response={KbName(find(keyCode))};
            events_handautodual(j).stimuli=table(onset,duration, value, response);
            events_handautodual(j).responses=keypresses;
            DrawFormattedText(window, ['Your answer: ' response{1} '\n Press any key to continue.'],'center','center', white);
            vbl = Screen('Flip', window);
            KbStrokeWait;
            DrawFormattedText(window, 'Press any key to continue with the next trail. \n Note that you will first start with a fixation cross again. \n Start tapping the sequence as soon as a RED fixation cross appears on the screen.' ,'center','center', white);
            vbl = Screen('Flip', window);
            KbStrokeWait;
        end
        
        %After all trials completed, the end of the finger tapping task is
        %reached
        Screen('TextSize',window,30);
        DrawFormattedText(window, 'This is the end of the automaticity test for the finger tapping task. \n You can take a rest if needed. \n When ready: press any key to end this session.' ,'center','center', white);
        vbl = Screen('Flip', window);
        save('events_handautodual.mat', 'events_handautodual'); % save the events
        KbStrokeWait; %wait for response to terminate instructions
        
        
        % Foot stomping test -> 11 trials, dual task, in which a participant
        % stomps a prelearned sequence, while also letters are presented on the
        % screen in a randomized speed
    elseif i==2;
        % Instruction automaticity task foot stomping
        trig.beep(440, 0.2, 'instructions');
        Screen('TextSize',window,25);
        DrawFormattedText(window, sprintf('You will now perform the pre-learned sequence for the FOOT stomping task: \n %s \n\n While you perform the task, letters will be shown on the screen (C,G,O,Q). \n In between each letter a red fixation cross will appear shortly. \n The goal is to perform the sequence stomping while counting how many times G is presented. \n After each time you stomped the full sequence, you should tell us how many times G was presented. \n For answering this question, keep in mind that \n you press the right key on your keyboard according to your answer (not the number of the sequence!). \n\n We will perform 11 trials. \n For each trial you perform the sequence once. \n Note that during the stomping task you cannot talk. \n Try to keep your body movements as still as possible exept for your right leg. \n Keep your eyes open (also during the rest periods). \n\n In between the trials you will see a fixation cross for 20 seconds. \n During the first few seconds you will hear a metronome sound. \n Stomp the sequence on this rhythm, which is the same as you studied at home. \n\n We will start with a fixation cross on the screen for 20 seconds. \n After that the first trial will start automatically. \n So start stomping the sequence as soon as a RED fixation cross appears on the screen. \n When ready: press any key to continue and start the test.', sequenceauto),'center','center', white);
        vbl = Screen('Flip', window);
        KbStrokeWait; %wait for response to terminate instructions
        
        trig.digitalout(1, 'start_rec'); % starts the recording of xsens
        %Start loop for the trials
        for j=1:N_trials;
            %Presentation of the letters on the screen (dual task). -> is random.
            %Participant has to count the amount that G was presented.
            Letterlist= 'CGOQ';
            letter_order=randi(length(Letterlist), 1, N_letters);
            value={Letterlist(letter_order)};
            
            %Always start with a 20-25 seconds fixation cross with 8 seconds of metronome
            %sound
            trig.beep(440, 0.2, 'rest');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            PsychPortAudio('Start', h_Metronome8, 1, [], []); % Play metronome sound file (8 seconds)
            WaitSecs(t1+randi(t2));
            
            %Presentation of random letters on the screen during the foot
            %stomping test
            trig.beep(880, 0.2, 'foot_auto_dual');
            onset=GetSecs;
            %Start loop for letter presenting during a trial
            for n=1:N_letters;
                %Present a red fixation cross in between the letters
                Screen('DrawLines', window, allCoords,...
                    lineWidthPix, [1 0 0], [xCenter yCenter], 2);
                Screen('Flip', window);
                time_letter=rand(1)+0.5; %Speed with which the letters are presented
                WaitSecs(time_letter);
                
                %Present a random letter
                Screen('TextSize', window, 100);
                DrawFormattedText(window, value{1}(n),'center','center', white);
                vbl = Screen('Flip', window);
                WaitSecs (0.2);
            end
            
            % Present white fixation cross for some seconds to show that
            % trial is over
            duration=GetSecs-onset;
            trig.beep(440, 0.2, 'rest');
            Screen('TextSize', window, 36);
            Screen('DrawLines', window, allCoords,...
                lineWidthPix, white, [xCenter yCenter], 2);
            Screen('Flip', window);
            WaitSecs(5); % 5 seconds, so the nirs signal has time to go back to baseline
            
            % Ask how many G's were presented
            Screen('TextSize',window,30);
            DrawFormattedText(window, 'How many times was G presented? ','center','center', white);
            vbl = Screen('Flip', window);
            [secs, keyCode, deltaSecs]=KbWait;
            % save the response and the key presses
            response={KbName(find(keyCode))};
            events_footautodual(j).stimuli=table(onset,duration, value, response);
            DrawFormattedText(window, ['Your answer: ' response{1} '\n Press any key to continue.'],'center','center', white);
            vbl = Screen('Flip', window);
            KbStrokeWait; %wait for response to terminate instruction
            DrawFormattedText(window, 'Press any key to continue with the next trail. \n Note that you will first start with a fixation cross again. \n Start tapping the sequence as soon as a RED fixation cross appears on the screen.' ,'center','center', white);
            vbl = Screen('Flip', window);
            KbStrokeWait;
        end
        
        % After all trials completed, the end of the foot stomping task is reached.
        trig.digitalout(0, 'stop_rec'); % stops the recording of xsens
        Screen('TextSize',window,25);
        DrawFormattedText(window, 'End of the automaticity test for the foot stomping task. \n You can take a rest if needed. \n When ready: press any key to end this session.','center','center', white);
        vbl = Screen('Flip', window);
        save('events_footautodual.mat', 'events_footautodual'); % save the letters that were presented and the reported number of g's
        KbStrokeWait; %wait for response to terminate instructions
    end
end

%Show dual task performance in command window (finger tapping)
fprintf('Finger AutoDual \n')
for h = 1:N_trials
    fprintf('Trial %d: \n', h)
    %Show if the answers for the number of G's presented were correct
    if str2num(events_handautodual(h).stimuli.response{1})==length(strfind(events_handautodual(h).stimuli.value{1}, 'G'))
        fprintf('G correct \n')
    else
        fprintf('G incorrect \n')
    end
    %Show if the tapping tempo was correct.
    margin=0.25; % margin of error: think about what is most convenient
    delay=mean(diff(events_handautodual(h).responses.onset)-1/1.50);
    fprintf('the tempo was off with on average %f seconds \n', delay);
    %Show if the tapped sequence was correct
    if all(strcmp(events_handautodual(h).responses.value,sequenceautoprint'))
        fprintf('Seq correct \n')
    else
        fprintf('Seq incorrect \n')
    end
    
end

%Show dual task performance in command window (foot stomping)
fprintf('Foot AutoDual \n')
for g = 1:N_trials
    fprintf('Trial %d: \n', g)
    %Show if the answers for the number of G's presented were correct
    if str2num(events_footautodual(g).stimuli.response{1})==length(strfind(events_footautodual(g).stimuli.value{1}, 'G'))
        fprintf('G correct \n')
    else
        fprintf('G incorrect \n')
    end
end

% End of automaticity test is reached (both limbs are tested)
Screen('TextSize',window,25);
DrawFormattedText(window,'You have completed the automaticity test. \n We will continue with the rest of the experiment. \n Press any key to end this session.','center', 'center', white);
vbl = Screen('Flip', window);
%Press key to end the session and return to the 'normal' screen.
KbStrokeWait;
sca

%% end the lsl session
trig.pulseIR(3, 0.2); % stop trigger for the nirs recording
delete(trig);
ses.stop();
diary off;

%% HELPER FUNCTIONS
function triglistener(src, event)
for ii=1:numel(event.Data)
  info=src.info;
  fprintf('   lsl event (%s) received @ %s with (uncorrected) timestamp %.3f \n',  event.Data{ii}, info.type, event.Timestamps(ii));
end
end

function cleanupFun()
delete(ses);
delete(trigstr{1});
delete(trigstr{2});
delete(info);
end

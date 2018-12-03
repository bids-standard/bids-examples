% Mind Wandering Experiment
% Arnaud Delorme - Jan 20th, 2014

expeDuration = 1800; % duraction of experiment in seconds
nextDuration = 15;    % 5 second min after previous question
minDuration  = 150;   % 60 second range for question
portFlag     = true;

disp('Trigger 1  (bit 1) is MW level 1');
disp('Trigger 2  (bit 2) is MW level 2');
disp('Trigger 4  (bit 3) is MW level 3');
disp('Trigger 8  (bit 4) is to indicate unvolary button press');
disp(' ');
mode = 'p'; %input('Do you want to collect data in spontaneous or probe mode (press s or p)?', 's');
if ~strcmpi(mode, 's') && ~strcmpi(mode, 'p'), error('Mode can only be "s" or "p"'); end;
s = input('HAVE YOU STARTED THE EEG RECORDING YET (press enter when ready)?');
if ~isempty(s), return; end;

% get name of subject to generate sequence
% ----------------------------------------
name = input('Enter the name of the subject:', 's');
if portFlag
    parport = digitalio('parallel','LPT1');
    addline(parport, 0:7, 'out');
    putvalue(parport.Line(1:8), 0);
end;

% file name to save info
% ----------------------
filename = [ name '_info.txt'];
if exist(filename)
    name = input('File exsist, do you want to remove it (y/n):', 's');
    if name(1) ~= 'y', disp('Abording'); return; end;
end;
fid = fopen(filename, 'w');
if fid == -1
    error('Cannot open output file');
end;

% read wav files
% --------------
[voice_rate_mw    fs]=wavread('rate_mw.wav'); 
[voice_rate_med   fs]=wavread('rate_meditation.wav');
[voice_rate_tired fs]=wavread('rate_tired.wav');
[voice_expe_over  fs]=wavread('expe_over.wav');
[voice_mw         fs]=wavread('mind_wandering.wav');
[voice_self       fs]=wavread('self.wav');
[voice_time       fs]=wavread('time.wav');
[voice_valence    fs]=wavread('valence.wav');
[voice_depth      fs]=wavread('depth.wav');
[voice_resume     fs]=wavread('resume.wav');
[voice_resumed    fs]=wavread('resumed.wav');
[voice_resumemed  fs]=wavread('resumemed.wav');
[voice_cancel     fs]=wavread('cancel.wav');
[voice_starting   fs]=wavread('starting.wav');

voice_rate_mw    = [ voice_rate_mw; zeros(1000,2)    ];
voice_rate_med   = [ voice_rate_med; zeros(1000,2)   ];
voice_rate_tired = [ voice_rate_tired; zeros(1000,2) ];
voice_expe_over  = [ voice_expe_over; zeros(1000,2)  ];
voice_mw         = [ voice_mw; zeros(1000,2)      ];
voice_self       = [ voice_self; zeros(1000,2)    ];
voice_time       = [ voice_time; zeros(1000,2)    ];
voice_valence    = [ voice_valence; zeros(1000,2) ];
voice_depth      = [ voice_depth; zeros(1000,2)   ];
voice_resume     = [ voice_resume; zeros(1000,2)   ];
voice_resumed    = [ voice_resumed; zeros(1000,2)   ];
voice_resumemed  = [ voice_resumemed; zeros(1000,2)   ];
voice_cancel     = [ voice_cancel; zeros(1000,2)   ];
voice_starting   = [ voice_starting; zeros(1000,2)   ];

tic;
count = 1;
KbCheck;
currentTime  = toc;
lastPressBut = toc;
lastPressKey = '';
nextQuestionTime = currentTime+minDuration+round(rand(1)*nextDuration);
pause(0.5);
status = 0;
sound(voice_starting/1.2,fs);
while currentTime < expeDuration
    
    % wait for key press
    currentTime = toc;
    [keyIsDown, secs, keyCode] = KbCheck;
    cc=KbName(keyCode);  %translate code into letter (string)
    if ~isempty(cc) && ~iscell(cc) && (toc-lastPressBut > 0.5 || ~isequal(cc, lastPressKey))
        
        % send code the parallel port
        keynum = str2num(cc(1));
        if portFlag && ~isempty(keynum) && status ~= 0
            putvalue(parport.Line(keynum+1), 1);
            WaitSecs(0.001);
            putvalue(parport.Line(keynum+1), 0);
        end;
        
        fprintf('Key %s (code %d) pressed at time %5.1f seconds, status %d\n', cc, keynum, toc, status);
        fprintf(fid, 'Key %s (code %d) pressed at time %5.1f seconds, status %d\n', cc, keynum, toc, status);
        lastPressKey = cc;
        lastPressBut = toc;
        nextQuestionTime = currentTime+minDuration+round(rand(1)*nextDuration);
        
        if cc(1) ~= '0' && cc(1) ~= '1' && cc(1) ~= '2' && cc(1) ~= '3'
            if status > 1
                sound(voice_cancel/1.1,fs);
            end;
            if status == 0 && (mode == 'p' || mode == 'P')
                disp('Button press not authorized');
            else
                sound(voice_resumemed/1.51,fs);
            end;
            disp('Canceled');
            status = 0;
            % cancel
        else
            if status <= 1
                if status == 0 && (mode == 'p' || mode == 'P')
                    disp('Button press not authorized');
                else
                    status = 2;
                    sound(voice_rate_mw,fs);
                end;
            elseif status == 2
                status = 3;
                sound(voice_rate_tired,fs);
            elseif status == 3
                status = 0;
                sound(voice_resumemed/1.5,fs);
            end;
        end;
    elseif ~isequal(cc, lastPressKey)
        lastPressKey = cc;
    end;

    % nextQuestionTime reached
    if currentTime > nextQuestionTime && (mode == 'p' || mode == 'P')
        if status == 0
            if portFlag
                putvalue(parport.Line(8), 1);
                WaitSecs(0.001);
                putvalue(parport.Line(8), 0);
                pause(0.050);
            end;
            fprintf(fid, 'MW question asked at time %5.1f second\n', toc);
            fprintf('MW question asked at time %5.1f second\n', toc);
            sound(voice_rate_med,fs);
            status = 1;
        end;
        nextQuestionTime = currentTime+minDuration+round(rand(1)*nextDuration);
    end;
       
    % user abord
    if any(strcmpi(cc,'escape')) || any(strcmpi(cc,'esc'))
        disp('');
        fclose all;
        error('User abord');
    end;
end;
fclose(fid);
disp('The experiment is now over');
sound(voice_expe_over,fs);


function eeg_init(inbdffiles,outsetfile)

%loop through inbdffiles
for i=1:length(inbdffiles);
    %import bdf file
    ALLEEG(i) = pop_biosig(inbdffiles{i}, 'channels', 1:128 );
    
    %resample to 512
    ALLEEG(i) = pop_resample( ALLEEG(i), 512);
end

%merge files
EEG = pop_mergeset( ALLEEG, 1:length(ALLEEG), 0);

%load average BUCANL BioSemi head channel coordinates
EEG=pop_chanedit(EEG, 'load',{'sourcedata/misc/BioSemi_BUCANL_EEGLAB.sfp' 'filetype' 'autodetect'});

%rename events
for i=1:length(EEG.event);
    if isnumeric(EEG.event(i).type);
        EEG.event(i).type=num2str(EEG.event(i).type);
    end
    if strcmp(EEG.event(i).type,'11');
        EEG.event(i).type='house-upright-f1';
    elseif strcmp(EEG.event(i).type,'12');
        EEG.event(i).type='house-upright-f2';
    elseif strcmp(EEG.event(i).type,'13');
        EEG.event(i).type='house-upright-f3';
    elseif strcmp(EEG.event(i).type,'14');
        EEG.event(i).type='house-upright-f4';
    elseif strcmp(EEG.event(i).type,'15');
        EEG.event(i).type='house-upright-f5';
    elseif strcmp(EEG.event(i).type,'16');
        EEG.event(i).type='house-upright-f6';
    elseif strcmp(EEG.event(i).type,'21');
        EEG.event(i).type='house-inverted-f1';
    elseif strcmp(EEG.event(i).type,'22');
        EEG.event(i).type='house-inverted-f2';
    elseif strcmp(EEG.event(i).type,'23');
        EEG.event(i).type='house-inverted-f3';
    elseif strcmp(EEG.event(i).type,'24');
        EEG.event(i).type='house-inverted-f4';
    elseif strcmp(EEG.event(i).type,'25');
        EEG.event(i).type='house-inverted-f5';
    elseif strcmp(EEG.event(i).type,'26');
        EEG.event(i).type='house-inverted-f6';
    elseif strcmp(EEG.event(i).type,'31');
        EEG.event(i).type='face-upright-f1';
    elseif strcmp(EEG.event(i).type,'32');
        EEG.event(i).type='face-upright-f2';
    elseif strcmp(EEG.event(i).type,'33');
        EEG.event(i).type='face-upright-f3';
    elseif strcmp(EEG.event(i).type,'34');
        EEG.event(i).type='face-upright-f4';
    elseif strcmp(EEG.event(i).type,'35');
        EEG.event(i).type='face-upright-f5';
    elseif strcmp(EEG.event(i).type,'36');
        EEG.event(i).type='face-upright-f6';
    elseif strcmp(EEG.event(i).type,'41');
        EEG.event(i).type='face-inverted-f1';
    elseif strcmp(EEG.event(i).type,'42');
        EEG.event(i).type='face-inverted-f2';
    elseif strcmp(EEG.event(i).type,'43');
        EEG.event(i).type='face-inverted-f3';
    elseif strcmp(EEG.event(i).type,'44');
        EEG.event(i).type='face-inverted-f4';
    elseif strcmp(EEG.event(i).type,'45');
        EEG.event(i).type='face-inverted-f5';
    elseif strcmp(EEG.event(i).type,'46');
        EEG.event(i).type='face-inverted-f6';
    elseif strcmp(EEG.event(i).type,'51');
        EEG.event(i).type='checker-f1';
    elseif strcmp(EEG.event(i).type,'52');
        EEG.event(i).type='checker-f2';
    elseif strcmp(EEG.event(i).type,'53');
        EEG.event(i).type='checker-f3';
    elseif strcmp(EEG.event(i).type,'54');
        EEG.event(i).type='checker-f4';
    elseif strcmp(EEG.event(i).type,'55');
        EEG.event(i).type='checker-f5';
    elseif strcmp(EEG.event(i).type,'56');
        EEG.event(i).type='checker-f6';
    elseif strcmp(EEG.event(i).type,'211');
        EEG.event(i).type='face-upright';
    elseif strcmp(EEG.event(i).type,'212');
        EEG.event(i).type='face-inverted';
    elseif strcmp(EEG.event(i).type,'213');
        EEG.event(i).type='house-upright';
    elseif strcmp(EEG.event(i).type,'214');
        EEG.event(i).type='house-inverted';
    elseif strcmp(EEG.event(i).type,'215');
        EEG.event(i).type='checker-left';
    elseif strcmp(EEG.event(i).type,'216');
        EEG.event(i).type='checker-right';
    elseif strcmp(EEG.event(i).type,'201');
        EEG.event(i).type='press-left';
    elseif strcmp(EEG.event(i).type,'204');
        EEG.event(i).type='press-right';
    elseif strcmp(EEG.event(i).type,'boundary');
        EEG.event(i).duration=0;
    else
        EEG.event(i).type=['e-',num2str(EEG.event(i).type)];
    end
end

% Down sample
EEG = pop_resample(EEG,256);

%save output set file
EEG = pop_saveset( EEG, 'filename',outsetfile);


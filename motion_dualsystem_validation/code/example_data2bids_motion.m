% example_motion_data2bids
% example script for creating a bids-compatible motion data set
%--------------------------------------------------------------------------

ft_defaults
[filepath,~,~] = fileparts(which('ft_defaults'));
addpath(fullfile(filepath, 'external', 'xdf'))

% general configuration
subjects = 6:10;
sessions = {'body', 'joy'}; 

% metadata
generalInfo = [];

% root directory (where you want your bids data to be saved)
generalInfo.bidsroot                                = 'P:\Sein_Jeung\Project_BIDS\Example_datasets\SPOT_rotation\1_BIDS-data';

% required for dataset_description.json
generalInfo.dataset_description.Name                = 'Heading';
generalInfo.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
generalInfo.dataset_description.License             = 'n/a';
generalInfo.dataset_description.Authors             = 'Gramann, Hohlefeld, Klug, Gehrke';
generalInfo.dataset_description.Acknowledgements    = 'n/a';
generalInfo.dataset_description.Funding             = 'n/a';
generalInfo.dataset_description.ReferencesAndLinks  = '';
generalInfo.dataset_description.DatasetDOI          = 'n/a';

% general information shared across modality specific json files
generalInfo.InstitutionName                         = 'Technische Universitaet zu Berlin';
generalInfo.InstitutionalDepartmentName             = 'Biological Psychology and Neuroergonomics';
generalInfo.InstitutionAddress                      = 'Strasse des 17. Juni 135, 10623, Berlin, Germany';
generalInfo.TaskDescription                         = 'Participants rotated following a sphere';
generalInfo.task                                    = 'SpotRotation';

% coordinate system
generalInfo.coordsystem.MotionCoordinateSystem      = 'RUF';
generalInfo.coordsystem.MotionRotationRule          = 'left-hand';
generalInfo.coordsystem.MotionRotationOrder         = 'ZXY';

% loop over participantas
%--------------------------------------------------------------------------
for subject = subjects
    
    cfg             = generalInfo;  % copy general metadata
    cfg.sub         = num2str(subject); 
    cfg.datatype    = 'motion'; 
    cfg.method      = 'convert'; 
    cfg.participants = ''; % participant information 
            
    % loop over sessions
    for Si = 1:numel(sessions)
        
        % session name 
        cfg.ses = sessions{Si};
        
        % different tracking systems were used in different sessions 
        if Si == 1
            
            % tracking systems 
            trackingSystems = {'HTCVive', 'PhaseSpace'}; 
            
            % motion stream names as stored in .xdf 
            motionStreamNames = {'headRigid', 'vizardAllPhasespaceLog'}; 
            
            % tracked point names
            trackedPointNames{1}    = {'headRigid'};
            trackedPointNames{2}    = {'Rigid1', 'Rigid2', 'Rigid3'};
            
            % system information
            cfg.motion.TrackingSystems.HTCVive.Manufacturer                         = 'HTC';
            cfg.motion.TrackingSystems.HTCVive.ManufacturersModelName               = 'Vive pro';
            cfg.motion.TrackingSystems.HTCVive.SamplingFrequencyNominal             = 90;
            cfg.motion.TrackingSystems.PhaseSpace.Manufacturer                      = 'PhaseSpace';
            cfg.motion.TrackingSystems.PhaseSpace.ManufacturersModelName            = 'Impulse X2';
            cfg.motion.TrackingSystems.PhaseSpace.SamplingFrequencyNominal          = 90;

        else
            
            % tracking systems  
            trackingSystems = {'VirtualTransform'}; 
            
            % motion stream names as stored in .xdf 
            motionStreamNames = {'headRigid'}; 
            
            % tracked point names
            trackedPointNames{1}    = {'headRigid'};
            
            % system information
            cfg.motion.TrackingSystems.VirtualTransform.Manufacturer                 = 'Unity3D';
            cfg.motion.TrackingSystems.VirtualTransform.ManufacturersModelName       = 'n/a';
            cfg.motion.TrackingSystems.VirtualTransform.SamplingFrequencyNominal     = 60;
            
        end
        
        % load data : in this example, the files are loaded per session
        % specific to .xdf 
        %------------------------------------------------------------------
        xdfStreams = load_xdf(fullfile(['P:\Sein_Jeung\Project_BIDS\Example_datasets\SPOT_rotation\0_raw-data\vp-' num2str(subject) '\vp-' num2str(subject) '_control_'  sessions{Si} '.xdf']));
        [names, iscontinuous, xdfStreams] = checkStreams(xdfStreams);
        %------------------------------------------------------------------
        % specific to .xdf 
        
        % initialize channel information array (tracking systems will be concatenated in a single channels.tsv)
        cfg.channels.name                   = {};
        cfg.channels.tracking_system        = {};
        cfg.channels.tracked_point          = {};
        cfg.channels.component              = {};
        cfg.channels.placement              = {};
        cfg.motion.MotionChannelCount       = 0; 
        
        % loop over tracking systems
        for Ti = 1%:numel(trackingSystems)
            
            % specific to .xdf 
            %--------------------------------------------------------------
            xdfMotion   = xdfStreams(contains(lower(names),lower(motionStreamNames{Ti})) & iscontinuous);
            
            % construct fieldtrip data
            motion = {};
            for iM = 1:numel(xdfMotion)
                motion{iM} = stream2ft(xdfMotion{iM});
            end
            
            motion = spotrotation_motionconvert(motion, 'pupil_capture_diameter1_3d', cfg.sub, 1, 1);
            %--------------------------------------------------------------
            % specific to .xdf 
            
            cfg.motion.MotionChannelCount  = cfg.motion.MotionChannelCount + motion.hdr.nChans; 
            for ci  = 1:motion.hdr.nChans
                
                motionChanType          = motion.hdr.chantype{ci};
                switch motionChanType
                    case 'ORNT'
                        motion.hdr.chanunit{ci} = 'rad';
                    case 'POS'
                        motion.hdr.chanunit{ci} = 'm';
                end
                
                splitlabel                                = regexp(motion.hdr.label{ci}, '_', 'split');
                cfg.channels.name{end+1}                  = motion.hdr.label{ci};
                cfg.channels.tracking_system{end+1}       = trackingSystems{Ti};
                
                % assign object names and anatomical positions
                cfg.channels.tracked_point{end+1}= splitlabel{1};
                
                switch splitlabel{1}
                    case 'headRigid'
                        cfg.channels.placement{end+1}    = 'head';
                    otherwise
                        cfg.channels.placement{end+1}    = 'n/a';
                end
                
                cfg.channels.component{end+1}    = splitlabel{end};
                
            end
            
            cfg.tracksys        = trackingSystems{Ti}; 
            
            data2bids(cfg, motion);
            
        end
        
    end
end


% these subfunctions perform xdf specific processing 
%--------------------------------------------------------------------------

function [names, iscontinuous, streams] = checkStreams(streams)

iscontinuous = false(size(streams));
names = {};

% figure out which streams contain continuous/regular and discrete/irregular data
for i=1:numel(streams)
    
    names{i}           = streams{i}.info.name;
    
    % if the nominal srate is non-zero, the stream is considered continuous
    if ~strcmpi(streams{i}.info.nominal_srate, '0')
        
        iscontinuous(i) =  true;
        num_samples  = numel(streams{i}.time_stamps);
        t_begin      = streams{i}.time_stamps(1);
        t_end        = streams{i}.time_stamps(end);
        duration     = t_end - t_begin;
        
        if ~isfield(streams{i}.info, 'effective_srate')
            % in case effective srate field is missing, add one
            streams{i}.info.effective_srate = (num_samples - 1) / duration;
        elseif isempty(streams{i}.info.effective_srate)
            % in case effective srate field value is missing, add one
            streams{i}.info.effective_srate = (num_samples - 1) / duration;
        end
        
    else
        try
            num_samples  = numel(streams{i}.time_stamps);
            t_begin      = streams{i}.time_stamps(1);
            t_end        = streams{i}.time_stamps(end);
            duration     = t_end - t_begin;
            
            % if sampling rate is higher than 20 Hz,
            % the stream is considered continuous
            if (num_samples - 1) / duration >= 20
                iscontinuous(i) =  true;
                if ~isfield(streams{i}.info, 'effective_srate')
                    % in case effective srate field is missing, add one
                    streams{i}.info.effective_srate = (num_samples - 1) / duration;
                elseif isempty(streams{i}.info.effective_srate)
                    % in case effective srate field value is missing, add one
                    streams{i}.info.effective_srate = (num_samples - 1) / duration;
                end
            end
        catch
        end
    end
end
end

%--------------------------------------------------------------------------
function [ftdata] = stream2ft(xdfstream)

% construct header
hdr.Fs                  = xdfstream.info.effective_srate;
hdr.nFs                 = str2double(xdfstream.info.nominal_srate);
hdr.nSamplesPre         = 0;
hdr.nSamples            = length(xdfstream.time_stamps);
hdr.nTrials             = 1;
hdr.FirstTimeStamp      = xdfstream.time_stamps(1);
hdr.TimeStampPerSample  = (xdfstream.time_stamps(end)-xdfstream.time_stamps(1)) / (length(xdfstream.time_stamps) - 1);
if isfield(xdfstream.info.desc, 'channels')
    hdr.nChans    = numel(xdfstream.info.desc.channels.channel);
else
    hdr.nChans    = str2double(xdfstream.info.channel_count);
end

hdr.label       = cell(hdr.nChans, 1);
hdr.chantype    = cell(hdr.nChans, 1);
hdr.chanunit    = cell(hdr.nChans, 1);

prefix = xdfstream.info.name;
for j=1:hdr.nChans
    if isfield(xdfstream.info.desc, 'channels')
        hdr.label{j} = [prefix '_' xdfstream.info.desc.channels.channel{j}.label];

        try 
            hdr.chantype{j} = xdfstream.info.desc.channels.channel{j}.type;
        catch
            disp([hdr.label{j} ' missing type'])
        end
        
        try
            hdr.chanunit{j} = xdfstream.info.desc.channels.channel{j}.unit;
        catch
            disp([hdr.label{j} ' missing unit'])
        end
    else
        % the stream does not contain continuously sampled data
        hdr.label{j} = num2str(j);
        hdr.chantype{j} = 'unknown';
        hdr.chanunit{j} = 'unknown';
    end
end

% keep the original header details
hdr.orig = xdfstream.info;

ftdata.trial    = {xdfstream.time_series};
ftdata.time     = {xdfstream.time_stamps};
ftdata.hdr = hdr;
ftdata.label = hdr.label;

end


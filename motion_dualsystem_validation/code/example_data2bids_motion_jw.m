%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Process Raw data to convert to BIDS motion
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data: Validation dataset (Elke Warmerdam, University of Kiel, https://www.mdpi.com/1424-8220/21/17/5833)
% Author: Julius Welzel, j.welzel@neurologie.uni-kiel.de

close all, clear all, clc;

% set up fieldtrip
addpath('C:\Users\User\Desktop\software\fieldtrip_sein_fork'); % using seins ft fork
ft_defaults
ft_notice('This script uses fieldtrip verision: %s',ft_version)
display(['This script uses BIDS version 1.4.0 // BEP029'])

%set paths
dir_project     = fullfile('C:\Users\User\Desktop\bids_motion_validation');
dir_raw_data    = fullfile(fileparts('C:\Users\User\Desktop\bids_motion_validation\sourcedata\'));
addpath(genpath(dir_project));

%--------------------------------------------------------------------------
% general configuration
nms_tasks   = {'backwards','obstacle_high','obstacle_low'};
instr_tasks = {'walking backwards','walking over high obstacles','walking over low obstacles'};
nms_subs    = {'pp002','pp003','pp004'};
subjects    = numel(nms_subs);

% metadata
generalInfo = [];

% root directory (where you want your bids data to be saved)
generalInfo.bidsroot                                = dir_project;

% required for dataset_description.json
generalInfo.dataset_description.Name                = 'Neurological validation dataset';
generalInfo.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
generalInfo.dataset_description.License             = 'n/a';
generalInfo.dataset_description.Authors             = 'Elke Warmerdam,Robbin Romijnders,Johanna Geritz,Morad Elshehabi,Corina Maetzler,Jan Carl Otto,Maren Reimer,Klarissa Stuerner,Ralf Baron,Steffen PaschenORCID,Thorben Beyer,Denise Dopcke,Tobias Eiken,Hendrik Ortmann,Falko Peters,Felix von der Recke,Moritz Riesen,Gothia Rohwedder,Anna Schaade,Maike Schumacher,Anton Sondermann,Walter Maetzler and Clint Hansen';
generalInfo.dataset_description.Acknowledgements    = 'n/a';
generalInfo.dataset_description.Funding             = 'Mobilise-D';
generalInfo.dataset_description.ReferencesAndLinks  = 'https://www.mdpi.com/1424-8220/21/17/5833';
generalInfo.dataset_description.DatasetDOI          = 'doi.org/10.3390/s21175833';

% general information shared across modality specific json files
generalInfo.InstitutionName                         = 'Kiel University';
generalInfo.InstitutionalDepartmentName             = 'Department of Neurology';


% loop over participantas
%--------------------------------------------------------------------------
for subject = 1:numel(nms_subs)
    
    % load data from Neurogeriatrics MatLab format
    %----------------------------------------------------------------------
    for t = 1:numel(nms_tasks)
        % imu data
        tmp_fname_imu = fullfile(dir_raw_data,[nms_subs{subject} filesep],['imu_',nms_tasks{t},'.mat']);
        if ~exist(tmp_fname_imu) == 2
            continue
        end
        load(tmp_fname_imu)
        imu = data;
        clear data

        % extract data per type and store in ft like struct
        data_acc = [];
        [data_acc.label nms_acc_type nms_acc_loc nms_acc_comp]      = locs2chans(imu.imu_location,{'ACC'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_acc.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_acc.time{1}    = linspace(0,length(data_acc.trial{1})/imu.fs,length(data_acc.trial{1}));

        data_gyro = [];
        [data_gyro.label nms_gyro_type nms_gyro_loc nms_gyro_comp]     = locs2chans(imu.imu_location,{'ANGVEL'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_gyro.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_gyro.time{1}    = linspace(0,length(data_gyro.trial{1})/imu.fs,length(data_gyro.trial{1}));

        data_magn = [];
        [data_magn.label nms_magn_type nms_magn_loc nms_magn_comp]     = locs2chans(imu.imu_location,{'MAGN'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_magn.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_magn.time{1}    = linspace(0,length(data_magn.trial{1})/imu.fs,length(data_magn.trial{1}));

        % combine data
        cfg = [];
        dat.imu = ft_appenddata(cfg, data_acc, data_gyro, data_magn);

        % construct ft header for imu data
        dat.imu.hdr.Fs                  = round(dat.imu.fsample,0);
        dat.imu.hdr.nSamples            = length(dat.imu.time{1});
        dat.imu.hdr.nTrials             = size(dat.imu.trial);
        dat.imu.hdr.nChans              = size(dat.imu.trial{1},1);
        dat.imu.hdr.chantype            = horzcat(nms_acc_type,nms_gyro_type,nms_magn_type);
        dat.imu.hdr.chanunit            = type2unit(dat.imu.hdr.chantype);
        dat.imu.hdr.label               = dat.imu.label;

        % load raw optical data
        tmp_fname_omc = fullfile(dir_raw_data,[nms_subs{subject} filesep],['omc_',nms_tasks{t},'.mat']);
        if ~exist(tmp_fname_omc) == 2
            continue
        end
        load(tmp_fname_omc)

        omc = data;
        omc.pos(:,4,:) = [];
        clear data

        data_omc = [];
        [data_omc.label nms_omc_type nms_omc_loc nms_omc_comp]      = locs2chans(omc.marker_location,{'POS'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_omc.trial{1}   = reshape(omc.pos,[],size(omc.pos,2) * size(omc.pos,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_omc.time{1}    = linspace(0,length(data_omc.trial{1})/imu.fs,length(data_omc.trial{1}));

        cfg = [];
        dat.omc = ft_appenddata(cfg, data_omc);

        % construct ft header for omc data
        dat.omc.hdr.Fs                  = round(dat.omc.fsample,0);
        dat.omc.hdr.nSamples            = length(dat.omc.time{1});
        dat.omc.hdr.nTrials             = size(dat.omc.trial);
        dat.omc.hdr.nChans              = size(dat.omc.trial{1},1);
        dat.omc.hdr.chantype            = nms_omc_type;
        dat.omc.hdr.chanunit            = type2unit(dat.omc.hdr.chantype);
        dat.omc.hdr.label               = dat.omc.label;

        %% process for data2bids
        % ---------------------------------------------------------------------

        cfg                 = generalInfo;  % copy general metadata
        cfg.sub             = nms_subs{subject}; 
        cfg.TaskName        = camelCase(nms_tasks{t});
        cfg.TaskDescription = instr_tasks{t};
        cfg.datatype        = 'motion'; 
        cfg.method          = 'convert'; 
        cfg.participants    = ''; % participant information 
        cfg.scans.acq_time  = char(datetime('now', 'Format', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''));


        % tracking systems 
        trackingSystems = fieldnames(dat);            

        % tracked point names
        trackedPointNames{1}    = omc.marker_location;
        trackedPointNames{2}    = imu.imu_location;

        % system information
        % imu
        cfg.motion.TrackingSystems.imu.Manufacturer                 = 'Noraxon Inc.';
        cfg.motion.TrackingSystems.imu.ManufacturersModelName       = 'myoMOTION';
        cfg.motion.TrackingSystems.imu.SamplingFrequencyNominal     = round(imu.fs,0);
        cfg.motion.TrackingSystems.imu.StartTime                    = char(datetime('now', 'Format', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''));
        cfg.motion.TrackingSystems.imu.TrackedPointsCount           = numel(unique(imu.imu_location));

        % omc
        cfg.motion.TrackingSystems.omc.Manufacturer                 = 'Qualisys';
        cfg.motion.TrackingSystems.omc.ManufacturersModelName       = 'AB';
        cfg.motion.TrackingSystems.omc.SamplingFrequencyNominal     = round(omc.fs,0);
        cfg.motion.TrackingSystems.omc.StartTime                    = char(datetime('now', 'Format', 'yyyy-MM-dd''T''HH:mm:ss.SSS''Z'''));
        cfg.motion.TrackingSystems.omc.TrackedPointsCount           = numel(unique(omc.marker_location));
        
        % initialize channel information array (tracking systems will be concatenated in a single channels.tsv)
        cfg.channels.name                   = {};
        cfg.channels.tracking_system        = {};
        cfg.channels.tracked_point          = {};
        cfg.channels.component              = {};
        cfg.channels.placement              = {};
        cfg.motion.TrackedPointsCountTotal  = 0;
     

        % loop over tracking systems
        for Ti = 1:numel(trackingSystems)
            cfg.tracksys                    = trackingSystems{Ti}; 
            cfg.motion.TrackedPointsCountTotal  = cfg.motion.TrackingSystems.(cfg.tracksys).TrackedPointsCount + cfg.motion.TrackedPointsCountTotal ; 

            data2bids(cfg, dat.(cfg.tracksys));
        end
    end  %tasks      
end %participants


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


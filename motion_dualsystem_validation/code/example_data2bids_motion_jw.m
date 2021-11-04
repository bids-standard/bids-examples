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
dir_project     = fullfile('C:\Users\User\Desktop\motion_dualsystem_validation');
dir_raw_data    = fullfile(fileparts('C:\Users\User\Desktop\\motion_dualsystem_validation\sourcedata\'));
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
%             continue
        end
        load(tmp_fname_imu)
        imu = data;
        clear data

        % extract data per type and store in ft like struct
        data_acc = [];
        [data_acc.label nms_acc_type nms_acc_loc nms_acc_comp]      = locs2chans(imu.imu_location,{'ACC'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_acc.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_acc.time{1}    = linspace(0,length(data_acc.trial{1})/imu.fs,length(data_acc.trial{1}+2));
        
        data_gyro = [];
        [data_gyro.label nms_gyro_type nms_gyro_loc nms_gyro_comp]     = locs2chans(imu.imu_location,{'ANGVEL'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_gyro.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_gyro.time{1}    = linspace(0,length(data_gyro.trial{1})/imu.fs,length(data_gyro.trial{1}+2));

        data_magn = [];
        [data_magn.label nms_magn_type nms_magn_loc nms_magn_comp]     = locs2chans(imu.imu_location,{'MAGN'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_magn.trial{1}   = reshape(imu.acc,[],size(imu.acc,2) * size(imu.acc,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_magn.time{1}    = linspace(0,length(data_magn.trial{1})/imu.fs,length(data_magn.trial{1}+2));

        % combine data
        cfg = [];
        trackingSystem.imu = ft_appenddata(cfg, data_acc, data_gyro, data_magn);

        % construct ft header for imu data
        trackingSystem.imu.hdr.Fs                  = round(trackingSystem.imu.fsample,0);
        trackingSystem.imu.hdr.nSamples            = length(trackingSystem.imu.time{1});
        trackingSystem.imu.hdr.nTrials             = size(trackingSystem.imu.trial);
        trackingSystem.imu.hdr.nChans              = size(trackingSystem.imu.trial{1},1);
        trackingSystem.imu.hdr.chantype            = horzcat(nms_acc_type,nms_gyro_type,nms_magn_type);
        trackingSystem.imu.hdr.chanunit            = type2unit(trackingSystem.imu.hdr.chantype);
        trackingSystem.imu.hdr.label               = trackingSystem.imu.label;

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
        data_omc.time{1}    = linspace(0, length(data_omc.trial{1})/omc.fs,length(data_omc.trial{1}));

        cfg = [];
        trackingSystem.omc = ft_appenddata(cfg, data_omc);

        % construct ft header for omc data
        trackingSystem.omc.hdr.Fs                  = round(trackingSystem.omc.fsample,0);
        trackingSystem.omc.hdr.nSamples            = length(trackingSystem.omc.time{1});
        trackingSystem.omc.hdr.nTrials             = size(trackingSystem.omc.trial);
        trackingSystem.omc.hdr.nChans              = size(trackingSystem.omc.trial{1},1);
        trackingSystem.omc.hdr.chantype            = nms_omc_type;
        trackingSystem.omc.hdr.chanunit            = type2unit(trackingSystem.omc.hdr.chantype);
        trackingSystem.omc.hdr.label               = trackingSystem.omc.label;

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
        nms_ts = fieldnames(trackingSystem);            

        % tracked point names
        trackedPointNames{1}    = omc.marker_location;
        trackedPointNames{2}    = imu.imu_location;

        % system information
        % imu
        cfg.motion.TrackingSystems.imu.Manufacturer                 = 'Noraxon Inc.';
        cfg.motion.TrackingSystems.imu.ManufacturersModelName       = 'myoMOTION';
        cfg.motion.TrackingSystems.imu.SamplingFrequencyNominal     = round(imu.fs,0);
        cfg.motion.TrackingSystems.imu.TrackedPointsCount           = numel(unique(imu.imu_location));

        % omc
        cfg.motion.TrackingSystems.omc.Manufacturer                 = 'Qualisys';
        cfg.motion.TrackingSystems.omc.ManufacturersModelName       = 'AB';
        cfg.motion.TrackingSystems.omc.SamplingFrequencyNominal     = round(omc.fs,0);
        cfg.motion.TrackingSystems.omc.TrackedPointsCount           = numel(unique(omc.marker_location));
        
       
        % loop over tracking systems
        for Ti = 1:numel(nms_ts)
            % get tracking system name
            cfg.tracksys    = nms_ts{Ti}; 
            
            % add channel info to cfg 
            cfg             = ft_motionchannels(cfg,trackingSystem);
            
            % convert to bids
            data2bids(cfg, trackingSystem.(cfg.tracksys));

        end
    end  %tasks      
end %participants



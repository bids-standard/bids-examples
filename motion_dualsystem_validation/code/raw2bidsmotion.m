%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Process Raw data to convert to BIDS motion
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data: Validation dataset (Elke Warmerdam, University of Kiel, https://www.mdpi.com/1424-8220/21/17/5833)
% Author: Julius Welzel, j.welzel@neurologie.uni-kiel.de

close all, clear all, clc;
% settings
display(['This script uses fieldtrip verision: ' ft_version])
display(['This script uses BIDS version 1.4.0 // BEP029'])

path_raw = fullfile(fileparts('C:\Users\User\Desktop\bids_motion_validation\'));

%% prep imu data
flist       = dir(path_raw);
flist       = flist(contains({flist.name},'pp'));
nms_subs    = extractAfter({flist.name},'sub-');

%% dataset info
% metadata
generalInfo = [];

% root directory (where you want your bids data to be saved)
generalInfo.bidsroot                                = 'C:\Users\User\Desktop\bids_motion_validation';

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
generalInfo.InstitutionName                         = 'Technische Universitaet zu Berlin';
generalInfo.InstitutionalDepartmentName             = 'Biological Psychology and Neuroergonomics';
generalInfo.InstitutionAddress                      = 'Strasse des 17. Juni 135, 10623, Berlin, Germany';
generalInfo.TaskDescription                         = 'Participants rotated following a sphere';
generalInfo.task                                    = 'SpotRotation';

% coordinate system
generalInfo.coordsystem.MotionCoordinateSystem      = 'RUF';
generalInfo.coordsystem.MotionRotationRule          = 'left-hand';
generalInfo.coordsystem.MotionRotationOrder         = 'ZXY';



%%

for s = 2%1:numel(nms_subs)

    %% prep data for BIDS conversion
    nms_tasks   = dir(fullfile(path_raw,['sub-' nms_subs{s} filesep 'motion' filesep]));
    nms_tasks   = nms_tasks(startsWith({nms_tasks.name},'imu_'));
    nms_tasks   = extractBetween({nms_tasks.name},'imu_','.mat');
    
    for t = 1:3%numel(nms_tasks)
        % load raw imu data
        load(fullfile(path_raw,['sub-' nms_subs{s} filesep 'motion' filesep],['imu_',nms_tasks{t},'.mat']))
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
        dat_imu = ft_appenddata(cfg, data_acc, data_gyro, data_magn);

                % load raw imu data
        load(fullfile(path_raw,['sub-' nms_subs{s} filesep 'motion' filesep],['imu_',nms_tasks{t},'.mat']))
        imu = data;
        clear data

        %% extract data per type and store in ft like struct
        
        % load raw optical data
        load(fullfile(path_raw,['sub-' nms_subs{s} filesep 'motion' filesep],['omc_',nms_tasks{t},'.mat']))
        omc = data;
        omc.pos(:,4,:) = [];
        
        clear data

        data_omc = [];
        [data_omc.label nms_omc_type nms_omc_loc nms_omc_comp]      = locs2chans(omc.marker_location,{'POS'}); % only location, not label for *channels.tsv. Append accordingly :)
        data_omc.trial{1}   = reshape(omc.pos,[],size(omc.pos,2) * size(omc.pos,3))'; % change 3d matrix to 2d, where 2nd dim are all avaliable channels from tracking system
        data_omc.time{1}    = linspace(0,length(data_omc.trial{1})/imu.fs,length(data_omc.trial{1}));

        %% combine imu data
        cfg = [];
        dat_imu = ft_appenddata(cfg, data_acc, data_gyro, data_magn);

        % construct ft header
        dat_imu.hdr.Fs                  = ceil(dat_imu.fsample);
        dat_imu.hdr.nSamples            = length(dat_imu.time{1});
        dat_imu.hdr.nTrials             = size(dat_imu.trial);
        dat_imu.hdr.nChans              = size(dat_imu.trial{1},1);
        dat_imu.hdr.chantype            = horzcat(nms_acc_type,nms_gyro_type,nms_magn_type);
        dat_imu.hdr.chanunit            = dat_imu.hdr.chantype;
        dat_imu.hdr.label               = dat_imu.label;

         %% combine imu data
        cfg = [];
        dat_omc = ft_appenddata(cfg, data_omc);

        % construct ft header
        dat_omc.hdr.Fs                  = dat_omc.fsample;
        dat_omc.hdr.nSamples            = length(dat_omc.time{1});
        dat_omc.hdr.nTrials             = size(dat_omc.trial);
        dat_omc.hdr.nChans              = size(dat_omc.trial{1},1);
        dat_omc.hdr.chantype            = nms_omc_type;
        dat_omc.hdr.chanunit            = dat_omc.hdr.chantype;
        dat_omc.hdr.label               = dat_omc.label;
        %% start BIDS conversion
        cfg = [];
        cfg.datatype = 'motion';
        cfg.method = 'convert';



        %%%%%%%%%% Motion specific info %%%%%%%%%%%%%%%%%%%%%%


        % construct file and participant- and file- specific config
        % information needed to construct file paths and names
        cfg.sub                         = nms_subs{s};
        cfg.task                        = nms_tasks{t}; 
        cfg.tracksys                    = ["omc"];
        cfg.TrackingSystemCount         = numel(cfg.tracksys);
        cfg.channels.tracked_point      = nms_omc_loc;%horzcat(nms_acc_loc,nms_gyro_loc,nms_magn_loc)%,nms_omc_loc);
        cfg.channels.component          = nms_omc_comp;%horzcat(nms_acc_comp,nms_gyro_comp,nms_magn_comp)%,nms_omc_comp);
        cfg.channels.name               = dat_omc.label;

        cfg.motion.SubjectArtefactDescription       = 'n/a';
        cfg.motion.start_time                       = datestr(now, 'yyyy-mm-ddThh:MM:SS'); % according to RFC3339
        cfg.motion.trsystems                        = ["omc"];
        cfg.motion.tracksys.omc.TrackPointsCount    = numel(unique(cfg.channels.tracked_point));
        
        cfg.bidsroot = 'C:\Users\User\Desktop\bids_motion_validation';

        cfg.writejson = 'yes';
        cfg.writetsv = 'yes';
        % save as BIDS
        data2bids_mot(cfg,dat_omc)
        
        display(['Done with BIDS conversion for ' nms_subs{s} ' task ' nms_tasks{t}])
        % save as BIDS
%         data2bids_mot(cfg,dat_omc)
        %% Problems using the data2bids
        %{
        - if multiple tracking systems defined, the filename is not constructed multiple times
        - Manufacures Info in tracking system json
        - need coordinate system not nessecary
        - cfg.motion.trsystems vs. cfg.motion.tracksys.omc
        - recording duration per tracking system
        %}
    end

    % check error in json
   
end



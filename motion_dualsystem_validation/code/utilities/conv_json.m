function conv_json(bemobil_config, numericalIDs, varargin)

% Example script for converting BIDS recordings with one motion.json file 
% for all trackingsystems to BIDS recordings with a motion.json file for each trackingsystem

% Inputs:
% bemobil_config.study_folder             = 'E:\Project_BIDS\example_dataset_MWM\';
% bemobil_config.bids_data_folder         = '1_BIDS-data_spotrotation\';
% bemobil_config.session_names            = {'body', 'joy'}; 
% bemobil_config.other_data_types         = {'motion'};  
% bemobil_config.bids_source_zeropad      = 3;
%
% numericalIDs
%  array of participant numerical IDs in the data set


% input check and default value assignment
%--------------------------------------------------------------------------
bemobil_config = checkfield(bemobil_config, 'bids_source_zeropad', 3, '3');


% write new json files
%--------------------------------------------------------------------------
bemobil_config.filename_prefix          = 'sub-';

% create new BIDS folder
bids_data_folder_new     = [bemobil_config.bids_data_folder(1:end-1) '_v2\'];
source_folder            = fullfile(bemobil_config.study_folder, bemobil_config.bids_data_folder); % source folder is the old bids data folder
bidsroot_new             = fullfile(bemobil_config.study_folder, bids_data_folder_new);

% copy old files in new directory
mkdir(bidsroot_new);
copyfile(source_folder, bidsroot_new);

% path to sourcedata
sourceDataPath                          = fullfile(source_folder(1:end-1));
addpath(genpath(sourceDataPath))

% loop over participants
for pi = 1:numel(numericalIDs)
    
    participantNr   = numericalIDs(pi);
    disp(['Importing .json for participant ' num2str(participantNr)])
        
    if bemobil_config.bids_source_zeropad == 0
        participantDir  = fullfile(sourceDataPath, [bemobil_config.filename_prefix num2str(participantNr)]);
    else
        participantDir  = fullfile(sourceDataPath, [bemobil_config.filename_prefix num2str(participantNr, ['%0' num2str(bemobil_config.bids_source_zeropad) '.f'])]);
    end
    
    % loop over sessions
    for si = 1:numel(bemobil_config.session_names)

        sessionDir          = fullfile(participantDir, ['ses-' bemobil_config.session_names{si} '/motion']); 
        sessionFiles        = dir(sessionDir);
        fileNameArray       = {sessionFiles.name};
        json_old            = sessionFiles(contains(fileNameArray, '.json') & contains(fileNameArray, 'motion'));
        folder              = [json_old.folder '\'];
        name                = json_old.name;
        
        json = ft_read_json(fullfile(folder,name));

        % split old json and remove tracking system layer
        json_tsinfo  = json;
        trsys_number = numel(fieldnames(json.TrackingSystems));
        trsys_names  = fieldnames(json.TrackingSystems);

        for tsi = 1:trsys_number
            trsystem_info = json_tsinfo.TrackingSystems.(trsys_names{tsi}); % extract trackingsystem info
            general_info  = rmfield(json,{'TrackingSystems' 'TrackedPointsCountTotal' 'TrackingSystemCount'}); % extract general info
            
            % merge general and tracksys info
            names    = [fieldnames(general_info);fieldnames(trsystem_info)];
            new_json = cell2struct([struct2cell(general_info); struct2cell(trsystem_info)], names, 1);
            
            % construct new filename and directory
            tsv_file           = sessionFiles(contains(fileNameArray, '.tsv') & contains(fileNameArray, 'motion'));
            filename_new       = replace(tsv_file.name,'.tsv','.json');
            directory_new      = replace(folder,bemobil_config.bids_data_folder ,bids_data_folder_new);
            notsort            = 'n'; % create a variable so entries in .json are not sorted
            
            ft_write_json(fullfile(directory_new, filename_new), new_json, notsort);
        end 
        
        delete([directory_new, name]); % delete old json
    end 
  
end    

end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUBFUNCTION check fields
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%--------------------------------------------------------------------------
function [newconfig] =  checkfield(oldconfig, fieldName, defaultValue, defaultValueText)

newconfig   = oldconfig;

if ~isfield(oldconfig, fieldName)
    newconfig.(fieldName) = defaultValue;
    warning(['Config field ' fieldName ' not specified- using default value: ' defaultValueText])
end

end

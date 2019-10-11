% Preface:

% Global settings
bidsOpt.FileExt = 'edf';
bidsOpt.InteralUse = true;

data(1).file = {'./sourcedata/eeg/sub-s01_task-faceFO_eeg.set'};
data(1).session = 1;
data(1).run     = 1;

% general information for dataset_description.json file
% -----------------------------------------------------
generalInfo.Name = 'faceFO';
generalInfo.License = 'ODbL (https://opendatacommons.org/licenses/odbl/summary/)';
generalInfo.Authors = {'James A. Desjardins', 'Sidney J. Segalowitz'};
generalInfo.HowToAcknowledge = 'Desjardins, J. A., & Segalowitz, S. J. (2013). Deconstructing the early visual electrocortical responses to face and house stimuli. Journal of Vision, 13(5), 22-22.';
generalInfo.Funding = {'NSERC funding to Sidney Segalowitz'};
generalInfo.ReferencesAndLinks = {'http://jov.arvojournals.org/article.aspx?articleid=2121634'};
generalInfo.DatasetDOI = '10.1167/13.5.22';

README = sprintf('# Face13 Dataset\n\nData used for JofV Deconstructing the early visual electrocortical response to face and house stimuli:\nhttps://jov.arvojournals.org/article.aspx?articleid=2121634');

% Task information for xxxx-eeg.json file
% -----------------------------------------------------
tInfo.TaskName = 'FaceHouseCheck';
tInfo.TaskDescription = 'Visual presentation of oval cropped face and house images both upright and inverted. Rare left or right half oval checkerboards were presetned as targets for keypress response.';
tInfo.InstitutionName =  'Brock University';
tInfo.InstitutionAddress = '500 Glenridge Ave, St.Catharines, Ontario';
tInfo.EOGChannelCount =  7;
tInfo.EMGChannelCount =  0;
tInfo.MiscChannelCount =  0;
tInfo.TriggerChannelCount = 0;
tInfo.PowerLineFrequency = 60;
tInfo.EEGPlacementScheme = 'Custom equidistant 128 channel BioSemi montage established in coordination with Judith Schedden McMaster Univertisy';
tInfo.Manufacturer = 'BioSemi';
tInfo.ManufacturersModelName = 'ActiveTwo';
tInfo.HardwareFilters = 'n/a';
tInfo.SoftwareFilters = 'n/a';
tInfo.SoftwareVersions = 'NI ActiView 532-Lores';
tInfo.CapManufacturer = 'ElectroCap International';
tInfo.CapManufacturersModelName = '10032';

% channel location file
% ---------------------
chanlocs = './sourcedata/misc/BioSemi_BUCANL_EEGLAB.sfp';
           
% coordsystem string
% This string will be placed in each coordsystem.json
% ---------------------
coordsys = '{"EEGCoordinateSystem":"Other","EEGCoordinateUnits":"metres"}';
           
% call to the export function
% ---------------------------
bids_export(data, 'targetdir', uigetdir, 'taskName', ...
    generalInfo.Name, 'gInfo', generalInfo, 'coordsys', coordsys, ...
    'chanlocs', chanlocs, 'README', README, 'bidsOpt', bidsOpt,'tInfo',tInfo);

disp('Done!');

% bids_export(data, 'targetdir', '/Users/arno/temp/bids_meditation_export', 'taskName', ...
%     'meditation', 'trialtype', trialTypes, 'gInfo', generalInfo, 'pInfo', pInfo, ...
%     'pInfoDesc', pInfoDesc, 'eInfoDesc', eInfoDesc, 'README', README, ...
%     'CHANGES', CHANGES, 'stimuli', stimuli, 'codefiles', code, 'tInfo', tInfo, 'chanlocs', chanlocs);
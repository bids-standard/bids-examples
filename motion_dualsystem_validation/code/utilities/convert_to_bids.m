% although the files have the extension tsv (tab separated values), they contain a comma as separator
% they also contain 4 heading lines

table_3d   = readtable('../data/HandChoiceSwitch_EEG_01_001_3d.tsv', 'FileType', 'text', 'Delimiter', ',', 'HeaderLines', 4);
table_0dau = readtable('../data/HandChoiceSwitch_EEG_01_001_Odau_1.tsv', 'FileType', 'text', 'Delimiter', ',', 'HeaderLines', 4);

% the last column is empty
table_3d = table_3d(:,1:end-1);
table_0dau = table_0dau(:,1:end-1);

% plot(table_3d.Frame, table_3d.Marker_1X)
% plot(table_0dau.Frame, table_0dau.Analog_1)

data_3d = [];
data_3d.label    = table_3d.Properties.VariableNames;
data_3d.trial{1} = table2array(table_3d)';
data_3d.time{1}  = (table_3d.Frame')/250;

data_0dau = [];
data_0dau.label    = table_0dau.Properties.VariableNames;
data_0dau.trial{1} = table2array(table_0dau)';
data_0dau.time{1}  = (table_0dau.Frame')/250;

%%

% both files have the Frame as the first column, hence as the first channel
% ensure they are equal
assert(isequal(data_3d.trial{1}(1,:), data_0dau.trial{1}(1,:)))

% remove the Frame channel
cfg = [];
cfg.channel = {'all', '-Frame'};
data_0dau = ft_selectdata(cfg, data_0dau);

% combine the two datasets
cfg = [];
data_combined = ft_appenddata(cfg, data_3d, data_0dau);


%%

cfg = [];

cfg.InstitutionName             = 'Radboud University';
cfg.InstitutionalDepartmentName = 'Donders Institute for Brain, Cognition and Behaviour';
cfg.InstitutionAddress          = 'Kapittelweg 29, 6525 EN, Nijmegen, The Netherlands';

% required for dataset_description.json
cfg.dataset_description.Name                = 'Motion capture example';
cfg.dataset_description.BIDSVersion         = 'unofficial extension';

% optional for dataset_description.json
cfg.dataset_description.License             = 'n/a';
cfg.dataset_description.Authors             = 'n/a';
cfg.dataset_description.Acknowledgements    = 'n/a';
cfg.dataset_description.Funding             = 'n/a';
cfg.dataset_description.ReferencesAndLinks  = 'n/a';
cfg.dataset_description.DatasetDOI          = 'n/a';

cfg.dataset = './original/dataOptotrak/HandChoiceSwitch_EEG_01_001_3d.tsv';  % exported from Qualisys
% cfg.dataset = './original/self_test_30April2015_ADA.tsv'; % alternative export format

cfg.bidsroot = '../data';  % write to the present working directory
cfg.datatype = 'motion';
cfg.sub = 'S01';

% these are general fields
cfg.Manufacturer           = 'Optotrak';
cfg.ManufacturersModelName = 'Unknown';

cfg.TaskDescription = 'The subject was switching between hand movements';
cfg.task = 'HandChoiceSwitch';

data2bids(cfg, data_combined);

function sidecar_eeg=mk_sidecar_eeg(EEG,fname,varargin)

opts=struct(varargin{:});


% load current file only if it hasn't been loaded already
if ~exist('EEG','var') || ...
        (exist('EEG','var') && isempty(EEG)) || ...
  (~isempty(EEG) && ~strcmp(fname,[EEG.filepath '/' EEG.filename]));
    EEG = pop_loadset('filename',fname);
end

[path,fname,ext] = fileparts(fname);
disp(['Creating ' fname '.json file...']);


if isfield(opts,'TaskName');
    sidecar_eeg.TaskName=opts.TaskName;
end
if isfield(opts,'TaskDescription');
    sidecar_eeg.TaskDescription=opts.TaskDescription;
end
if isfield(opts,'Instructions');
    sidecar_eeg.Instructions=opts.Instructions;
end
if isfield(opts,'CogAtlasID');
    sidecar_eeg.CogAltasID=opts.CogAltasID;
end
if isfield(opts,'CogPOID');
    sidecar_eeg.CogPOID=opts.CogPOID;
end
if isfield(opts,'InstitutionName');
    sidecar_eeg.InstitutionName=opts.InstitutionName;
end
if isfield(opts,'InstitutionAddress');
    sidecar_eeg.InstitutionAddress=opts.InstitutionAddress;
end
if isfield(opts,'DeviceSerialNumber');
    sidecar_eeg.DeviceSerialNumber=opts.DeviceSerialNumber;
end
sidecar_eeg.SamplingFrequency=EEG.srate;
sidecar_eeg.EEGChannelCount=EEG.nbchan;

if isfield(opts,'EOGChannelCount');
    sidecar_eeg.EOGChannelCount=opts.EOGChannelCount;
else
    sidecar_eeg.EOGChannelCount=0;
end
if isfield(opts,'EMGChannelCount');
    sidecar_eeg.EMGChannelCount=opts.EMGChannelCount;
else
    sidecar_eeg.EMGChannelCount=0;
end
if isfield(opts,'ECGChannelCount');
    sidecar_eeg.ECGChannelCount=opts.ECGChannelCount;
else
    sidecar_eeg.ECGChannelCount=0;
end
sidecar_eeg.EEGReference='CMS';
if isfield(opts,'MiscChannelCount');
    sidecar_eeg.MiscChannelCount=opts.MiscChannelCount;
else
    sidecar_eeg.MiscChannelCount=0;
end
if isfield(opts,'TriggerChannelCount');
    sidecar_eeg.TriggerChannelCount=opts.TriggerChannelCount;
else
    sidecar_eeg.TriggerChannelCount=0;
end
if isfield(opts,'PowerLineFrequency');
    sidecar_eeg.PowerLineFrequency=opts.PowerLineFrequency;
end
if isfield(opts,'EEGPlacementScheme');
    sidecar_eeg.EEGPlacementScheme=opts.EEGPlacementScheme;
end
if isfield(opts,'Manufacturer');
    sidecar_eeg.Manufacturer=opts.Manufacturer;
end
if isfield(opts,'ManufacturerModelName');
    sidecar_eeg.ManufacturerModelName=opts.ManufacturerModelName;
end
if isfield(opts,'CapManufacturer');
    sidecar_eeg.CapManufacturer=opts.CapManufacturer;
end
if isfield(opts,'CapModelName');
    sidecar_eeg.CapModelName=opts.CapModelName;
end
if isfield(opts,'HardwareFilters');
    sidecar_eeg.HardwareFilters=opts.HardwareFilters;
end
if isfield(opts,'SoftwareFilters');
    sidecar_eeg.SoftwareFilters=opts.SoftwareFilters;
end

if EEG.trials==1;
    sidecar_eeg.RecordingType='continuous';
    sidecar_eeg.RecordingDuration=EEG.pnts*(1/EEG.srate);
else
    sidecar_eeg.RecordingType='epoched';
    sidecar_eeg.EpochLength=EEG.xmax-EEG.xmin;
    %to propose
    sidecar_eeg.EpochCount=EEG.trials;
end

if isfield(opts,'DeviceSoftwareVersion');
    sidecar_eeg.DeviceSoftwareVersion=opts.DeviceSoftwareVersion;
end
if isfield(opts,'SubjectArtefactDescription');
    sidecar_eeg.SubjectArtefactDescription=opts.SubjectArtefactDescription;
end
%to propose
if isfield(opts,'Category')
    sidecar_eeg.Category=opts.Category;
end

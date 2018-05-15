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
sidecar_eeg.EOGChannelCount='';
sidecar_eeg.EMGChannelCount='';
sidecar_eeg.EEGReference=EEG.ref;
sidecar_eeg.MiscChannelCount='';
sidecar_eeg.TriggerChannelCount='';
if isfield(opts,'PowerLineFrequency');
    sidecar_eeg.PowerLineFrequency='';
end
if isfield(opts,'EEGPlacementScheme');
    sidecar_eeg.EEGPlacementScheme='';
end
if isfield(opts,'Manufacturer');
    sidecar_eeg.Manufacturer='';
end
if isfield(opts,'ManufacturerModelName');
    sidecar_eeg.ManufacturerModelName='';
end
if isfield(opts,'CapManufacturer');
    sidecar_eeg.CapManufacturer='';
end
if isfield(opts,'CapModelName');
    sidecar_eeg.CapModelName='';
end
if isfield(opts,'HardwareFilters');
    sidecar_eeg.HardwareFilters='';
end
if isfield(opts,'SoftwareFilters');
    sidecar_eeg.SoftwareFilters='';
end

if EEG.trials==1;
    sidecar_eeg.RecordingType='continuous';
    sidecar_eeg.EpochLength='Inf';
    sidecar_eeg.RecordingDuration=EEG.pnts*(1/EEG.srate);
else
    sidecar_eeg.RecordingType='epoched';
    sidecar_eeg.EpochLength=EEG.xmax-EEG.xmin;
    %to propose
    sidecar_eeg.EpochCount=EEG.trials;
end

if isfield(opts,'DeviceSoftwareVersion');
    sidecar_eeg.DeviceSoftwareVersion='';
end
if isfield(opts,'SubjectArtefactDescription');
    sidecar_eeg.SubjectArtefactDescription='';
end
%to propose
if isfield(opts,'Category')
    sidecar_eeg.Category=opts.Category;
end

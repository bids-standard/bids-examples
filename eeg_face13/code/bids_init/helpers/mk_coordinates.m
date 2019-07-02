function outStr = mk_coordinates(EEG,fname)

% load current file only if it hasn't been loaded already
if ~exist('EEG','var') || (exist('EEG','var') && isempty(EEG)) || ...
  (~isempty(EEG) && ~strcmp(fname,[EEG.filepath '/' EEG.filename]));
    EEG = pop_loadset('filename',fname);
end

coordinates.EEGCoordinateSystem = 'Other';
coordinates.EEGCoordinateUnits = 'metres';

% Strange formatting fixed with strrep
intended = strrep(fname,'\','');
coordinates.IntendedFor = intended(3:end);

outStr = jsonencode(coordinates);
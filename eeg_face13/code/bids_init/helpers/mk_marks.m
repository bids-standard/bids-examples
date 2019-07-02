function [chan_struct,comp_struct,time_struct]=mk_marks(EEG,fname)

% load current file only if it hasn't been loaded already
if ~exist('EEG','var') || (exist('EEG','var') && isempty(EEG)) || ...
  (~isempty(EEG) && ~strcmp(fname,[EEG.filepath '/' EEG.filename]));
    EEG = pop_loadset('filename',fname);
end

if isfield(EEG,'marks');
  % Loop takes a deep copy of the structure but ignores the 'flags' field

  chan_struct = struct();
  
  for si = 1:length(EEG.marks.chan_info);
      for fn = fieldnames(EEG.marks.chan_info(si))'
          if ~strcmp('flags',fn)
              chan_struct(si).(fn{1}) = EEG.marks.chan_info(si).(fn{1});
          end
      end
  end

  comp_struct = struct();
  for si = 1:length(EEG.marks.comp_info);
      for fn = fieldnames(EEG.marks.comp_info)'
          if ~strcmp('flags',fn)
              comp_struct.(fn{1}) = EEG.marks.comp_info.(fn{1});
          end
      end
  end
  
  time_struct = struct();
  for si = 1:length(EEG.marks.time_info);
      for fn = fieldnames(EEG.marks.time_info)'
          if ~strcmp('flags',fn)
              time_struct.(fn{1}) = EEG.marks.time_info.(fn{1});
          end
      end
  end
  
end

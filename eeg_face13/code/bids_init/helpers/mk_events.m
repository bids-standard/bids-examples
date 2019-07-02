function events=mk_events(EEG,fname)

% load current file only if it hasn't been loaded already
if ~exist('EEG','var') || (exist('EEG','var') && isempty(EEG)) || ...
  (~isempty(EEG) && ~strcmp(fname,[EEG.filepath '/' EEG.filename]));
    EEG = pop_loadset('filename',fname);
end

disp(['Creating ' fname(1:end-8) '_events.tsv file...']);
events={'onset','duration','trial_type'};%response_time,stim_file,...
   
for i=1:length(EEG.event);
   events{i+1,1}=EEG.event(i).latency*(1/EEG.srate);
   if isfield(EEG.event(i),'duration');
       events{i+1,2}=EEG.event(i).duration*(1/EEG.srate); 
   else
       events{i+1,2}=0;
   end
   events{i+1,3}=EEG.event(i).type; 
end
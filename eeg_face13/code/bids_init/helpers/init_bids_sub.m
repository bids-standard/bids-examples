function init_bids_sub(EEG,rootfname,fnamesuf,varargin)

sidecar_eeg=mk_sidecar_eeg(EEG,[rootfname,fnamesuf,'.set'],varargin{:});
savejson('',sidecar_eeg,[rootfname,fnamesuf,'.json']);

channels=mk_channels(EEG,[rootfname,fnamesuf,'.set']);
cell2tsv([rootfname,fnamesuf,'_channels.tsv'],channels,'%s\t%s\t%s\n');

electrodes=mk_electrodes(EEG,[rootfname,fnamesuf,'.set']);
cell2tsv([rootfname,fnamesuf,'_electrodes.tsv'],electrodes,'%s\t%5.3f\t%5.3f\t%5.3f\t%s\t%s\n');

coordinates=mk_coordinates(EEG,[rootfname,fnamesuf,'.set']);
fID = fopen([rootfname,fnamesuf,'_coordinates.json'],'w');
fprintf(fID,'%s',coordinates);
fclose(fID);

events=mk_events(EEG,[rootfname,fnamesuf,'.set']);
cell2tsv([rootfname,fnamesuf,'_events.tsv'],events,'%5.3f\t%5.3f\t%s\n');

if isfield(EEG,'marks');
    [chan_struct,comp_struct,time_struct]=mk_marks(EEG,[rootfname,fnamesuf,'.set']);
    savejson('',chan_struct,[rootfname,fnamesuf,'_chan_info.json']);
    savejson('',comp_struct,[rootfname,fnamesuf,'_comp_info.json']);
    savejson('',time_struct,[rootfname,fnamesuf,'_time_info.json']);
end

if ~isempty(EEG.icaweights)
    dlmwrite([rootfname,fnamesuf,'_icaweights.tsv'],{EEG.icaweights},'\t');
    dlmwrite([rootfname,fnamesuf,'_icasphere.tsv'],{EEG.icasphere},'\t');
end
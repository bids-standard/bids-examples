function participants=mk_participants(filename)

disp('Creating participants.tsv file...');
participants={'participant_id','age','sex','group'}; % participant demographics data
sub_dirs = dir('bids/sub-*');
for i=1:length(sub_dirs);
    % find set file in current directory:
    disp(['Searching ' sub_dirs(i).name ' for .set files...']);
    fileinfo = dir(['bids/',sub_dirs(i).name,'/eeg/*.set']);
    if length(fileinfo)>1;
        disp(['WARNING: Found multiple files for ' sub_dirs(i).name '!']);
        disp('The _eeg.set file will be used, if exists...');
        fileinfo = dir(['bids/',sub_dirs(i).name,'/eeg/*eeg.set']);
    end
    if isempty(fileinfo);
        disp(['Could not find _eeg.set file... ignoring ' sub_dirs(i).name '.']);
        continue;
    else
        disp(['Found ' fileinfo.name ' file...']);
    end
    if iscell(fileinfo);
        fname = cellstr(fileinfo.name); % get filename into cellstr
    else
        fname = cellstr(cellstr({fileinfo.name}));
    end
    % grab string from cellstr and add full path:
    fname = strcat('bids/',sub_dirs(i).name,'/eeg/',fname);
    participant = mk_participant(fname);
    participants = vertcat(participants,participant);
end

fid = fopen(filename,'w');
for i=1:length(participants);
    p = transpose(participants(i,:));
    fprintf(fid,'%s\t%s\t%s\t%s\n',p{:});
    fseek(fid, 0, 'eof');
end
fclose(fid);

end

function init_bids_all(rootdir,fnamesuf,varargin)

if nargin<2
   if ~exist('rootdir','var');
       rootdir='';
   end
   if ~exist('fnamesuf','var');
       fnamesuf='';
   end
end
%init_bids;
sub_dirs = dir([rootdir,'/sub*']);
for i=1:length(sub_dirs); % iterate through all subject directories
    % find set file in current directory:
    disp(['Searching ' sub_dirs(i).name ' for .set files...']);
    fileinfo = dir([rootdir,'/',sub_dirs(i).name,'/eeg/*.set']);
     if length(fileinfo)>1;
%         disp(['WARNING: Found multiple files for ' sub_dirs(i).name '!']);
%         disp('The _eeg.set file will be used, if exists...');
         fileinfo = dir([rootdir,'/',sub_dirs(i).name,'/eeg/*eeg',fnamesuf,'.set']);
     end
%     if isempty(fileinfo);
%         disp(['Could not find _eeg,',fnamesuf,'.set file... ignoring ' sub_dirs(i).name '.']);
%         continue;
%     else
%         disp(['Found ' fileinfo.name ' file...']);
%     end
    fname_cell = cellstr(fileinfo.name); % get filename into cellstr
    % grab string from cellstr and add full path:
    fname = strcat(rootdir,'/',sub_dirs(i).name,'/eeg/',fname_cell{1});
    EEG = pop_loadset('filename',fname);
    swap_ind = strfind(fname,'_eeg'); % find indices of all '_' chars
    if ~isempty(swap_ind);
        swap_ind = swap_ind(end); % find final '_' character
        rootfname = fname(1:swap_ind-1+4); % strip chars right of the final '_'
    end
    % if filename doesn't end with _eeg.set:
%    if ~strcmp(EEG.filename(end-7:end),'_eeg.set');
%        disp(['Changing filename to ' fname '_eeg.set...']);
%        EEG = pop_saveset(EEG,strcat(fname,'_eeg.set'));
%    end   
   init_bids_sub(EEG,rootfname,fnamesuf,varargin{:});
end
disp('Done.');
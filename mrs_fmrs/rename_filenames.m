% Rename filenames

clear_all;

% Set environment variable for conda packages
PATH = getenv('PATH');
setenv('PATH', [PATH ':/Users/mmikkel5/opt/anaconda3/bin']);

% Set the main data directory
main_dir = '/Users/mmikkel5/Documents/GitHub/bids-examples-mm/mrs_fmrs';

%% T1w files

% cd(main_dir);
%
% flist = dir(fullfile('**/*.nii'));
%
% for ii = 1:length(flist)
%     if ii < 10
%         movefile(fullfile(flist(ii).folder, flist(ii).name), fullfile(flist(ii).folder, ['sub-0' num2str(ii) '_T1w.nii.gz']));
%     else
%         movefile(fullfile(flist(ii).folder, flist(ii).name), fullfile(flist(ii).folder, ['sub-' num2str(ii) '_T1w.nii.gz']));
%     end
%
% end

%% Rename subject folders

% cd(main_dir);
%
% flist = dir;
% flist = flist(~contains({flist.name}, {'.','..','.DS_Store'}));
%
% for ii = 1:length(flist)
%     if isfolder(fullfile(flist(ii).folder, flist(ii).name))
%         if ii < 10
%             movefile(fullfile(flist(ii).folder, flist(ii).name), fullfile(flist(ii).folder, ['sub-0' num2str(ii)]));
%         else
%             movefile(fullfile(flist(ii).folder, flist(ii).name), fullfile(flist(ii).folder, ['sub-' num2str(ii)]));
%         end
%     end
% end

%% Move sdat/spar files into mrs folder

% cd(main_dir);
%
% flist = dir;
% flist = flist(~contains({flist.name}, {'.','..','.DS_Store','LICENSE'}));
%
% for ii = 1:length(flist)
%     if isfolder(fullfile(flist(ii).folder, flist(ii).name))
%         cd(fullfile(flist(ii).folder, flist(ii).name))
%         if ~exist('mrs','dir')
%             mkdir('mrs');
%         end
%         movefile('GLUPI*', 'mrs');
%     end
% end

%% Convert to NIfTI-MRS

cd(main_dir);
dir_list = dir("sub-*");

for ii = 1:length(dir_list)
    cd(fullfile(dir_list(ii).folder, dir_list(ii).name, 'mrs'))
    sdat = dir("*sdat");
    spar = dir("*spar");

    if isempty(sdat)
        continue
    end

    for jj = 1:length(sdat)
        sdat_file = [sdat(jj).folder, filesep, sdat(jj).name];
        spar_file = [spar(jj).folder, filesep, spar(jj).name];
        command = ['spec2nii philips ' sdat_file ' ' spar_file];
        system(command);
        if startsWith(sdat(jj).name, "GLUPI_WIP_SV_PRESS_BASELINE") && endsWith(sdat(jj).name, "act_noID.SDAT")
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_task-baseline_svs.nii.gz']);
        elseif startsWith(sdat(jj).name, "GLUPI_WIP_SV_PRESS_BASELINE") && endsWith(sdat(jj).name, "ref_noID.SDAT")
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_task-baseline_ref.nii.gz']);
        elseif startsWith(sdat(jj).name, "GLUPI_WIP_SV_PRESS_DYN") && endsWith(sdat(jj).name, "act_noID.SDAT")
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_task-pain_svs.nii.gz']);
        elseif startsWith(sdat(jj).name, "GLUPI_WIP_SV_PRESS_DYN") && endsWith(sdat(jj).name, "ref_noID.SDAT")
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_task-pain_ref.nii.gz']);
        end
    end
end

cd(main_dir);




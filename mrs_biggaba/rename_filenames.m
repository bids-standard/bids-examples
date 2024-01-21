% Rename filenames

clear_all;

% Set environment variable for conda packages
PATH = getenv('PATH');
setenv('PATH', [PATH ':/Users/mmikkel5/opt/anaconda3/bin']);

% Set the main data directory
main_dir = '/Users/mmikkel5/Documents/GitHub/bids-examples-mm/mrs_biggaba';

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

%% PRESS files

% cd(main_dir);
% dir_list = dir("sub-*");
% 
% for ii = 1:length(dir_list)
%     cd(fullfile(dir_list(ii).folder, dir_list(ii).name, 'mrs'))
%     sdat = dir("*PRESS*sdat");
%     spar = dir("*PRESS*spar");
% 
%     for jj = 1:length(sdat)
%         sdat_file = [sdat(jj).folder, filesep, sdat(jj).name];
%         spar_file = [spar(jj).folder, filesep, spar(jj).name];
%         command = ['spec2nii philips ' sdat_file ' ' spar_file];
%         system(command);
%         if contains(sdat(jj).name, 'act.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-press_svs.nii.gz']);
%         elseif contains(sdat(jj).name, 'ref.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-press_ref.nii.gz']);
%         end
%     end
% end
% 
% cd(main_dir);

%% GABA TE = 68 files

% cd(main_dir);
% dir_list = dir("sub-*");
% 
% for ii = 1:length(dir_list)
%     cd(fullfile(dir_list(ii).folder, dir_list(ii).name, 'mrs'))
%     sdat = dir("*GABA_68*sdat");
%     spar = dir("*GABA_68*spar");
% 
%     for jj = 1:length(sdat)
%         sdat_file = [sdat(jj).folder, filesep, sdat(jj).name];
%         spar_file = [spar(jj).folder, filesep, spar(jj).name];
%         command = ['spec2nii philips ' sdat_file ' ' spar_file];
%         system(command);
%         if contains(sdat(jj).name, 'act.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-mega68_svs.nii.gz']);
%         elseif contains(sdat(jj).name, 'ref.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-mega68_ref.nii.gz']);
%         end
%     end
% end
% 
% cd(main_dir);

%% GABA TE = 80 files

% cd(main_dir);
% dir_list = dir("sub-*");
% 
% for ii = 1:length(dir_list)
%     cd(fullfile(dir_list(ii).folder, dir_list(ii).name, 'mrs'))
%     sdat = dir("*GABA_80*sdat");
%     spar = dir("*GABA_80*spar");
% 
%     for jj = 1:length(sdat)
%         sdat_file = [sdat(jj).folder, filesep, sdat(jj).name];
%         spar_file = [spar(jj).folder, filesep, spar(jj).name];
%         command = ['spec2nii philips ' sdat_file ' ' spar_file];
%         system(command);
%         if contains(sdat(jj).name, 'act.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-mega80_svs.nii.gz']);
%         elseif contains(sdat(jj).name, 'ref.sdat', 'IgnoreCase', true)
%             movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-mega80_ref.nii.gz']);
%         end
%     end
% end
% 
% cd(main_dir);

%% HERMES GSH-Lac files

cd(main_dir);
dir_list = dir("sub-*");

% for ii = 1:length(dir_list)
for ii = 1
    cd(fullfile(dir_list(ii).folder, dir_list(ii).name, 'mrs'))
    sdat = dir("*HERMES_GSH_Lac*sdat");
    spar = dir("*HERMES_GSH_Lac*spar");

    if isempty(sdat)
        continue
    end

    for jj = 1:length(sdat)
        sdat_file = [sdat(jj).folder, filesep, sdat(jj).name];
        spar_file = [spar(jj).folder, filesep, spar(jj).name];
        command = ['spec2nii philips ' sdat_file ' ' spar_file];
        system(command);
        if contains(sdat(jj).name, 'act.sdat', 'IgnoreCase', true)
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-hermesGSHLac_svs.nii.gz']);
        elseif contains(sdat(jj).name, 'ref.sdat', 'IgnoreCase', true)
            movefile([sdat(jj).name(1:end-5) '.nii.gz'], [dir_list(ii).name '_acq-hermesGSHLac_ref.nii.gz']);
        end
    end
end

cd(main_dir);




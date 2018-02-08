
% This is new version run for Roni, using latest maxfilter commands,
% resulting in _transdef ending (intermediate _trans is deleted).
%
% Note in maxfilter_files_old.m:
%      *_sss has trans default (but centre of sphere not optimal, because set to trans default optimum?)
%      *_tsss has trans first (and log and pos files come from this run)

%owd = '/home/rh01/DanData';
dat_wd = '/imaging/dw01/faces_study/meg';
bas_wd = '/imaging/rh01/Collaborations/Dan/AllData';

isubj = [1 2 3 5 6 8 9 10 11 12 14 15 16 17 18 19 23 24 25]; %s1 incomplete data
%isubj = [2 3 5 8 9 10 11 12 14 15 16 17 18 23 24 25]; 
MaxNsubs = numel(isubj)

%----------------------

basestr = ' -ctc /neuro/databases/ctc/ct_sparse.fif -cal /neuro/databases/sss/sss_cal.dat';
basestr = [basestr ' -linefreq 50 -hpisubt amp'];
basestr = [basestr ' -force'];  % care!!!
%basestr = [basestr ' -ds 4'];
maxfstr = '!/neuro/bin/util/x86_64-pc-linux-gnu/maxfilter-2.2.12 '

addpath /imaging/local/meg_misc
addpath /neuro/meg_pd_1.2/


%% open matlabpool if required
% matlabpool close force CBU_Cluster
if matlabpool('size')==0;
    P = cbupool(MaxNsubs);
    matlabpool(P);
end

midrun = 4; % middle run for trans "across runs within subject" below

parfor s = 1:MaxNsubs
    
    sub_wd = fullfile(bas_wd,sprintf('subject_%02d',isubj(s));
    try rik_eval(sprintf('!mkdir %s',sub_wd)); end
    cd(sub_wd)
    
    movfile = 'trans_move.txt';
    rik_eval(sprintf('!touch %s',movfile));
    
    for run = 1:6
        
        rawfile = sprintf('%s/subject_%02d/raw/run_%02d_raw.fif',dat_wd,isubj(s),run);
        
        success=0; inc=0; incEEG = 1;
        while ~success % fit sphere doesn't change with run, but some files cause hpipoints error!
            fitfile = sprintf('%s/subject_%02d/raw/run_%02d_raw.fif',dat_wd,isubj(s),run+inc);
            try delete(fullfile(sub_wd,'fittmp.txt')); delete(fullfile(wd,sprintf('run_%02d_hpi.txt',run+inc))); end
            try
                [orig,rad,fit] = meg_fit_sphere(fitfile,sub_wd,sprintf('ses_%02d_hpi.txt',run+inc),incEEG);
                success=1;
            catch
                inc=inc+1;
            end
            delete(fullfile(sub_wd,'fittmp.txt'));
        end
        origstr = sprintf(' -origin %d %d %d -frame head',orig(1),orig(2),orig(3));
        
        %% 1. Bad channel detection
        outfile = fullfile(sub_wd,sprintf('run_%02d_bad',run));
        filestr = sprintf(' -f %s -o %s.fif',rawfile,outfile);
        finstr = [maxfstr filestr origstr basestr sprintf(' -autobad 2000 -v | tee %s.log',outfile)]       % 2000s should be 33mins - ie all data!
        rik_eval(finstr);
        delete(sprintf('%s.fif',outfile));
        
        % Pull out bad channels from logfile:
        badfile = sprintf('%s.txt',outfile);
        rik_eval(sprintf('!cat %s.log | sed -n -e ''/Detected/p'' -e ''/Static/p'' | cut -f 5- -d '' '' > %s',outfile,badfile));
        
        tmp=dlmread(badfile,' ');
        tmp=reshape(tmp,1,prod(size(tmp)));
        tmp=tmp(tmp>0); % Omit zeros (padded by dlmread):
        
        % Get frequencies (number of buffers in which chan was bad):
        [frq,allbad] = hist(tmp,unique(tmp));
        
        % Mark bad based on threshold (currently ~5% of buffers (assuming 500 buffers)):
        badchans = allbad(frq>0.05*500);
        if isempty(badchans)
            badstr = '';
        else
            badstr = sprintf(' -bad %s',num2str(badchans))
        end
        
        %% 2. 1-step SSS+trans
        %         outfile = fullfile(sub_wd,sprintf('run_%02d_sss',run));
        %         filestr = sprintf(' -f %s -o %s.fif',rawfile,outfile);
        %
        %         tSSSstr = ' -st 10 -corr 0.98';
        %         posfile = fullfile(sub_wd,sprintf('run_%02d_headpos.txt',run));
        %         compstr = sprintf(' -movecomp inter -hpistep 10 -hp %s',posfile);
        %
        %         transtr = sprintf(' -trans default -origin %d %d %d -frame head',orig(s,:)+[0 -13 6]);
        % %        transtr = sprintf(' -trans %s -frame head',fullfile(dat_wd,cbu_codes{g}{s},raw_wd.name,raw_files(ceil(length(raw_files)/2)).name));
        % %        transtr = '';
        
        %% 2-step SSS then trans
        %
        %% 2. tSSS and trans across runs within subject
        
        outfile = fullfile(sub_wd,sprintf('run_%02d_trans',run));
        tSSSstr = ' -st 10 -corr 0.98';
        posfile = fullfile(sub_wd,sprintf('run_%02d_headpos.txt',run));
        compstr = sprintf(' -movecomp inter -hpistep 10 -hp %s',posfile);
        
        if run == midrun % Middle run - no need to trans anywhere
            transtr = '';
        else
            transtr = sprintf(' -trans %s',sprintf('%s/subject_%02d/raw/run_%02d_raw.fif',dat_wd,isubj(s),midrun));
        end
        
        filestr = sprintf(' -f %s -o %s.fif',rawfile,outfile);
        finstr = [maxfstr filestr basestr badstr tSSSstr compstr origstr transtr sprintf(' -v | tee %s.log',outfile)]
        rik_eval(finstr);
        
        if run == midrun % Middle run - no need to trans anywhere
            rik_eval(sprintf('!echo ''0 mm'' >> %s',movfile));
        else
            rik_eval(sprintf('!cat %s.log | sed -n ''/Position change/p'' | cut -f 7- -d '' '' >> %s',outfile,movfile));
        end
        
        %% 3. trans to default helmet position (for across-subject)
        
        infile = outfile;
        outfile = fullfile(sub_wd,sprintf('run_%02d_transdef',run));
        
        transtr = sprintf(' -trans default -origin %d %d %d -frame head -force',orig+[0 -13 6]);
        
        filestr = sprintf(' -f %s.fif -o %s.fif',infile,outfile);
        finstr = [maxfstr filestr transtr sprintf(' -v | tee %s.log',outfile)]
        rik_eval(finstr);
        
        if run == length(raw_files)
            rik_eval(sprintf('!echo ''Transd...'' >> %s',movfile));
            rik_eval(sprintf('!cat %s.log | sed -n ''/Position change/p'' | cut -f 7- -d '' '' >> %s',outfile,movfile));
        end
        delete(infile);
        
        % Danny's approach to trans default first, then tSSS
        %         transtr = sprintf(' -trans %s -origin %d %d %d -frame head',tmpfile,orig(s,:));
        %         outfile = fullfile(sub_wd,sprintf('run_%02d_sss',run));
        %         tSSSstr = ' -st 10 -corr 0.98';
        %         posfile = fullfile(sub_wd,sprintf('run_%02d_headpos.txt',run));
        %         compstr = sprintf(' -movecomp inter -hpistep 10 -hp %s',posfile);
        %
        %         transtr = sprintf(' -trans default -origin %d %d %d -frame head',orig(s,:)+[0 -13 6]);
        %
        %         tmpfile = fullfile(sub_wd,sprintf('run_%02d_tmp.fif',run));
        %         filestr = sprintf(' -f %s -o %s',rawfile,tmpfile);
        %         finstr = [maxfstr filestr basestr tSSSstr compstr transtr sprintf(' -v | tee %s.log',outfile)]
        %         rik_eval(finstr);
        %
        %         transtr = sprintf(' -trans %s -origin %d %d %d -frame head',tmpfile,orig(s,:));
        %
        %         filestr = sprintf(' -f %s -o %s.fif',rawfile,outfile);
        %         finstr = [maxfstr filestr basestr tSSSstr compstr transtr sprintf(' -v | tee %s.log',outfile)]
        %         rik_eval(finstr);
        %
        %         delete(tmpfile);
    end
end



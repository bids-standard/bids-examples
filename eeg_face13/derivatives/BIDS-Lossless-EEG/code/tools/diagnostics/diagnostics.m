function diagnostics(ALLEEG,type)
% diagnostics(ALLEEG,type) - Creates figures to aid user in understanding
% the generated marks, and the overal quality of the data.
%
% Required Inputs:
%   ALLEEG  = the ALLEEG structure resulting from loading single or multiple
%             eeg *.set files.
%   type    = 'single' or 'study', single will resault in many detailed
%             plots about the currently selected EEG set. Study will
%             display more broad plots summarizing all of the loaded files.
%
% Usage:
%       diagnostics(ALLEEG,'study');
%
% Notes:
%   This function only works on completed dipfit data at the moment. A future
%   version will be compatibple with ASR marks.
% See also: dipfit.htb

%Copyright (C) 2017 BUCANL
%
%Code originally written by James A. Desjardins with contributions from 
%Allan Campopiano and Andrew Lofts, supported by NSERC funding to 
%Sidney J. Segalowitz at the Jack and Nora Walker Canadian Centre for 
%Lifespan Development Research (Brock University), and a Dedicated Programming 
%award from SHARCNet, Compute Ontario.
%
%This program is free software; you can redistribute it and/or modify
%it under the terms of the GNU General Public License as published by
%the Free Software Foundation; either version 2 of the License, or
%(at your option) any later version.
%
%This program is distributed in the hope that it will be useful,
%but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License
%along with this program (LICENSE.txt file in the root directory); if not, 
%write to the Free Software Foundation, Inc., 59 Temple Place,
%Suite 330, Boston, MA  02111-1307  USA

%% Call for study subject diagnostics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(type,'study')
    
    %% Channels
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(ALLEEG)
        % Divide by b1 to make %s
        ball = length(ALLEEG(i).marks.chan_info(1).flags);                   % All time
        b2 = length(find(ALLEEG(i).marks.chan_info(2).flags))/ball;          % 2
        b3 = length(find(ALLEEG(i).marks.chan_info(3).flags))/ball;          % 3
        b4 = length(find(ALLEEG(i).marks.chan_info(4).flags))/ball;          % 4
        bnm = 1-b2-b3-b4;                                                    % not manual/remaining
        
        bdata1(i,:) = [bnm,b2,b3,b4];
    end
    
        % BAR CHART
            figure;
        ax1 = subplot(2,1,1);
        bar(ax1,1:length(ALLEEG),bdata1(:,:),'stacked','Horizontal','on');colormap(jet);
        title('Channel Designation'); xlabel('% of Channels (Sum to 100%)'); ylabel('Subject Number');
        legend({'Remaining Channels','Comically Bad','Low Correlation','Bridged'});
        %axis([0 1 0 (length(EEG.reject.probabilities) + 1)]);
       
    %% Time
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(ALLEEG)
        % Divide by b1 to make %s
        ball = length(ALLEEG(i).marks.time_info(1).flags);                   % All time
        b2 = length(find(ALLEEG(i).marks.time_info(2).flags))/ball;          % 2
        b3 = length(find(ALLEEG(i).marks.time_info(3).flags))/ball;          % 3
        b4 = length(find(ALLEEG(i).marks.time_info(4).flags))/ball;          % 4
        b6 = length(find(ALLEEG(i).marks.time_info(6).flags))/ball;          % 6
        b10 = length(find(ALLEEG(i).marks.time_info(10).flags))/ball;        % 10
        bnm = 1-b2-b3-b4-b6-b10;                                             % not manual/remaining
        
        bdata2(i,:) = [bnm,b2,b3,b4,b6,b10];
    end
        
        % BAR CHART
        ax2 = subplot(2,1,2);
        bar(ax2,1:length(ALLEEG),bdata2(:,:),'stacked','Horizontal','on');colormap(jet);
        title('Time Designation'); xlabel('% of Time (Sum to 100%)'); ylabel('Subject Number');
        legend({'Remaining Channels','Out Task','Marks Gap','Low Correlation','IC SD 1','IC SD 2'});
        %axis([0 1 0 (length(EEG.reject.probabilities) + 1)]);
              
    %% ASR CORRECTION
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Amount of datd that was ASR corrected    
        
    %% Components - 1 - Marks
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure;
    for i = 1:length(ALLEEG)
        % Divide by b1 to make %s
        ball = length(ALLEEG(i).marks.comp_info(1).flags);                   % All time
        bnm = (ball - length(find(ALLEEG(i).marks.comp_info(1).flags)))/ball;       % not manual/remaining
        b2 = (length(find(ALLEEG(i).marks.comp_info(2).flags)))/ball;          % 2
        b3 = (length(find(ALLEEG(i).marks.comp_info(3).flags)))/ball;          % 3
        bb = abs(1 - bnm - b2 - b3);
        b2 = b2 - bb;
        b3 = b3 - bb;
        bdata3(i,:) = [bnm,b2,b3,bb];
    end
        
        % BAR CHART
        ax3 = subplot(2,1,1);
        bar(ax3,1:length(ALLEEG),bdata3(:,:),'stacked','Horizontal','on');colormap(jet);
        title('Component Designation'); xlabel('% of Components (Sum to 100%)'); ylabel('Subject Number');
        legend({'Remaining Components','Not Replicated','Dipole Matching', 'Both reasons'});
        %axis([0 1 0 (length(EEG.reject.probabilities) + 1)]);
        
    %% Components - 2 - ICMARC
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(ALLEEG)
        % Divide by ball for %
        ball = length((ALLEEG(i).reject.classtype == 1));
        b1 = length(find(ALLEEG(i).reject.classtype == 1))/ball;
        b2 = length(find(ALLEEG(i).reject.classtype == 2))/ball;
        b3 = length(find(ALLEEG(i).reject.classtype == 3))/ball;
        b4 = length(find(ALLEEG(i).reject.classtype == 4))/ball;
        b5 = length(find(ALLEEG(i).reject.classtype == 5))/ball;
        b6 = length(find(ALLEEG(i).reject.classtype == 6))/ball;
    
        bdata4(i,:) = [b1,b2,b3,b4,b5,b6];
    end
        
        % BAR CHART
        ax4 = subplot(2,1,2);
        bar(ax4,1:length(ALLEEG),bdata4(:,:),'stacked','Horizontal','on');colormap(jet);
        title('ICMARC Classification'); xlabel('% of Components (Sum to 100%)'); ylabel('Subject Number');
        legend({ 'blink','neural','heart','lateye','muscle','mixed'});
        %axis([0 1 0 (length(EEG.reject.probabilities) + 1)]);
        
end



%% Call for single subject diagnostics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if  strcmp(type,'single')

    EEG = ALLEEG(1);
    
    %% Channels removed
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('\nChannels\n');
    fprintf('==================================================\n');
    for j = 1:length(EEG.marks.chan_info) 
        %just flags
        x = length(find(EEG.marks.chan_info(j).flags));
        % All chans
        y = length(EEG.marks.chan_info(j).flags);
        disp(['Flagged: ' num2str(x) '/' num2str(y) ' Channels for ' EEG.marks.chan_info(j).label]);
    end

    % outtask vs manual vs time remaining piechart
    c1 = length(EEG.marks.chan_info(1).flags);                % All time
    c2 = length(find(EEG.marks.chan_info(2).flags));          % 2
    c3 = length(find(EEG.marks.chan_info(3).flags));          % 3
    c4 = length(find(EEG.marks.chan_info(4).flags));          % 4
    cm = length(find(EEG.marks.chan_info(1).flags));          % 5
    c1 = c1-cm;                                               % Remaining All time
    cpie = [c1 c2 c3 c4];
    figure;
    explode = [1 0 0 0];
    ax1 = subplot(1,2,1);
    labels = {'Remaining Channels','Comically Bad','Low Correlation','Bridged'};
    pie(ax1,cpie,explode,labels); colormap(jet);
    title('Data Channel Classification');

    %% Time removed
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('\nTime\n');
    fprintf('==================================================\n');
    for j = 1:length(EEG.marks.time_info) 
        %just flags
        x = length(find(EEG.marks.time_info(j).flags));
        % All time
        y = length(EEG.marks.time_info(j).flags);
        disp(['Flagged: ' num2str((x/y)*100) ' % of Time for ' EEG.marks.time_info(j).label]);
    end

    % outtask vs manual vs time remaining piechart
    c1 = length(EEG.marks.time_info(1).flags);                % All time
    c2 = length(find(EEG.marks.time_info(2).flags));          % 2 Out Task
    c3 = length(find(EEG.marks.time_info(3).flags));          % 3
    c4 = length(find(EEG.marks.time_info(4).flags));          % 4
    c5 = length(find(EEG.marks.time_info(6).flags));          % 6
    c6 = length(find(EEG.marks.time_info(10).flags));         % 10
    cm = length(find(EEG.marks.time_info(1).flags));          % manual
    c1 = c1-cm;                                   % Remaining All time
    cpie = [c1 c2 c3 c4 c5 c6];
    explode = [1 1 0 0 0 0];
    ax2 = subplot(1,2,2);
    labels = {'Remaining Time Data','sd of volt','Mark Gap','Low Correlation','ICA SD 1','ICA SD 2'};
    pie(ax2,cpie,explode,labels); colormap(hot);
    title('Data Time Classification');

    %% Components
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('\nICA Components\n');
    fprintf('==================================================\n');
    disp(['Identified ' num2str(min(size(EEG.icaweights))) ' components from ' num2str(length(EEG.icachansind)) ' channels']);

    % PIE CHART
    c1 = length(find(EEG.reject.classtype == 1));
    c2 = length(find(EEG.reject.classtype == 2));
    c3 = length(find(EEG.reject.classtype == 3));
    c4 = length(find(EEG.reject.classtype == 4));
    c5 = length(find(EEG.reject.classtype == 5));
    c6 = length(find(EEG.reject.classtype == 6));
    cpie = [c1 c2 c3 c4 c5 c6];
    figure;
    ax1 = subplot(1,2,1);
    explode = [0 1 0 0 0 0];
    labels = { 'blink','neural','heart','lateye','muscle','mixed'};
    pie(ax1,cpie,explode,labels);colormap(jet);
    title('Component Majority Classifications');

    % BAR CHART
    ax2 = subplot(1,2,2);
    bar(ax2,1:length(EEG.reject.probabilities),EEG.reject.probabilities(:,:),'stacked','Horizontal','on');colormap(jet);
    title('Component Composistion'); xlabel('% Composition (Sum to 100%)'); ylabel('Component Number');
    axis([0 1 0 (length(EEG.reject.probabilities) + 1)]);

    % MULTI PIE CHART
    % figure;
    % for j = 1:size(EEG.reject.probabilities,1)
    %     s1 = EEG.reject.probabilities(j,:);
    %     explode = [0 0 0 0 0 0];
    %     explode(find((EEG.reject.probabilities(4,:))==(max(EEG.reject.probabilities(4,:))))) = 1;
    %     labels = { 'B','N','H','LE','M','Mix'};
    %     ax1 = subplot(10,10,j);
    %     pie(s1,explode,labels);colormap(jet);
    %     title(ax1,['Channel: ' num2str(j)]);
    % end

    %% Correlations
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('\nICA Correlations\n');
    fprintf('==================================================\n');

    % channel x epoch
    % figure;
    % for j = 1:size(EEG.icaact_sd_t,2)
    %     hold on;
    %     scatter(1:size(EEG.icaact_sd_t,2),EEG.icaact_sd_t(j,:));
    % end
    % 
    % 
    % figure;
    % for j = 1:size(EEG.icaact_sd_t,2)
    %     hold on;
    %     scatter(1:size(EEG.c_icaact_sd_t,2),EEG.c_icaact_sd_t(j,:));
    % end
    
    %% Standard deviation (mc_data_sd_ch)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data
    z1 = EEG.data_sd_ch;  
    z1(z1>100) = 100;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(1,3,1);
    surf(ax1,z1,'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Standard Deviations'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);
    ax2 = subplot(1,3,2);
    surf(ax2,EEG.c_data_sd_ch,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data
        x = mean(EEG.c_data_sd_ch,2);   % Average of flags
        y = 1:size(EEG.c_data_sd_ch,1); % Channels
        x(:,2) = 0.1;                   % 10% crit in config
    ax3 = subplot(1,3,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('% 0f Channel Flagged'); ylabel('Channel Number');
    axis([-0.05 1 0 (length(x + 1))]);

    %% Correlation by channel (mc_data_r_ch)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data
    z1 = EEG.data_r_ch;  
    z1(z1>100) = 100;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(1,4,1);
    surf(ax1,z1,'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Channel Correlations'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(1,4,2);
    surf(ax2,EEG.c_data_r_ch,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        x = mean(EEG.c_data_r_ch,2);   % Average of flags
        y = 1:size(EEG.c_data_r_ch,1); % Channels
        x(:,2) = 0.1;                    % 10% crit in config
    ax3 = subplot(1,4,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('% 0f Channel Flagged'); ylabel('Channel Number');
    axis([-0.05 1 0 (length(x + 1))]);

    % bridge measure
    mr = mean(fisherz(EEG.data_r_ch),2);
    sr = std(fisherz(EEG.data_r_ch),[],2);
    x = mr./sr;
    y = 1:size(EEG.c_data_r_ch,1); % Channels
    x(:,2) = zeros(size(x(:,1)))+(ve_trimmean(x(:,1),20)+ve_trimstd(x(:,1),20)*6);                    % 10% crit in config
    ax3 = subplot(1,4,4);
    plot(ax3,x,y); 
    title('mean corr/sd'); xlabel('corr mean/sd'); ylabel('Channel Number');
    axis([-0.05 max(x(:,1))+5 0 (length(x + 1))]);

    %% Standard Deviation of activation by Time (mc_data_r_t)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data
    z1 = EEG.data_sd_t;  
    z1(z1<0.5) = 0.5;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(3,1,1);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Time Standard deviation of activation'); xlabel('Epoch Number'); ylabel('Channel Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,1,2);
    surf(ax2,EEG.c_data_sd_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_data_sd_t,1);   % Average of flags
        x = 1:size(EEG.c_data_sd_t,2); % Channels
        y(2,:) = 0.2;                     % 20% crit in config
    ax3 = subplot(3,1,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% Correlation by Time (mc_data_r_t)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data
    z1 = EEG.data_r_t;  
    z1(z1<0.5) = 0.5;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(3,1,1);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Time Cross Electrode Correlation'); xlabel('Epoch Number'); ylabel('Channel Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,1,2);
    surf(ax2,EEG.c_data_r_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Channel Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_data_r_t,1);   % Average of flags
        x = 1:size(EEG.c_data_r_t,2); % Channels
        y(2,:) = 0.2;                     % 20% crit in config
    ax3 = subplot(3,1,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% first IC_SD by Time (mc_icaact_sd_t)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % EEG.icaact_sd1_t      EEG.c_icaact_sd1_t
    % EEG.icaact_sd2_t      EEG.c_icaact_sd2_t
    % EEG.icaact_sd1asr_t   EEG.c_icaact_sd1asr_t
    % EEG.icaact_sd2asr_t   EEG.c_icaact_sd2asr_t

    % Data
    z1 = EEG.icaact_sd1_t;  
    z1(z1>2) = 2.236;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(3,1,1);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Time Component Standard Deviation'); xlabel('Epoch Number'); ylabel('Component Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,1,2);
    surf(ax2,EEG.c_icaact_sd_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Component Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_icaact_sd_t,1);   % Average of flags
        x = 1:size(EEG.c_icaact_sd_t,2); % Channels
        y(2,:) = 0.1;                      % 10% crit in config
    ax3 = subplot(3,1,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% second IC_SD by Time (mc_icaact_sd_t)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % EEG.icaact_sd1_t      EEG.c_icaact_sd1_t
    % EEG.icaact_sd2_t      EEG.c_icaact_sd2_t
    % EEG.icaact_sd1asr_t   EEG.c_icaact_sd1asr_t
    % EEG.icaact_sd2asr_t   EEG.c_icaact_sd2asr_t

    % Data
    z1 = EEG.icaact_sd2_t;  
    z1(z1>2) = 2.236;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(3,1,1);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Time Component Standard Deviation'); xlabel('Epoch Number'); ylabel('Component Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,1,2);
    surf(ax2,EEG.c_icaact_sd2_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Component Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_icaact_sd2_t,1);   % Average of flags
        x = 1:size(EEG.c_icaact_sd2_t,2); % Channels
        y(2,:) = 0.1;                      % 10% crit in config
    ax3 = subplot(3,1,3);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% Alpha Power
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Data
    z1 = EEG.icaact_ta_t;  
    z1(z1>100) = 100;        % Cap

    % Surface Plot
    figure;
    ax1 = subplot(3,2,1);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Component Alpha Power'); xlabel('Epoch Number'); ylabel('Component Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,2,3);
    surf(ax2,EEG.c_icaact_ta_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Component Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_icaact_ta_t,1);   % Average of flags
        x = 1:size(EEG.c_icaact_ta_t,2); % Channels
        y(2,:) = 0.1;                      % 10% crit in config
    ax3 = subplot(3,2,5);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% Beta Power
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Data
    z1 = EEG.icaact_b_t;  
    z1(z1>100) = 100;        % Cap

    % Surface Plot
    ax1 = subplot(3,2,2);
    surf(ax1,(z1),'LineStyle','none','FaceAlpha',0.9);view(0,90); 
    title('Component Beta Power'); xlabel('Epoch Number'); ylabel('Component Number')
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Flags Plot
    ax2 = subplot(3,2,4);
    surf(ax2,EEG.c_icaact_b_t,'LineStyle','none','FaceAlpha',0.9);view(0,90); colormap(jet);
    title('Flags'); xlabel('Epoch Number'); ylabel('Component Number');
    axis([0 size(z1,2) 0 size(z1,1)]);

    % Waveform + critval data plot
        y = mean(EEG.c_icaact_b_t,1);   % Average of flags
        x = 1:size(EEG.c_icaact_b_t,2); % Channels
        y(2,:) = 0.1;                      % 10% crit in config
    ax3 = subplot(3,2,6);
    plot(ax3,x,y); 
    title('Mean of Marks Critical Value'); xlabel('Epoch Number'); ylabel('% of Channels flagged');
    axis([ 0 (length(x + 1)) -0.05 1]);

    %% ASR Correction
    % Percent time corrected via ASR - intask
    % Percent time corrected via ASR - outtask
end


end % End of function


function eeg_diagnostics(EEG,batch_config)
% diagnostics(ALLEEG,type) - Creates figures to aid user in understanding
% the generated marks, and the overal quality of the data.
%
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

    fin_underscore = regexp(EEG.filename,'_');
    fin_underscore = fin_underscore(end);
    base_name = EEG.filename(1:fin_underscore-1);
    
    % outtask vs manual vs time remaining piechart
    ca = length(EEG.marks.chan_info(1).flags);                % All time
    c2 = length(find(EEG.marks.chan_info(2).flags));          % 2
    c3 = length(find(EEG.marks.chan_info(3).flags));          % 3
    c4 = length(find(EEG.marks.chan_info(4).flags));          % 4
    cm = length(find(EEG.marks.chan_info(1).flags));          % 5
    ca = ca-cm;                                               % Remaining All time
    cpie = [ca c2 c3 c4];
    figure;
    explode = [1 0 0 0];
    %ax1 = subplot(1,2,1);
    labels = {'Remaining Channels','ch-sd','low-r','bridge'};
    pie(cpie,explode,labels); colormap(jet);
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
    ca = length(EEG.marks.time_info(1).flags);                % All time
 
    co=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label({'out_task','in_leadup'},{EEG.marks.time_info.label}), ...
        'indices'));

    mgap=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label('mark_gap',{EEG.marks.time_info.label}), ...
        'indices'));

    chsd=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label('ch_sd',{EEG.marks.time_info.label}), ...
        'indices'));

    lowr=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label('low_r',{EEG.marks.time_info.label}), ...
        'indices'));

    icsd1=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label('ic_sd1',{EEG.marks.time_info.label}), ...
        'indices'));
    
    icsd2=length(marks_label2index(EEG.marks.time_info, ...
        marks_match_label('ic_sd2',{EEG.marks.time_info.label}), ...
        'indices'));

    %    c2 = length(find(EEG.marks.time_info(2).flags));          % 2 Out Task
%    c3 = length(find(EEG.marks.time_info(3).flags));          % 3
%    c4 = length(find(EEG.marks.time_info(4).flags));          % 4
%    c5 = length(find(EEG.marks.time_info(6).flags));          % 6
%    c6 = length(find(EEG.marks.time_info(10).flags));         % 10

cm=length(marks_label2index(EEG.marks.time_info, ...
    marks_match_label('manual',{EEG.marks.time_info.label}), ...
    'indices'));
%cm = length(find(EEG.marks.time_info(1).flags));          % manual
cr = ca-cm;                                   % Remaining All time
cpie = [cr co mgap chsd lowr icsd1 icsd2];
figure;
explode = [1 0 0 0 0 0 0];
%ax2 = subplot(1,2,2);
labels = {'Remaining Time','out-task','mark-gap','ch-sd','low-r','ic-sd1','ic-sd2'};
pie(cpie,explode,labels); colormap(jet);
title('Data Time Classification');

%% Components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\nICA Components\n');
fprintf('==================================================\n');
disp(['Identified ' num2str(min(size(EEG.icaweights))) ' components from ' num2str(length(EEG.icachansind)) ' channels']);

% PIE CHART
ca = length(find(EEG.reject.classtype == 1));
c2 = length(find(EEG.reject.classtype == 2));
c3 = length(find(EEG.reject.classtype == 3));
c4 = length(find(EEG.reject.classtype == 4));
c5 = length(find(EEG.reject.classtype == 5));
c6 = length(find(EEG.reject.classtype == 6));
cpie = [ca c2 c3 c4 c5 c6];
figure;
%ax1 = subplot(1,2,1);
explode = [0 1 0 0 0 0];
labels = { 'blink','neural','heart','lateye','muscle','mixed'};
pie(cpie,explode,labels);colormap(jet);
title('Component Majority Classifications');

% BAR CHART
%ax2 = subplot(1,2,2);
figure;
bar(1:length(EEG.reject.probabilities),EEG.reject.probabilities(:,:),'stacked','Horizontal','on');colormap(jet);
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

%ch_sd time
s='[sd_t_meth]';
sd_t_meth=strtrim(batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end));
s='[sd_t_vals]';
sd_t_vals=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_o]';
sd_t_o=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_p]';
sd_t_p=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);

data_sd_t = load([EEG.filepath base_name '_data_sd_t.mat']);
fieldname = fieldnames(data_sd_t);
fieldname = fieldname{1};
data_sd_t = data_sd_t.(fieldname);
    
if ~strcmp('na',sd_t_meth);
    marks_array2flags(data_sd_t, ...
        'flag_dim','col', ...
        'init_method',sd_t_meth, ...
        'init_vals',str2num(sd_t_vals), ...
        'init_crit',str2num(sd_t_o), ...
        'flag_method','fixed', ...
        'flag_val',str2num(sd_t_p), ...
        'plot_figs','on', ...
    'title_prefix','SD time - ');
end

%ch_sd channel
s='[sd_ch_meth]';
sd_ch_meth=strtrim(batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end));
s='[sd_ch_vals]';
sd_ch_vals=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_ch_o]';
sd_ch_o=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_ch_p]';
sd_ch_p=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);

data_sd_ch = load([EEG.filepath base_name '_data_sd_ch.mat']);
fieldname = fieldnames(data_sd_ch);
fieldname = fieldname{1};
data_sd_ch = data_sd_ch.(fieldname);

marks_array2flags(data_sd_ch, ...
    'flag_dim','row', ...
    'init_method',sd_ch_meth, ...
    'init_vals',str2num(sd_ch_vals), ...
    'init_crit',str2num(sd_ch_o), ...
    'flag_method','fixed', ...
    'flag_val',str2num(sd_ch_p), ...
    'plot_figs','on', ...
    'title_prefix','SD channel - ');

%low_r channel
s='[r_ch_meth]';
r_ch_meth=strtrim(batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end));
s='[r_ch_vals]';
r_ch_vals=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[r_ch_o]';
r_ch_o=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[r_ch_p]';
r_ch_p=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);

data_r_ch = load([EEG.filepath base_name '_data_r_ch.mat']);
fieldname = fieldnames(data_r_ch);
fieldname = fieldname{1};
data_r_ch = data_r_ch.(fieldname);

marks_array2flags(data_r_ch, ...
    'flag_dim','row', ...
    'init_method',r_ch_meth, ...
    'init_vals',str2num(r_ch_vals), ...
    'init_crit',str2num(r_ch_o), ...
    'flag_method','fixed', ...
    'flag_val',str2num(r_ch_p), ...
    'plot_figs','on', ...
    'title_prefix','low R channel - ');

%bridge channel
mr = median(data_r_ch,2);
iqrr = iqr(data_r_ch,2);
msr = mr./iqrr;
figure;
plot(msr);
hold on;
plot(ones(1,length(msr))*(ve_trimmean(msr,50)+ve_trimstd(msr,50)*6),'r')
view(270,90);
axis tight;
title('High R (low variant) bridge cutoff values')

%low_r time
s='[r_t_meth]';
r_t_meth=strtrim(batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end));
s='[r_t_vals]';
r_t_vals=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[r_t_o]';
r_t_o=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);
s='[r_t_p]';
r_t_p=batch_config(1).replace_string{find(strncmp(batch_config(1).replace_string,s,length(s)))}(length(s)+2:end);

data_r_t = load([EEG.filepath base_name '_data_r_t.mat']);
fieldname = fieldnames(data_r_t);
fieldname = fieldname{1};
data_r_t = data_r_t.(fieldname);

marks_array2flags(data_r_t, ...
    'flag_dim','col', ...
    'init_method',r_t_meth, ...
    'init_vals',str2num(r_t_vals), ...
    'init_crit',str2num(r_t_o), ...
    'flag_method','fixed', ...
    'flag_val',str2num(r_t_p), ...
    'plot_figs','on', ...
    'title_prefix','Low R time - ');

%ic_sd1 time
s='[sd_t_meth]';
sd_t_meth=strtrim(batch_config(3).replace_string{find(strncmp(batch_config(3).replace_string,s,length(s)))}(length(s)+2:end));
s='[sd_t_vals]';
sd_t_vals=batch_config(3).replace_string{find(strncmp(batch_config(3).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_o]';
sd_t_o=batch_config(3).replace_string{find(strncmp(batch_config(3).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_p]';
sd_t_p=batch_config(3).replace_string{find(strncmp(batch_config(3).replace_string,s,length(s)))}(length(s)+2:end);

icaact_sd1_t = load([EEG.filepath base_name '_icaact_sd1_t.mat']);
fieldname = fieldnames(icaact_sd1_t);
fieldname = fieldname{1};
icaact_sd1_t = icaact_sd1_t.(fieldname);

marks_array2flags(icaact_sd1_t, ...
    'flag_dim','col', ...
    'init_method',sd_t_meth, ...
    'init_vals',str2num(sd_t_vals), ...
    'init_crit',str2num(sd_t_o), ...
    'flag_method','fixed', ...
    'flag_val',str2num(sd_t_p), ...
    'plot_figs','on', ...
    'title_prefix','SD ICA 1  - ');

%ic_sd2 time
s='[sd_t_meth]';
sd_t_meth=strtrim(batch_config(7).replace_string{find(strncmp(batch_config(7).replace_string,s,length(s)))}(length(s)+2:end));
s='[sd_t_vals]';
sd_t_vals=batch_config(7).replace_string{find(strncmp(batch_config(7).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_o]';
sd_t_o=batch_config(7).replace_string{find(strncmp(batch_config(7).replace_string,s,length(s)))}(length(s)+2:end);
s='[sd_t_p]';
sd_t_p=batch_config(7).replace_string{find(strncmp(batch_config(7).replace_string,s,length(s)))}(length(s)+2:end);

if ~exist([EEG.filepath base_name '_icaact_sd2_t.mat'])
    return;
end

icaact_sd2_t = load([EEG.filepath base_name '_icaact_sd2_t.mat']);
fieldname = fieldnames(icaact_sd2_t);
fieldname = fieldname{1};
icaact_sd2_t = icaact_sd2_t.(fieldname);

marks_array2flags(icaact_sd2_t, ...
    'flag_dim','col', ...
    'init_method',sd_t_meth, ...
    'init_vals',str2num(sd_t_vals), ...
    'init_crit',str2num(sd_t_o), ...
    'flag_method','fixed', ...
    'flag_val',str2num(sd_t_p), ...
    'plot_figs','on', ...
    'title_prefix','SD ICA 2 - ');

    
    

function participant=mk_participant(fname)
fname = fname{:};
pid = fname;
slash_ind = strfind(fname,'/'); % find indices of all '/' chars
if ~isempty(slash_ind);
    pid = fname(1:slash_ind(2)-1); % strip chars right of the second '/'
    slash_ind = strfind(pid,'/'); % find indices of all '/' chars
    if ~isempty(slash_ind);
        pid = pid(slash_ind(1)+1:end); % strip chars left of the first '/'
    end
end
underscore_ind = strfind(pid,'_'); % find indices of all '_' chars
if ~isempty(underscore_ind);
    pid = pid(1:underscore_ind(end)-1); % strip chars right of the final '_'
    pid = pid(underscore_ind(1)+1:end); % strip chars left of the first '_'
end

if ~isempty(regexp(pid,'sub-','once'));
    pid = pid(5:end);
end

% change this depending on some variable representing group, condition, etc.:
% examples:
% group = fname(pid(length(pid)-2):pid(end)); % something like this?
% group = 'control';
% group = 1;
% group = EEG.group;

%if strcmp(pid(1),'6');
%    group = 'at-risk';
%else
%    group = 'control';
%end

%participant = {pid,'6m','???',group,}; % participant demographics data
    
participant = {pid};

end

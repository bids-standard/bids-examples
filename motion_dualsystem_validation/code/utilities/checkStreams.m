function [names, iscontinuous, streams] = checkStreams(streams)

iscontinuous = false(size(streams));
names = {};

% figure out which streams contain continuous/regular and discrete/irregular data
for i=1:numel(streams)
    
    names{i}           = streams{i}.info.name;
    
    % if the nominal srate is non-zero, the stream is considered continuous
    if ~strcmpi(streams{i}.info.nominal_srate, '0')
        
        iscontinuous(i) =  true;
        num_samples  = numel(streams{i}.time_stamps);
        t_begin      = streams{i}.time_stamps(1);
        t_end        = streams{i}.time_stamps(end);
        duration     = t_end - t_begin;
        
        if ~isfield(streams{i}.info, 'effective_srate')
            % in case effective srate field is missing, add one
            streams{i}.info.effective_srate = (num_samples - 1) / duration;
        elseif isempty(streams{i}.info.effective_srate)
            % in case effective srate field value is missing, add one
            streams{i}.info.effective_srate = (num_samples - 1) / duration;
        end
        
    else
        try
            num_samples  = numel(streams{i}.time_stamps);
            t_begin      = streams{i}.time_stamps(1);
            t_end        = streams{i}.time_stamps(end);
            duration     = t_end - t_begin;
            
            % if sampling rate is higher than 20 Hz,
            % the stream is considered continuous
            if (num_samples - 1) / duration >= 20
                iscontinuous(i) =  true;
                if ~isfield(streams{i}.info, 'effective_srate')
                    % in case effective srate field is missing, add one
                    streams{i}.info.effective_srate = (num_samples - 1) / duration;
                elseif isempty(streams{i}.info.effective_srate)
                    % in case effective srate field value is missing, add one
                    streams{i}.info.effective_srate = (num_samples - 1) / duration;
                end
            end
        catch
        end
    end
end
end
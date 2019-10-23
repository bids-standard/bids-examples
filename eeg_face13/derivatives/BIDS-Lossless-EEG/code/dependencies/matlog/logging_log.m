% logging_log() - logging_log logs messages if required by the current_level 
%                 or LOG_LEVEL current_level superceeds log_level. if neither
%                 are set 'NOTICE' is used levels are ERROR, WARN, NOTICE, 
%                 INFO, DEBUG from least verbose to most by default warning 
%                 and below print the stack trace
%
% Usage:
%   >> logging_log(log_level, message, current_level)
%
% Inputs:
%   log_level     - the log level of this message, from one of the above levels
%   message       - the message that will be formatted with disp
%   current_level - the log level of this message, from one of the above levels

% matlog - a Matlab and Octave compatible logging library
% Copyright (C) 2016 Mae Kennedy
% 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
function logging_log(log_level, message, current_level)
    format = '%s:\t%s\t%f\t%f\t%s\t%s';
    persistent clockstart;
    persistent last;
    global LOGGING_LEVEL;
    if isempty(clockstart)
        clockstart = clock();
        last = clock();
    end

    levelc = 'INFO'; % Default level
    stack_level = 'WARN'; % Level for stack trace to be included, WARN is best
    % All levels ordered from least verbose to most
    levels = {'ERROR', 'WARN', 'NOTICE', 'INFO', 'DEBUG'};
    if exist('current_level', 'var')
        levelc = current_level;
    elseif exist('LOGGING_LEVEL', 'var') && ~isempty(LOGGING_LEVEL)
        levelc = LOGGING_LEVEL;
    end
    
    % Check if we are being called from disp, if so, unroll the stack twice
    % if not, just use 1 for our line & stack functions unrolling parameter
    db = dbstack();
    unroll = 2;
    if numel(db) >= 2 && strcmp(db(2).name, 'disp')
        unroll = 3;
    end
    where = logging_ffileline(0, unroll);

    % Verify it is one of our levels
    difftime = etime(clock(), last);
    if ~any(strcmp(levels,levelc))
        builtin('disp', sprintf(format, 'ERROR', bucanl_get_iso8601(), ...
            bucanl_get_clocktime(clockstart), difftime, ...
            where, ...
            ['Level specified to logging_log ' ...
            'does not exist, check LOG_LEVEL and current_level ' ...
            'and verify that it is one of ']));
        builtin('disp', levels);

        return
    end


    % Write the message with the formating if log_level is greater than the
    % current log level in current_level or LOG_LEVEL
    if exist('evalc', 'builtin')
        fmessage = evalc('builtin(''disp'', message)');
    else
        % Polyfill for octave >=4.0
        % This may also be triggered by matlab without evalc and will fail
        try
            fmessage = builtin('disp', message);
        catch
            % Give up and just try to interpret the message as a string
            fmessage = sprintf('%s', message);
        end
    end
    if find(strcmp(levels, levelc), 1) >= find(strcmp(levels, log_level), 1)
        builtin('disp', sprintf(format, log_level, bucanl_get_iso8601(), ...
            bucanl_get_clocktime(clockstart), difftime, where, fmessage));
        % If the level is greater or equal to warn print stack trace
        if find(strcmp(levels, stack_level), 1) >= ...
                find(strcmp(levels, log_level), 1)
            builtin('disp', logging_fcallstack([], [], unroll));
        end
        last = clock();
    end
end
            
% Returns a formatted iso8601 datetime without timezone
function time = bucanl_get_iso8601()
    time = datestr(now, 'yyyy-mm-ddTHH:MM:SS');
end
% Returns time difference between now and the clockstart in seconds
function timediff = bucanl_get_clocktime(clockstart)
    timediff = etime(clock(), clockstart);
end

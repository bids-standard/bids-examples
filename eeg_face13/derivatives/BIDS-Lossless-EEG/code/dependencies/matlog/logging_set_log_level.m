% logging_set_log_level() - sets the logging level of logging_log messages
%                           to the provided level, if the level doesn't exist
%                           the behaviour is undefined
%
% Usage:
%   >> logging_set_log_level(strlevel)
%
% Inputs:
%   strlevel - maximum level to log char type

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

function logging_set_log_level(strlevel)
    global LOGGING_LEVEL;
    LOGGING_LEVEL = strlevel;
end


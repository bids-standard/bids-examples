% logging_fcallstack_format() - 
% Usage:
%   >>  logging_fcallstack_format(formatstr)
% 
% Inputs:
%   formatstr - Set the formatting for logging_fcallstack
%               sets CALL_STACK_FORMAT

% matlog - a Matlab and Octave compatible logging library
% Copyright (C) 2017 Mae Kennedy
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
function logging_fcallstack_format(formatstr)
    global CALL_STACK_FORMAT;
    if nargin < 1 
        help logging_fcallstack_format;
        return;
    end
    CALL_STACK_FORMAT = formatstr;
end

% disp() - This file overrides disp with our custom logging function
%          use logging_override_disp to disable or enable this, do not add
%          this folder to path directly
% Usage:
%   >> disp(data)
%
% Inputs:
%   data - The data to display formatted

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

function disp(data)
    logging_log('INFO', data);
end

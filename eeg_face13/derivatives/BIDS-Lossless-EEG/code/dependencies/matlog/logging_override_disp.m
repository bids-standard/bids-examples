% logging_override_disp() - Return the current stack trace as a string
%                           formatted with the provided format string and
%                           starting with the preamble
% Usage:
%   >> logging_override_disp(display)
% 
% Inputs:
%   display - true|false if you want to override disp function

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
function logging_override_disp(display)
    global LOGGING_OVERRIDE_DISP;
    if nargin < 1 || ~islogical(display)
        help logging_override_disp;
        return;
    end
    if LOGGING_OVERRIDE_DISP ~= display
        LOGGING_OVERRIDE_DISP = display;
        this_file = which(mfilename());
        [this_dir, ~, ~] = fileparts(this_file);
        disp_wrapper_path = fullfile(this_dir, 'disp_wrapper');
        % Ignorance is bliss
        warning('off','MATLAB:dispatcher:nameConflict')
        if LOGGING_OVERRIDE_DISP
            % Turn on
            addpath(disp_wrapper_path);
        else
            % Turn off
            rmpath(disp_wrapper_path);
        end
        warning('on','MATLAB:dispatcher:nameConflict')
    end
end

% This script sets the path to include the dependencies subdirectories

% Copyright (C) 2017 Brock University Cognitive and Affective Neuroscience Lab
%
% Code written by Brad Kennedy
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program (LICENSE.txt file in the root directory); if not, 
% write to the Free Software Foundation, Inc., 59 Temple Place,
% Suite 330, Boston, MA  02111-1307  USA

if ~exist('derivatives/lossless/code/dependencies/eeglab_asr_amica', 'dir') ...
        || ~exist('derivatives/lossless/code/dependencies/matlog', 'dir')
    error(['derivatives/lossless/code/dependencies does not not contain ' ...
        'eeglab_asr_amica and/or matlog, or is not readable, or ' ...
        'your current folder in matlab is not the root of your ' ...
        'project']);
end
addpath([pwd '/' 'derivatives/lossless/code/dependencies/eeglab_asr_amica'])
addpath([pwd '/' 'derivatives/lossless/code/dependencies/matlog'])
addpath([pwd '/' 'derivatives/lossless/code/scripts'])
addpath([pwd '/' 'derivatives/lossless/code/tools/diagnostics'])

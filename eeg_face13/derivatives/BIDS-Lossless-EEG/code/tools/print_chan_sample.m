% print_chan_sample() - prints the number of channems and samples
%                       in the EEG file to the log file
%
% Usage:
%   >>  print_chan_sample(EEG_temp);
%
% Inputs:
%   EEG_temp   - input EEG dataset
%    
% Outputs:
%   None
%: 

% Copyright (C) 2017 Brock University Cognitive and Affective Neuroscience Lab
%
% Code written by Mike Cichonski
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
function print_chan_sample(EEG_temp)
    numChans = 0;
    numSamps = 0;
    if ~isempty(EEG_temp)
        numChans = EEG_temp.nbchan;
        numSamps = EEG_temp.pnts;    
    end
    logging_log('INFO',sprintf('Number of Channels: %d', numChans));
    logging_log('INFO',sprintf('Number of Samples: %d', numSamps));
end


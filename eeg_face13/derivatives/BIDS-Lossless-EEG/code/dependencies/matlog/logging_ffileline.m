% logging_ffileline() - return a string containing the file and line
% Usage:
%   >> output = logging_ffileline(formatstr, unroll)
%
% Inputs:
%   formatstr - format string containing string and line number
%   unroll    - number of levels of recursion to unroll
%
% Outputs:
%   output    - formatted string to return
%
% Examples:
% output = strfileline()
%   return the current file:line
% output = logging_ffileline('%s:%d') 
%   returns the file with the current line and column
% output = logging_ffileline('%s:%d', 2) 
%   returns the file with the current line and column
%   but unrolls two lines of the stack not one

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
function output = logging_ffileline(formatstr, unroll)
  if ~exist('formatstr') || (exist('formatstr') && formatstr == 0)
    formatstr = '%s:%d';
  end
  if ~exist('unroll')
    unroll = 1;
  end
  stack = dbstack();
  if numel(stack) <= unroll
    output = 'HEAD';
    return;
  end
  stack = stack(unroll+1);
  if ~exist('stack.column')
    stack.column = '';
  end
  output = sprintf(formatstr, stack.name, stack.line, stack.column);
end


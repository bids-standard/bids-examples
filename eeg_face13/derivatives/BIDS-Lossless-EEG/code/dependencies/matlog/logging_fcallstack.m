% logging_fcallstack() - Return the current stack trace as a string
%                        formatted with the provided format string and
%                        starting with the preamble
% Usage:
%   >> output = logging_fcallstack(message, formatstr, unroll, stack)
% 
% Inputs:
%   message   - The message to print before the stack trace
%   formatstr - formatstr the string taking two strings and a number
%               for each level of the stack
%   unroll    - Number of stack frames to unroll before printing, needed
%               because we always would include the logging functions
%               which arn't useful
%   error     - Use this stack, not dbstack()
%
% Outputs:
%   output    - a string containing call stack
%
% Examples:
% output = logging_fcallstack()
%   returns string with defaults
% output = logging_fcallstack('Stack trace:') 
%   returns the string with this prefix message
% output = logging_fcallstack('ST:\n', '\tat %s(%s:%d)\n') 
%   returns the stack with each line formatted with the format string
% output = logging_fcallstack('ST:\n', '\tat %s(%s:%d)\n', 2) 
%   returns the stack with each line formatted with the format string
%   and unrolls two levels of the stack instead of one

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
function output = logging_fcallstack(messagen, formatstr, unroll, lerror)
  global CALL_STACK_FORMAT;
  if ~exist('formatstr', 'var') || (exist('formatstr', 'var') ...
          && isempty(formatstr))
    formatstr = '\tat %s(%s:%d)\n';
  end
  if ~isempty(CALL_STACK_FORMAT)
    formatstr = CALL_STACK_FORMAT;
  end
  if ~exist('messagen', 'var') || isempty(messagen)
    messagen = 'Stack trace:\n';
  end
  if ~exist('unroll', 'var') || isempty(unroll)
    unroll = 1;
  end
  output = '';
  if ~exist('lerror', 'var')
    stack = dbstack();
  else
    stack = lerror.stack;
    output = sprintf('ERROR: %s\n', lerror.message);
    unroll = unroll - 1;
  end
  output = [output sprintf(messagen)];
  % CHECK: should this be < or <=
  if numel(stack) < unroll+1
    return;
  end
  
  stack = stack(unroll+1:end);

  for i = 1:numel(stack)
    level = stack(i);
    output = [output sprintf(formatstr, level.file, level.name, ...
      level.line)];
  end
end


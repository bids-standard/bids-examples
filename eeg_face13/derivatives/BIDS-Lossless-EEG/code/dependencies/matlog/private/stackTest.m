
% Make this a script
1;
function res = logging_genStackTest(v)
  if v > 4
    res = strfcallstack();
    return;
  end 
  res = logging_genStackTest(v+1);
  return;

% Check that genStackTest produces the preamble
v = logging_genStackTest(1);
teststr = sprintf('Stack trace:\n\tat');
assert(v(1:16) == teststr);

% Check that strffileline
% produces a file line
res = logging_ffileline();
assert(res(1:10)=='stackTest:');


function fileContent = tsvread(filename, fieldToReturn, hdr)
  % Load text and numeric data from tab-separated-value or other file
  % FORMAT x = tsvread(f,v,hdr)
  % f - filename (can be gzipped) {txt,mat,csv,tsv,json}
  % v - name of field to return if data stored in a structure [default: '']
  % or index of column if data stored as an array
  % hdr - detect the presence of a header row for csv/tsv [default: true]
  %
  % x - corresponding data array or structure

  % __________________________________________________________________________
  %
  % Based on spm_load.m from SPM12.
  % __________________________________________________________________________

  % Copyright (C) 2018, Guillaume Flandin, Wellcome Centre for Human Neuroimaging
  % Copyright (C) 2018--, BIDS-MATLAB developers

  % -Check input arguments
  % --------------------------------------------------------------------------
  if nargin < 1
    error('no input file specified');
  end
  if ~exist(filename, 'file')
    error('Unable to read file ''%s'': file not found', filename);
  end

  if nargin < 2
    fieldToReturn = '';
  end
  if nargin < 3
    hdr = true;
  end % Detect

  % -Load the data file
  % --------------------------------------------------------------------------
  [~, ~, ext] = fileparts(filename);
  switch ext(2:end)
    case 'txt'
      fileContent = load(filename, '-ascii');
    case 'mat'
      fileContent = load(filename, '-mat');
    case 'csv'
      % x = csvread(f); % numeric data only
      fileContent = dsv_read(filename, ',', hdr);
    case 'tsv'
      % x = dlmread(f,'\t'); % numeric data only
      fileContent = dsv_read(filename, '\t', hdr);
    case 'json'
      fileContent = bids.util.jsondecode(filename);
    case 'gz'
      fz = gunzip(filename, tempname);
      sts = true;
      try
        fileContent = bids.util.tsvread(fz{1});
      catch err
        sts = false;
        err_msg = err.message;
      end
      delete(fz{1});
      rmdir(fileparts(fz{1}));
      if ~sts
        error('Cannot load file ''%s'': %s.', filename, err_msg);
      end
    otherwise
      try
        fileContent = load(filename);
      catch
        error('Cannot read file ''%s'': Unknown file format.', filename);
      end
  end

  % -Return relevant subset of the data if required
  % --------------------------------------------------------------------------
  if isstruct(fileContent)
    if isempty(fieldToReturn)
      fieldsList = fieldnames(fileContent);
      if numel(fieldsList) == 1 && isnumeric(fileContent.(fieldsList{1}))
        fileContent = fileContent.(fieldsList{1});
      end
    else
      if ischar(fieldToReturn)
        try
          fileContent = fileContent.(fieldToReturn);
        catch
          error('Data do not contain array ''%s''.', fieldToReturn);
        end
      else
        fieldsList = fieldnames(fileContent);
        try
          fileContent = fileContent.(fieldsList{fieldToReturn});
        catch
          error('Data index out of range: %d (data contains %d fields)', ...
                fieldToReturn, numel(fieldsList));
        end
      end
    end
  elseif isnumeric(fileContent)
    if isnumeric(fieldToReturn)
      try
        fileContent = fileContent(:, fieldToReturn);
      catch
        error('Data index out of range: %d (data contains $d columns).', ...
              fieldToReturn, size(fileContent, 2));
      end
    elseif ~isempty(fieldToReturn)
      error(['Invalid data index. ', ...
             'When data is numeric, index must be numeric or empty. ', ...
             'Got a %s'], ...
            class(fieldToReturn));
    end
  end

  % ==========================================================================
  % function x = dsv_read(f,delim)
  % ==========================================================================
function x = dsv_read(filename, delim, header)
  % Read delimiter-separated values file into a structure array
  % * header line of column names will be used if detected
  % * 'n/a' fields are replaced with NaN

  % -Input arguments
  % --------------------------------------------------------------------------
  if nargin < 2
    delim = '\t';
  end
  if nargin < 3
    header = true;
  end % true: detect, false: no
  delim = sprintf(delim);
  eol = sprintf('\n'); %#ok<SPRINTFN>

  % -Read file
  % --------------------------------------------------------------------------
  S = fileread(filename);
  if isempty(S)
    x = [];
    return
  end
  if S(end) ~= eol
    S = [S eol];
  end
  S = regexprep(S, {'\r\n', '\r', '(\n)\1+'}, {'\n', '\n', '$1'});

  % -Get column names from header line (non-numeric first line)
  % --------------------------------------------------------------------------
  h = find(S == eol, 1);
  hdr = S(1:h - 1);
  var = regexp(hdr, delim, 'split');
  N = numel(var);
  n1 = isnan(cellfun(@str2double, var));
  n2 = cellfun(@(x) strcmpi(x, 'NaN'), var);
  if header && any(n1 & ~n2)
    hdr = true;
    try
      var = genvarname(var); %#ok<DEPGENAM>
    catch
      var = matlab.lang.makeValidName(var, 'ReplacementStyle', 'hex');
      var = matlab.lang.makeUniqueStrings(var);
    end
    S = S(h + 1:end);
  else
    hdr = false;
    fmt = ['Var%0' num2str(floor(log10(N)) + 1) 'd'];
    var = arrayfun(@(x) sprintf(fmt, x), (1:N)', 'UniformOutput', false);
  end

  % -Parse file
  % --------------------------------------------------------------------------
  if exist('OCTAVE_VERSION', 'builtin') % bug #51093
    S = strrep(S, delim, '#');
    delim = '#';
  end
  if ~isempty(S)
    d = textscan(S, '%s', 'Delimiter', delim);
  else
    d = {[]};
  end
  if rem(numel(d{1}), N)
    error('Invalid DSV file ''%s'': Varying number of delimiters per line.', ...
          filename);
  end
  d = reshape(d{1}, N, [])';
  allnum = true;
  for i = 1:numel(var)
    sts = true;
    dd = zeros(size(d, 1), 1);
    for j = 1:size(d, 1)
      if strcmp(d{j, i}, 'n/a')
        dd(j) = NaN;
      else
        dd(j) = str2double(d{j, i}); % i,j considered as complex
        if isnan(dd(j))
          sts = false;
          break
        end
      end
    end
    if sts
      x.(var{i}) = dd;
    else
      x.(var{i}) = d(:, i);
      allnum = false;
    end
  end

  if ~hdr && allnum
    x = struct2cell(x);
    x = [x{:}];
  end
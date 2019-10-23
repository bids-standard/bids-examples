function retval = startsWith(s, prefix)
  n = length(prefix);
  if n == 0 # Empty prefix
    retval = 1; # Every string starts with empty prefix
    return
  endif
  retval = strncmp(s, prefix, n);
end

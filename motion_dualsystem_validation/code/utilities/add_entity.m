function f = add_entity(f, key, val)
if ~isempty(val)
  if isscalar(val)
    % this applies specifically to run
    val = num2str(val);
  end
  f = [f '_' key '-' val];
end


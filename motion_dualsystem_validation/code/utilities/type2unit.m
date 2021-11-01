function units = type2unit(types)
%type2unit This function converts a set of BIDS motion channel type names of movement
%sensors to allowed BIDS motion units for a BIDS motion dataset.
%
% Input:
%     types     = User specified types for sensor channels as string
%     array
%
% 
% Outputs:
%     units = corresponding units per type (See BEP029 for current status)
%
% Author: Julius Welzel, (j.welzel@neurologie.uni-kiel.de)

% prelocate
units = {};
for t = 1:numel(types)
    tmp_type = types{t};
       
    switch tmp_type
        case 'POS'
            units(t) = {'m'};
        case 'ACC'
            units(t) = {'m/s^2'};
        case 'GYRO'
            units(t) = {'rad/s'};
        case 'MAGN'
            units(t) = {'T'};
    end
end
end


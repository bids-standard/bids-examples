function [nms_chns nms_type nms_locs nms_comp]= locs2chans(locations,types_chns,varargin)
%locs2chans This function converts a set of locations names of movement
%sensors to channel names intended for a BIDS motion dataset
%(*chanels.tsv*).
%
% Input:
%     locations     = User specified labels for sensor placement as string
%     array
%
%     types_chns    = BIDS specified motion channel types as string array
%     (x,y,z) if not specified otherwise
% 
% Outputs:
%     nms_chns = all channels names as a combination of all locations,
%     types and components (x,y,z) -> name_type_component
%
% Author: Julius Welzel, (j.welzel@neurologie.uni-kiel.de)

%% check inputs
% locations
if isa(locations,'cell')
    locations = string(locations);
else ~isa(locations,'string') 
    error(['Please specify locations as string or cell array'])
end

% types_chns
if isa(types_chns,'cell')
    types_chns = string(types_chns);
else ~isa(types_chns,'string') 
    error(['Please specify channel types as string or cell array'])
end

% Parse inputs
p = inputParser;
defaultComponents = ["x" "y" "z"];
addParameter(p,'components_chn',defaultComponents); 
    
parse(p,varargin{:});
components_chn = p.Results.components_chn;

% create nms_chns based on location, types_chn & copmponent

nms_chns    = {};
nms_type    = {};
nms_locs    = {};   
nms_comp    = {};
for l = 1:numel(locations)
    for t = 1:numel(types_chns)
        for c = 1:numel(components_chn)
            nms_chns{end+1} = [locations{l} '_' types_chns{t} '_' components_chn{c}];
            
            % store for later BIDS conversion
            nms_locs{end + 1}   = locations{l};
            nms_type{end + 1}   = types_chns{t};
            nms_comp{end + 1}   = components_chn{c};
        end
    end
end
    
end


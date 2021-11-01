
function motionOut = spotrotation_motionconvert(motionIn, objects, pi, si, di)

quaternionComponents    = {'X','Y','Z','W'};
eulerComponents         = {'z','y','x'};
cartCoordinates         = {'X','Y','Z'};

newCell = {}; 
% check if object input is a nested cell
for Oi = 1:numel(objects)
   if iscell(objects(Oi))
       newCell = [newCell objects{Oi}];
   else
       newCell{end + 1} = objects(Oi); 
   end
end
objects = newCell; 

% % handling missing value (how tracking loss is represented in the stream)
% missingval = 0; % what is the value that represents tracking loss in the stream?
% posInterp = 'pchip'; % which interpolation method is to be used for filling missing values in position streams?
% oriInterp = 'nearest'; % which interpolation method is to be used for filling missing values in orientation streams?
% posExtrapVal = nan; % which values should be used outside of the time series?
% oriExtrapVal = nan; % which values should be used outside of the time series?

commonInterp = 'pchip';
commonExtrapVal = nan;

% iterate over different objects
%--------------------------------------------------------------------------
motionStreamAll    = cell(numel(motionIn), 1);

for iM = 1:numel(motionIn)
    
    motionStream            = motionIn{iM};
    labelsPre               = [motionStream.label];
    chantypesPre            = [motionStream.hdr.chantype];
    motionStream.label            = [];
    motionStream.hdr.label        = [];
    motionStream.hdr.chantype     = [];
    motionStream.hdr.chanunit     = [];
    
    dataPre                 = motionStream.trial{1};
    dataPost                = [];
    oi                      = 0;
    
    
    for ni = 1:numel(objects)
        
        % check first if the object exists at all and if not, skip
        if isempty(find(contains(labelsPre, objects{ni}),1))
            continue;
        else
            oi = oi + 1;
        end
        
        quaternionIndices = NaN(1,4);
        
        if contains(motionIn{1}.hdr.orig.name, 'PhasespaceLog')
            quaternionComponents = {'D', 'A', 'B', 'C'};
            for qi = 1:4
                quaternionIndices(qi) = find(contains(labelsPre, ['_' quaternionComponents{qi}]) & contains(labelsPre,objects{ni}) & ~contains(labelsPre,'Conf'));
            end
        else
%             for qi = 1:4
%                 quaternionIndices(qi) = find(contains(labelsPre, [objects{ni} '_quat_' quaternionComponents{qi}]));
%             end
        end
        
        cartIndices = NaN(1,3);
        
        if contains(motionIn{1}.hdr.orig.name, 'PhasespaceLog')
            for ci = 1:3
                cartIndices(ci) = find(contains(labelsPre, ['_' cartCoordinates{ci}]) & contains(labelsPre,objects{ni}) & ~contains(labelsPre,'Conf'));
            end
        else
%             for ci = 1:3
%                 cartIndices(ci) = find(contains(labelsPre, [objects{ni} '_' cartCoordinates{ci}]));
%             end
        end
        
        % convert from quaternions to euler angles
        orientationInQuaternion    = dataPre(:,:)';
%         orientationInEuler         = util_quat2eul(orientationInQuaternion);    % the BeMoBIL util script
%         orientationInEuler         = orientationInEuler';
        position                   = dataPre(:,:);
        
        % unwrap euler angles
%         orientationInEuler         = unwrap(orientationInEuler,[], 2);
        
        % concatenate the converted data
        dataPost                   = [dataPost; position];
        
        % enter channel information
        for ei = 1:3
            motionStream.label{6*(oi-1) + ei}                 = [objects{ni} '_eul_' eulerComponents{ei}];
            motionStream.hdr.label{6*(oi-1) + ei}             = [objects{ni} '_eul_' eulerComponents{ei}];
            motionStream.hdr.chantype{6*(oi-1) + ei}          = 'ORNT';
            motionStream.hdr.chanunit{6*(oi-1) + ei}          = 'rad';
        end
        
        for ci = 1:3
            motionStream.label{6*(oi-1) + 3 + ci}                 = [objects{ni} '_cart_' cartCoordinates{ci}];
            motionStream.hdr.label{6*(oi-1) + 3 + ci}             = [objects{ni} '_cart_' cartCoordinates{ci}];
            motionStream.hdr.chantype{6*(oi-1) + 3 + ci}          = 'POS';
            motionStream.hdr.chanunit{6*(oi-1) + 3 + ci}          = 'meters';
        end
        
    end
    
    % only include streams that have data from at least one object
    if oi > 0
        motionStream.trial{1}     = dataPost;
        motionStream.hdr.nChans   = numel(motionStream.hdr.chantype);
        motionStreamAll{iM}       = motionStream;
        
    end
end
%--------------------------------------------------------------------------
% find the one with the highest sampling rate
if numel(motionStreamAll)>1
    
    motionsrates = [];
    
    for iM = 1:numel(motionStreamAll)
        motionsrates(iM) = motionStreamAll{iM}.hdr.Fs;
    end
    
    [~,maxind] = max(motionsrates);
    
    % copy the header from the stream with max srate
    keephdr             = motionStreamAll{maxind}.hdr;
    
    % overwrite some fields in header with resampled information
    keephdr.nSamples            = size(motionStreamAll{maxind}.trial{1},2);
    keephdr.FirstTimeStamp      = motionStreamAll{maxind}.time{1}(1);
    lastTimeStamp               = motionStreamAll{maxind}.time{1}(end);
    keephdr.Fs                  = keephdr.nSamples/(lastTimeStamp - keephdr.FirstTimeStamp);
    keephdr.TimeStampPerSample  = (lastTimeStamp - keephdr.FirstTimeStamp)/keephdr.nSamples;
    
    % construct evenly spaced time points
    regularTime         = {linspace(keephdr.FirstTimeStamp, lastTimeStamp, (lastTimeStamp - keephdr.FirstTimeStamp)*keephdr.Fs)};
    
    keephdr.nChans      = 0;
    keephdr.label       = {};
    keephdr.chantype    = {};
    keephdr.chanunit    = {};
    
    % resample all data structures, except the one with the max sampling rate
    % this will also align the time axes
    for i=1:numel(motionStreamAll)
        
        % append channel information to the header
        keephdr.nChans      = keephdr.nChans + motionStreamAll{i}.hdr.nChans;
        keephdr.label       = [keephdr.label;       motionStreamAll{i}.hdr.label]; % change label for phace space so that they are unique
        keephdr.chantype    = [keephdr.chantype;    motionStreamAll{i}.hdr.chantype];
        keephdr.chanunit    = [keephdr.chanunit;    motionStreamAll{i}.hdr.chanunit];
        
        % resample
        ft_notice('resampling %s', motionStreamAll{i}.hdr.orig.name);
        
        cfg                 = [];
        cfg.time            = regularTime;
        cfg.detrend         = 'no';
        cfg.method          = commonInterp;
        cfg.extrapval       = commonExtrapVal;
        motionStreamAll{i}  = ft_struct2double(motionStreamAll{i});
        motionStreamResampled{i}  = ft_resampledata(cfg, motionStreamAll{i});
    end
    
    % append all data structures
    motionOut = ft_appenddata(cfg, motionStreamResampled{:});
    
    % modify some fields in the header
    motionOut.hdr = keephdr;
else
    % simply return the first and only one
    motionOut = motionStreamAll{1};
end


% wrap all orientation channels back to [pi, -pi]
%--------------------------------------------------------------------------
% find orientation channels
for Ci = 1:numel(motionOut.label)
    if contains(motionOut.label{Ci}, '_eul_')
        motionOut.trial{1}(Ci,:) = wrapToPi(motionOut.trial{1}(Ci,:));
    end
end

end


function cfg = ft_motionchannels(cfg,data)
% FT_MOTIONCHANNELS creates a BIDS conform channel cell for motion channels from the underlying data which is given in ft format.
%
% Use as
%   cfg = ft_motionchannels(cfg,motiondata)
%
% 2021, Julius Welzel, julius.welzel@gmail.com

% initiate channel.tsv
cfg.channels.name                   = {};
cfg.channels.tracking_system        = {};
cfg.channels.tracked_point          = {};
cfg.channels.component              = {};
cfg.channels.type                   = {};
cfg.channels.units                  = {};
cfg.channels.sampling_frequency     = {};

% tracking systems 
trackingSystems = fieldnames(data);            

for Ti = 1:numel(trackingSystems)
    
    for ci  = 1:data.(trackingSystems{Ti}).hdr.nChans

        splitlabel                              = regexp(data.(trackingSystems{Ti}).hdr.label{ci}, '_', 'split'); %1 location, 2 type, 3 component
        cfg.channels.name{end+1}                = data.(trackingSystems{Ti}).hdr.label{ci};
        cfg.channels.tracking_system{end+1}     = trackingSystems{Ti};
        cfg.channels.tracked_point{end+1}       = splitlabel{1}; % label of tracked point
        cfg.channels.component{end+1}           = splitlabel{end};
        cfg.channels.type{end+1}                = splitlabel{2};
        cfg.channels.sampling_frequency{end+1}  = data.(trackingSystems{Ti}).fsample;
        % automatically assign units from type
        tmp_type = splitlabel{2};
       
        switch tmp_type
            case 'POS'
                cfg.channels.units{end+1} = 'm';
            case 'ORNT'
                cfg.channels.units{end+1} = 'rad';
            case 'ACC'
                cfg.channels.units{end+1} = 'm/s^2';
            case 'ANGVEL'
                cfg.channels.units{end+1} = 'rad/s';
            case 'GYRO'
                cfg.channels.units{end+1} = 'rad/s';
            case 'MAGN'
                cfg.channels.units{end+1} = 'T';
        end

    end
end

end


function valid = ll_validate(EEG)
    valid = false;
    
    [fA, fB] = uigetfile('.','Select an EDF file','*.edf');
    edfPath = [fB fA];
    EEG = pop_bidsload(edfPath);
    [EEG, transform] = warp_locs( EEG,'derivatives/BIDS-Lossless-EEG/code/misc/standard_1005.elc', ...
            'mesh', 'derivatives/BIDS-Lossless-EEG/code/misc/standard_vol.mat', ...
            'transform',[0 0 0 0 0 0 1 1 1], ...
            'manual','on');
    disp('[montage_info] for c01_scalpart.cfg:');
    out = sprintf('%4.3f ',transform);
    disp(out);
end
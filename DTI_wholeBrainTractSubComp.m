clearvars; close all; clc;

% just change fp 

fp = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/Grant_Collaboration/DTI';
% fp = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/FHD/mmxt/dti'; % directory sub 

D =  {'BLD051_R1_neg_f'}; % sub directory; should contain dtitrilin folder


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(D,1)
    
dt = dtiLoadDt6([fp '/' D{i,:} '/dtitrilin_ACPC/dt6.mat']);
% Load the subject's dt6 file (generated from dtiInit).
% dt = dtiLoadDt6(fullfile(sub_dir,'dt6.mat'));

afq = AFQ_Create('cutoff',[5,95],'sub_dirs',[fp '/' D{i,:} '/dtitrilin_ACPC/'],'sub_group',1);
afq.params.track.faThresh = 0.2;
afq.params.track.faMaskThresh = 0.25;
afq.params.track.angleThresh = 40;

	spm('Defaults','fmri');
    spm_jobman('initcfg');
    % check mask thresh
    defaults = spm('GetGlobal','defaults');
    if defaults.mask.thresh ~= 0.8
        defaults.mask.thresh = 0.8;
    end

% Track every fiber from a mask of white matter voxels. Use 'test' mode to
% track fewer fibers and make the example run quicker.
wholebrainFG = AFQ_WholebrainTractography(dt,afq.params.run_mode,afq); % dti,'test'

AFQ_RenderFibers(wholebrainFG, 'numfibers',1000, 'color', [1 .6 .2]);

end

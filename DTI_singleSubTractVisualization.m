clearvars; close all; clc;

% just change fp 

fp = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/FHD/mmxt/dti'; % directory sub 

D =  {'BLD055_R0_pos_m/'}; % sub directory; should contain dtitrilin folder


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(D,1)
    
dt = dtiLoadDt6([fp '/' D{i,:} '/dtitrilin_ACPC/dt6.mat']);
% Load the subject's dt6 file (generated from dtiInit).
% dt = dtiLoadDt6(fullfile(sub_dir,'dt6.mat'));

afq = AFQ_Create('cutoff',[5,95],'sub_dirs',[fp '/' D{i,:} '/dtitrilin_ACPC/'],'sub_group',1);
% afq.params.track.faThresh = 0.15;
% afq.params.track.faMaskThresh = 0.2;
% afq.params.track.angleThresh = 40;


% Track every fiber from a mask of white matter voxels. Use 'test' mode to
% track fewer fibers and make the example run quicker.
wholebrainFG = AFQ_WholebrainTractography(dt,[],afq); % dti,'test'

% Visualize the wholebrain fiber group.  Because there are a few hundred
% thousand fibers we will use the 'numfibers' input to AFQ_RenderFibers to
% randomly select 1,000 fibers to render. The 'color' input is used to set
% the rgb values that specify the desired color of the fibers.
AFQ_RenderFibers(wholebrainFG, 'numfibers',1000, 'color', [1 .6 .2]);

% Add a sagittal slice from the subject's b0 image to the plot. First load
% the b0 image.
b0 = readFileNifti([fp '/' num2str(D{i,:}) '/dtitrilin_ACPC/bin/b0.nii.gz']);

% Then add the slice X = -2 to the 3d rendering.
AFQ_AddImageTo3dPlot(b0,[-2, 0, 0]);

% Segment the whole-brain fiber group into 20 fiber tracts
fg_classified = AFQ_SegmentFiberGroups(dt, wholebrainFG);

% fg_classified.subgroup defines the fascicle that each fiber belongs to.
% We can convert fg_classified to a 1x20 structured array of fiber groups
% where each entry in the array is a segmented fiber tract. For example
% fg_classified(3) is the left corticospinal tract, fg_classified(11) is
% the left inferior fronto-occipital fasciculus (IFOF), fg_classified(17)
% is the left uncinate fasiculus,  and fg_classified(19) is the left
% arcuate fasciculus.
fg_classified = fg2Array(fg_classified);

% Create a new variable for the left uncinate
uf = fg_classified(17);
% Remove fibers more than maxDist standard deviations from the tract core
maxDist = 4;
% Remove fibers more than maxLen standard deviations above the mean length
maxLen = 4;
% Sample each fiber to numNodes points
numNodes = 30;
% Compute the tract core with the function M
M = 'mean';
% Maximum number of iterations
maxIter = 1;
% Display the number of fibers removed in each iteration
count = true;

% Begin cleaning the uncinate
uf_clean = AFQ_removeFiberOutliers(uf,maxDist,maxLen,numNodes,M,count,maxIter);

% Notice that the final fiber group is much cleaner than the origional.
% There are not as many long looping fibers that deviate from the fascicle.
% AFQ_RenderFibers(uf,'numfibers',1000,'color',[1 1 0]);
% title('Uncinate before cleaning','fontsize',18)
% AFQ_RenderFibers(uf_clean,'numfibers',1000,'color',[.5 .5 0]);
% title('Uncinate after cleaning','fontsize',18) 

% Loop over all 20 fiber groups and clean each one
for ii = 1:20
    fg_clean(ii) = AFQ_removeFiberOutliers(fg_classified(ii),maxDist,maxLen,numNodes,M,count,maxIter);
end

% Render 400 corticospinal tract fibers in blue.
%AFQ_RenderFibers(fg_classified(3),'numfibers',400,'color',[0 0 1]);

% Render 400 IFOF fibers in green. To add this tract to the same
% plotting window set the 'newfig' input to false.
%AFQ_RenderFibers(fg_classified(11),'numfibers',400,'color',[0 1 0],'newfig',false)

% Render 400 uncinate fibers in yellow
%AFQ_RenderFibers(fg_classified(17),'numfibers',400,'color',[1 1 0],'newfig',false)

% Render 400 arcuate fibers in red.
%AFQ_RenderFibers(fg_classified(19),'numfibers',400,'color',[1 0 0],'newfig',false)
AFQ_RenderFibers(fg_classified(19),'numfibers',400,'color',[1 0 0]);


% Then add the slice X = -2 to the 3d rendering.
AFQ_AddImageTo3dPlot(b0,[-2, 0, 0]);

end

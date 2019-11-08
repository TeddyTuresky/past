clear classes; clearvars; clc; close all; 


r = '/Users/cinnamon/Documents/dti2114/dtiQCed/prepped_eddy.nii.gz';
t = '/Users/cinnamon/Documents/dti2114/dtiQCed/t1_acpc.nii.gz';

for i = 1:size(r,1)
    
    v = strsplit(strtrim(ls(r)));
    
%   if exist([fp '/' num2str(D(1,i)) r '.nii.gz'])
    tempni = niftiRead(v{1,1});
    tempni.freq_dim = 1;
    tempni.phase_dim = 2;
    tempni.slice_dim = 3;
    
    
    writeFileNifti(tempni);
    
    tempdwParams = dtiInitParams('dt6BaseName','dtitrilin','phaseEncodeDir',2,'rotateBvecsWithCanXform',1);
    [tempdt6FileName, tempoutBaseDir] = dtiInit(v{1,1},t,tempdwParams);
    
    
    clear temp*;
    
end
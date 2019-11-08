clearvars; clc; close all; clear classes;


r = {'/Users/cinnamon/Documents/dti2114-2/2114/'};
t = {'/Users/cinnamon/Documents/dti2114-2/raw/t1_acpc.nii.gz'};


for i = 1:size(r,1)
    
    nii = strtrim(ls([r{i,1} 'dtiQCed/prepped_eddy.nii.gz']));
    bvec = strtrim(ls([r{i,1} 'dtiQCed/prepped_eddy.bvec']));
    bval = strtrim(ls([r{i,1} 'dtiQCed/prepped_eddy.bval']));
    
    tempni = niftiRead(nii);
    tempni.freq_dim = 1;
    tempni.phase_dim = 2;
    tempni.slice_dim = 3;
    
    
    writeFileNifti(tempni);
    
    
    
    tempdwParams = dtiInitParams('dt6BaseName','dtitrilin','phaseEncodeDir',2,'rotateBvecsWithCanXform',1, 'eddyCorrect',-1,'bvecsFile', bvec,'bvalsFile',bval);
    [tempdt6FileName, tempoutBaseDir] = dtiInit(nii,t{i,1},tempdwParams);
    
    
    clearvars tempni nii bvec bval
  
    
end
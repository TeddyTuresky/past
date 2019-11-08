% converts dicoms to niftis
% 
clearvars; clc; close all;

cd /Volumes/FunTown/allanalyses/BangRS/other/InterData
k = ls('-d','*/');
sub = strsplit(strtrim(k));
nsub = length(sub); 



for i = 1:nsub
    run{i} = splitlines(strtrim(ls('-d1',[sub{i} '*/'])));
    for ii = 1:size(run{i},1)
        dic = dir2(run{i}{ii});
        ndic = size(dic,1);
        cd(run{i}{ii})
        if contains(run{i}{ii},'MPRAGE') || contains (run{i}{ii},'tfl')
            U = strvcat(dic(:).name);
            hdr = spm_dicom_headers(U);
            spm_dicom_convert(hdr,'all','flat','nii','.');
%          elseif contains(run{i}{ii},'LSM')
%              for iii = 1:ndic
%                  hdr = spm_dicom_headers(dic(iii).name);
%                  spm_dicom_convert(hdr,'all','flat','nii');
%             end
        end
        cd ../..
        
    end
end
       
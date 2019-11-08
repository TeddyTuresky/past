clearvars; clc; close all;
% separates t1 dicoms and moves to separate folder
% for questions, please contact theodore.turesky@childrens.harvard.edu
%==========================================================================
addpath('/neuro/labs/gaablab/tools/tkt_tools');
addpath('/neuro/labs/gaablab/tools/tkt_tools/spm12');
path = uigetdir(pwd,'Please Select Subject Folder Containing DICOM folder');
[f sub] = fileparts(path);  
%path = spm_select(inf, 'dir', 'Select Subject Directors to Convert');
dep = '/neuro/labs/gaablab/data/Bangladesh/jen/BEAN';

%==========================================================================

for i = 1:size(path,1)
a{i} = strsplit(strtrim(ls('-d',[path '/DICOM/*/*/*'])));
numa(i,1) = size(a{i},2);
j = 1;

    for ii = 1:numa(i)
        if isdir(a{i}{ii}) == 0
                
                d{i}{ii} = dicominfo(a{i}{1,ii});
                p{i}{ii} = d{i}{ii}.SeriesDescription;
                t{i}{ii} = d{i}{ii}.SeriesTime;

                if strfind(p{i}{ii},'MPRAGE') > 0
                        
                        file{j,1} = a{i}{ii};
                        time{j,1} = t{i}{ii};
                        j = j+1;
                end
        end
        
    end
    
    u = unique(time);
    nt = size(u,1);
    
    
    for ii = 1:nt
        k = 1;
        for iii = 1:(j-1)
         if time{iii,1} == u{ii}
             fout{k,1} = file{iii,1};
             k = k+1;
         end
        end
        
            hdr = spm_dicom_headers(char(fout));
            spm_dicom_convert(hdr,'all','flat','nii',dep);
            v = ls([dep '/s*.nii']);
            movefile(strtrim(v),[dep '/' sub '_T1_MPRAGE_' num2str(ii) '.nii']);
            clear k
    end
 
end   
        
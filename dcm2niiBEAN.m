clearvars; close all; clc;

% Basic processing for individual BEAN subjects.
% for questions, please contact theodore.turesky@childrens.harvard.edu
%==========================================================================
addpath(genpath('/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/tools/tkt_tools'));

fprintf(['This script converts  dicom files for individual BEAN infant subjects',...
'\n Output to same directory as directory containing dicom files.\n\n\n']);

dep = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/Bangladesh/jen/BEAN'; % to copy for neuroradiologist

%align = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/tools/tkt_tools/spm12/toolbox/cat12/templates_1.50mm/brainmask.nii';

n_T1 = 144;

[path,file] = fileparts(spm_select(1,'dir','Please Select DICOM folder'));

%==========================================================================
% Central Switch
%==========================================================================

fprintf(['Please choose where you would like to begin processing:',...
    '\n\n\t1. At the beginning',...
    '\n\n\t2. After dicom separation',...
    '\n\n\t3. After dicom conversion',...
    '\n\n\t4. After parameter and run completion check\n\n']);

beg = input('Please enter number here: ');


    
%==========================================================================
%% separating dicom files
%==========================================================================

if beg == 1

    
disp('Separating dicom files...');

a = strsplit(strtrim(ls('-d',[fullfile(path,file) '/*/*/*'])),{'\t','\n'});

for i = 1:size(a,2);
    if isdir(a{i}) == 0 % ensures a{i} is a file and not a folder
        try % ensures that a{i} is a dicom file
            d{i} = dicominfo(a{i});
        catch
            disp([a{i} ' is not a dicom file. Skipping...']);
            continue
        end
            p{i} = d{i}.SeriesDescription;
            t{i} = d{i}.SeriesTime;

            if isdir([path '/' p{i}]) == 0
                mkdir([path '/' p{i}]);
                copyfile(a{i},[path '/' p{i}]);
            else                                 
               depf = dir2([path '/' p{i} '*']);
               nr = size(depf,1);
               for ii = 1:nr
                    if ii == 1
                        depff = dir2([path '/' depf(ii).name '/*']);
                        d2{ii} = dicominfo([path '/' depf(ii).name '/' depff(1).name]);
                    else
                        depff = dir2([path '/' depf(ii).name '/*']);
                        d2{ii} = dicominfo([path '/' depf(ii).name '/' depff(1).name]);
                    end
                        match(ii) = strcmp(d2{ii}.SeriesTime,t{i});
               end


                if any(match) == 0
                    mkdir ([path '/' p{i} '_' num2str(nr + 1)])
                    copyfile(a{i},[path '/' p{i} '_' num2str(nr + 1)]);
                else
                    k = find(match);
                    copyfile(a{i},[path '/' depf(k).name]);
                    clear k
                end
                clear match 
            end

    end

end
    

clearvars i ii a d p t beg

beg = 2;
end

%==========================================================================
%% converting from dicom to nifti with spm
%==========================================================================

if beg == 2

disp('Converting from dicom to nifti with spm...');

cd(path)
D = dir2('*');

for i = 1:size(D);
    
    if strfind(D(i).name,'MPRAGE') > 0 & isdir(D(i).name) == 1 % for MPRAGE conversion
        fout = dir2([D(i).name '/*']);
        if size(fout,1) == n_T1
            hdr = spm_dicom_headers([repmat([D(i).name '/'],size(fout,1),1) char(fout.name)]);
            spm_dicom_convert(hdr,'all','flat','nii',D(i).name);
        else
            disp(['not enought T1 files in ' D(i).name ' folder']);
        end
        
    elseif any(vertcat(strfind(D(i).name,'resting'))) == 1 & isdir(D(i).name) == 1;
        epi = dir2([D(i).name '/*']);
        
        
        for ii = 1:size(epi,1) % for EPI conversion
            hdr = spm_dicom_headers([D(i).name '/' epi(ii).name]);
            spm_dicom_convert(hdr,'all','flat','nii',D(i).name);
        end
    end
     
    clearvars fout hdr epi
end

end

clearvars i ii j beg

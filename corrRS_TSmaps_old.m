close all; clearvars; clc;
% Generates topography in which voxels reflect correlation (across subjects)
% between fcMRI estimates from resting-state and task-state data.
% Relies on output from CONN.
% For questions: theodore.turesky@childrens.harvard.edu, 2019



cd /Volumes/FunTown/allAnalyses

nsub = 15;
c = num2str([1; 3; 5;]); % condition vector [RS VM (3,4) IR (5,7)]
s = num2str(1); % source number
m = 1; % 1 for gray matter mask. other number for RS mask
src = 'IFG-clus'; % source name
con = 'fix'; % condition type (e.g., reg, fixation blocks only, task blocks only)

if m == 1
    msk = load_untouch_nii('~/Downloads/conn/rois/ratlas.nii'); % resampled mask
else
    msk = load_untouch_nii('/Volumes/FunTown/connOutput/RS-all.nii'); % only within RS cluster
end


for i = 1:nsub
    k = num2str(i); % extract all fcMRI values for Resting State, Visual Motion and Implicit Reading scan sessions
    if i < 10
        rs = load_untouch_nii(['Resting_State_Data_Analysis_NEW/conn_project_REST_04.06.16/results/firstlevel/IFG/BETA_Subject00' k '_Condition00' c(1,:) '_Source00' s '.nii']);
        vm = load_untouch_nii(['Resting_State_Data_Analysis_NEW/conn_project_VM_4.01.16/results/firstlevel/IFG/BETA_Subject00' k '_Condition00' c(2,:) '_Source00' s '.nii']);
        ir = load_untouch_nii(['Conn_Data_Analysis/conn_project_EIR_3_31/results/firstlevel/IFG/BETA_Subject00' k '_Condition00' c(3,:) '_Source00' s '.nii']);
    else
        rs = load_untouch_nii(['Resting_State_Data_Analysis_NEW/conn_project_REST_04.06.16/results/firstlevel/IFG/BETA_Subject0' k '_Condition00' c(1,:) '_Source00' s '.nii']);
        vm = load_untouch_nii(['Resting_State_Data_Analysis_NEW/conn_project_VM_4.01.16/results/firstlevel/IFG/BETA_Subject0' k '_Condition00' c(2,:) '_Source00' s '.nii']);
        ir = load_untouch_nii(['Conn_Data_Analysis/conn_project_EIR_3_31/results/firstlevel/IFG/BETA_Subject0' k '_Condition00' c(3,:) '_Source00' s '.nii']);
    end
    
    %apply explicit mask
    rsi(:,:,:,i) = rs.img.*mskl;
    vmi(:,:,:,i) = vm.img.*mskl;
    iri(:,:,:,i) = ir.img.*mskl;
end

for r = 1:size(rs.img,1)
    for c = 1:size(rs.img,2)
        for h = 1:size(rs.img,3)
            rvm = corr2(rsi(r,c,h,:),vmi(r,c,h,:));
            rir = corr2(rsi(r,c,h,:),iri(r,c,h,:));
            if isnan(rvm(2,1)) == 1
                rvmi(r,c,h) = 0;
            else
                rvmi(r,c,h) = rvm(2,1);
            end
            
            if isnan(rir(2,1)) == 1
                riri(r,c,h) = 0;
            else
                riri(r,c,h) = rir(2,1);
            end
        end
    end
end

nii = load_untouch_nii('practice1.nii');
nii.img = rvmi;
save_untouch_nii(nii,['rvmi' con '-msk.nii'])
nii.img = riri;
save_untouch_nii(nii,['riri' con '-msk.nii'])
% This script compares resting state fcMRI values with fcMRI values from
% visual motion and implicit reading scans with the effect of block
% regressed or other conditions


close all; clear all; clc;

cd /Volumes/TKT

nsub = 15;
c = num2str([1; 4; 7;]); % condition vector [RS VM IR]
con = 'fix'; % condition type (e.g., reg, fixation blocks only, task blocks only)
s = num2str(1); % source number
src = 'IFG'; % source name



msk = load_untouch_nii('~/Downloads/conn/rois/ratlas.nii'); % resampled mask
mskl = logical(msk.img);

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
    rsi = rs.img.*mskl;
    vmi = vm.img.*mskl;
    iri = ir.img.*mskl;
    
    % make 3D matrix into vector
    nvx = numel(rsi);
    rsv{i} = reshape(rsi,[nvx,1]); 
    vmv{i} = reshape(vmi,[nvx,1]);    
    irv{i} = reshape(iri,[nvx,1]);    
    
    % index non-zero voxels
    frs{i} = find(rsv{i});
    fvm{i} = find(vmv{i});
    fir{i} = find(irv{i});
    
    fall{i} = intersect(intersect(frs{i},fvm{i}),fir{i});
    if i == 1
        falls = fall{i};
    else
        falls = intersect(falls,fall{i});
    end
    
    % remove non-zero voxels uniformly across scan sessions
    for ii = 1:size(fall{i})
        zRS1{i}(ii,1) = rsv{i}(fall{i}(ii),1);
        zVM1{i}(ii,1) = vmv{i}(fall{i}(ii),1);
        zIR1{i}(ii,1) = irv{i}(fall{i}(ii),1);
    end
    
   % remove non-zero voxels uniformly across scan sessions and subjects
    for ii = 1:size(falls)
        zRSu{i}(ii,1) = rsv{i}(falls(ii),1);
        zVMu{i}(ii,1) = vmv{i}(falls(ii),1);
        zIRu{i}(ii,1) = irv{i}(falls(ii),1);
    end
    
    % combine subjects without inter-subject uniformity
    if i == 1
        zRSs = zRS1{i};
        zVMs = zVM1{i};
        zIRs = zIR1{i};
    else
        zRSs = [zRSs; zRS1{i}];
        zVMs = [zVMs; zVM1{i}];
        zIRs = [zIRs; zIR1{i}];
    end
    
    % combine subjects removing non-zero voxels uniformly
    if i == 1
        zRSus = zRSu{i};
        zVMus = zVMu{i};
        zIRus = zIRu{i};
    else
        zRSus = [zRSus; zRSu{i}];
        zVMus = [zVMus; zVMu{i}];
        zIRus = [zIRus; zIRu{i}];
    end
end

[rVMu,pVMu] = corrcoef(zRSus,zVMus)
[rIRu,pVMu] = corrcoef(zRSus,zIRus)
R2VMu = rVMu(2,1)^2
R2IRu = rIRu(2,1)^2

zAlls = [zRSs zVMs zIRs];
zAllus = [zRSus zVMus zIRus];

save(['zMat-' src '-' con '.mat'],'zAlls');
save(['zMatu-' src '-' con '.mat'],'zAllus');

figure
scatter(zRSus,zVMus)
figure
scatter(zRSus,zIRus)
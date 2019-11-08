close all; clearvars; clc;
% Compares resting state fcMRI values with fcMRI values from
% visual motion and implicit reading scans with the effect of block
% regressed or other conditions
% Optional: Plots showing voxelwise correspondance for all masked voxels.
% For questions: theodore.turesky@childrens.harvard.edu, 2017



cd /Volumes/FunTown/allAnalyses

nsub = 15;
c = num2str([1; 3; 5;]); % condition vector [RS VM (3,4) IR (5,7)]
s = num2str(1); % source number
m = 1; % 1 for gray matter mask. other number for RS mask
src = 'IFG-clus'; % source name
con = 'all'; % condition type (e.g., reg, fixation blocks only, task blocks only)
dep = '/Volumes/FunTown/allAnalyses/iFCcompAnalysis/';

if m == 1
    msk = load_untouch_nii('~/Downloads/conn/rois/ratlas.nii'); % resampled mask
else
    msk = load_untouch_nii('/Volumes/FunTown/connOutput/RS-all.nii'); % only within RS cluster
end

%==========================================================================

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
    
    % apply explicit mask
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
        falls = intersect(falls,fall{i}); % builds up non-zero voxel index for all sessions, all subjects
    end 
    
    % retain non-zero voxels uniformly across scan sessions
    for ii = 1:size(fall{i})
        zRS1{i}(ii,1) = rsv{i}(fall{i}(ii),1);
        zVM1{i}(ii,1) = vmv{i}(fall{i}(ii),1);
        zIR1{i}(ii,1) = irv{i}(fall{i}(ii),1);
    end
end    

clear i
    
for i = 1:nsub
    
   % retain non-zero voxels uniformly across scan sessions and subjects
    for ii = 1:size(falls)
        zRS1u{i}(ii,1) = rsv{i}(falls(ii),1);
        zVM1u{i}(ii,1) = vmv{i}(falls(ii),1);
        zIR1u{i}(ii,1) = irv{i}(falls(ii),1);
    end
       
    % subject-specific correlations without inter-subject uniformity
    rVM1(i,1) = corr(zRS1{i},zVM1{i});
    rIR1(i,1) = corr(zRS1{i},zIR1{i});
    
    % subject-specific correlations with inter-subject uniformity
    rVM1u(i,1) = corr(zRS1u{i},zVM1u{i});
    rIR1u(i,1) = corr(zRS1u{i},zIR1u{i});
    
    
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
    
    % combine subjects with inter-subject uniformity
    if i == 1
        zRSus = zRS1u{i};
        zVMus = zVM1u{i};
        zIRus = zIR1u{i};
    else
        zRSus = [zRSus; zRS1u{i}];
        zVMus = [zVMus; zVM1u{i}];
        zIRus = [zIRus; zIR1u{i}];
    end
end

% group-average subject-specific correlations
arVM1 = mean(rVM1,1)
arIR1 = mean(rIR1,1)
arVM1u = mean(rVM1u,1)
arIR1u = mean(rIR1u,1)

% correlations without inter-subject uniformity
[rVMs pVMs] = corr(zRSs,zVMs)
[rIRs pIRs] = corr(zRSs,zIRs)

% correlations with inter-subject uniformity
[rVMu,pVMu] = corr(zRSus,zVMus)
[rIRu,pVMu] = corr(zRSus,zIRus)



R2VMu = rVMu^2
R2IRu = rIRu^2

zAlls = [zRSs zVMs zIRs];
zAllus = [zRSus zVMus zIRus];

save([dep 'zMat-' src '-' con '.mat'],'zAlls');
save([dep 'zMatu-' src '-' con '.mat'],'zAllus');

% figure
% scatter(zRSus,zVMus)
% figure
% scatter(zRSus,zIRus)
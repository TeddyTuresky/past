close all; clear all; clc;

cd /Volumes/TKT

nsub = 15;
c = num2str([1; 1; 5;]); % condition vector [RS VM IR]
s = num2str(1); % source number

msk = load_untouch_nii('~/Downloads/conn/rois/ratlas.nii'); % resampled mask
mskl = logical(msk.img);

for i = 1:nsub
    k = num2str(i); % extract all fcMRI values for Resting State, Visual Motion and Implicit Reading scans
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
    frs{i} = find(rsv);
    fvm{i} = find(vmv);
    fir{i} = find(irv);
     
    fall{i} = intersect(frs{i},fvm{i},fir{i});
    
%     for ii = 1:nvx
%         RS(ii,i) = rxv(ii,1);
%         VM(ii,i) = rxv(ii,1);
%         if RS(ii,i) =~ 0
%             ixrs(ii,i) = 1;
%         else
%             ixrs(ii,i) = 0;
%         end
%         if VM(ii,i) =~ 0
%             ixvm(ii,i) = 1;
%         else
%             ixvm(ii,i) = 0;
%         end
%     end
    
end

% separate subjects, separate runs



% remove non-zero uniformly for all subjects and all scan sessions
catfrs = frs{1};
catfvm = fvm{1};
catfir = fir{1};

for n = 1:(nsub-1) % removes for all subjects
    catfrs = [catfrs; frs{n+1}];
    catfvm = [catfvm; fvm{n+1}];
    catfir = [catfir; fir{n+1}];
end

catf = cat(1,catfrs,catfvm,catfir); % removes for all scan sessions

% for n = 1:nsub
%     szrs(n,1) = numel(frs{n});
%     szvm(n,1) = numel(fvm{n});
%     szir(n,1) = numel(fir{n});
% end
% 
% sszrs = sum(szrs,1);
% sszvm = sum(szvm,1);
% sszir = sum(szir,1);
% rfrs = reshape(frs,[szrs,1]);
% rfvm = reshape(fvm,[szvm,1]);
% rfir = reshape(fir,[szir,1]);


% ufrs = unique(rfrs);
% ufvm = unique(rfvm);
ucatf = unique(catf); % remove duplicates in index
sucatf = size(ucatf);

% for ii = 1:nvx
%     rsZin(ii,:) = prod(ixrs,2);
%     vmin(ii,:) = prod(ixvm,2);
% end



for ii = 1:sucatf 
    zRS(ii) = rsv(ucatf(ii),1);
    zVM(ii) = vmv(ucatf(ii),1);
    zIR(ii) = irv(ucatf(ii),1);
end

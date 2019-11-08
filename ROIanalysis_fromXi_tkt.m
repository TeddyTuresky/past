%%things to change: foldername, effect to extract, roiname
%need to check, xx_nan, to check the numnber of voxels that have no value
%for each subject for a given ROI.
effectfolder = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/FHD/mmxt/fsm-cons';
sublistname = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/FHD/mmxt/sublist4mmxt.mat';

ROIfolder = '/net/rc-fs-nfs/ifs/data/Shares/DMC-Gaab2/data/FHD/mmxt/rois';

sublist = dir2([effectfolder '/*.img']);
roiname = dir2([ROIfolder '/*.nii']);
% load(sublistname);
% folderno = size(sublist,1);


tot = zeros(size(sublist,1),size(roiname,1));

for i = 1:size(roiname,1)
    
    roi = load_nii([ROIfolder '/' roi(i).name]);
    
    for ii = 1:size(sublist,1)
        
        effectmax(:,:,:,i) = spm_read_vols(spm_vol([effectfolder,sublist(i).name]));
    




 for i = 1:folderno
       tempeffect = dir2([effectfolder '/*.img']);
%        tempvm=dir([vmfolder,'VM_',char(sublist(i,1)),'_',char(sublist(i,3)),'_',char(sublist(i,2)),'*.img']) ;
%        tempfsm=dir([fsmfolder,'FSM_',char(sublist(i,1)),'_',char(sublist(i,3)),'_',char(sublist(i,2)),'*.img']) ;
   
       effectmax(i,:,:,:) = spm_read_vols(spm_vol([effectfolder,tempeffect(i).name])); 
%        vmmax(i,:,:,:)=spm_read_vols(spm_vol([vmfolder,tempvm.name]));
%        fsmmax(i,:,:,:)=spm_read_vols(spm_vol([fsmfolder,tempfsm.name])); 
%         
      clear temp*;
   
        
    end




for j = 1:length(roiname)
    
    temproi = spm_read_vols(spm_vol(char(roiname{j})));  
    tempcoord = findn(temproi);
    tempno = size(tempcoord,1);
    tempeffectvox = zeros(folderno,tempno);
%     tempfsmvox=zeros(folderno,tempno);
%     tempvmvox=zeros(folderno,tempno);
   
    for k = 1:tempno
       tempeffectvox(:,k) = effectmax(:,tempcoord(k,1),tempcoord(k,2),tempcoord(k,3));
%        tempfsmvox(:,k)=fsmmax(:,tempcoord(k,1),tempcoord(k,2),tempcoord(k,3));
%        tempvmvox(:,k)=vmmax(:,tempcoord(k,1),tempcoord(k,2),tempcoord(k,3));
        
    end
        
    ROI_voxelnum(j) = tempno;  
    effect(:,j) = nanmean(tempeffectvox,2); 
    effect_nan(:,j) = sum(isnan(tempeffectvox),2);
    
%     fsm(:,j)=nanmean(tempfsmvox,2); 
%     fsm_nan(:,j)=sum(isnan(tempfsmvox),2);
%     
%     vm(:,j)=nanmean(tempvmvox,2); 
%     vm_nan(:,j)=sum(isnan(tempvmvox),2);
    
        
    clear temp*
    end
    
    
    
  clear   effectmax;
  

    
    
    
    
    
    

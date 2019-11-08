% This script will allow you to move *.nii files in bulk from Y to your
% personal directories. 

% Currently, this script is set to run with the
% directory structure ...subject/Visit(or .STU)/run/*.nii.

clear all; clc;

nii_folders = spm_select(Inf, 'dir', 'Select run directories containing .nii');

dir_drop = spm_select(1, 'dir', 'Select directory to send subject data');

n_runs = size(nii_folders,1);

for i = 1:n_runs
    S = strtrim(nii_folders(i,:));
    j = length(S);
    k = strfind(S,'/');
    n_del = length(k);
    run = S((k(n_del) + 1):j); % specifies run folders
    subj = S((k(n_del-2) + 1):(k(n_del-1) - 1)); % specifies subject folders

    eval(sprintf('a = isdir(''dir_drop/%s'');',subj)); % makes subject folders in new location if none exist
        if a==0;
            eval(sprintf('mkdir([dir_drop ''/'' ''%s'']);',subj));
        end
        
    eval(sprintf('mkdir([dir_drop ''/'' ''%s/%s'']);',subj,run)); % makes run folders in new location
    eval(sprintf('copyfile([S ''/'' ''*.nii''],[dir_drop ''/'' ''%s/%s'']);',subj,run)); % copies *.nii files
end    
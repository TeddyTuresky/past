% this script renames .nii files with a prefix of your choice.

clear all; clc;

folders = spm_select(Inf, 'dir', 'Select run directories containing .nii');
A = input('what prefix would you like to use?  ','s');


n_runs = size(folders,1);

for i = 1:n_runs
    run = strtrim(folders(i,:));
    niis = dir([run '/' '*.nii']);
    n_niis = length(niis);
    for ii = 1:n_niis
        if ii < 10
            movefile([run '/' niis(ii).name],[run '/' A '_00' ii '.nii']);
        else
            movefile([run '/' niis(ii).name],[run '/' A '_0' ii '.nii']);
        end
    end
end
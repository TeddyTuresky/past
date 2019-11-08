clear all; close all; clc;

cd /Volumes/TKT/subAnalysis-rh;
dep = '/Volumes/TKT/subAnalysis-rh-corr';

k = ls('-d','*');
subj = strsplit(strtrim(k));
n_subj = length(subj);

a = [1 10:19 2 20:29 3 30:39 4 40:49 5 50:59 6 60:69 7 8 9];
b = 1:69;

for s = 1:n_subj
    for i = 1:69
        c = num2str(a(i));
        d = num2str(b(i));

        if a(i)<=9 && b(i)<=9
            copyfile([subj{s} '/motorR/motorR_00' c '.nii'],[dep '/' subj{s} '/motorR/motorR_00' d '.nii']);
        elseif a(i)>9 && b(i)>9
            copyfile([subj{s} '/motorR/motorR_0' c '.nii'],[dep '/' subj{s} '/motorR/motorR_0' d '.nii']);
        elseif a(i)>9 && b(i)<=9
            copyfile([subj{s} '/motorR/motorR_0' c '.nii'],[dep '/' subj{s} '/motorR/motorR_00' d '.nii']);
        else
            copyfile([subj{s} '/motorR/motorR_00' c '.nii'],[dep '/' subj{s} '/motorR/motorR_0' d '.nii']);
        end
    end
end


clearvars; clc; close all;

% This script moves all except for select gradients from one folder to another.
% For questions: theodore.turesky@childrens.harvard.edu

fp = '/Users/cinnamon/Documents/'; % path to subject folder

sub = {'pilot9'}; % subject IDs

r = {[4 6 19 27 28]}; % gradients to discard


for i = 1:size(sub,2)
    mkdir([fp '/' sub{i} '/dti/rawQCed'])
    s = r{i}+1;
    D = dir2([fp '/' sub{i} '/dti/regDTI_30dir_b1000_iPAT2/*']); 

    for ii = 1:size(D,1)
       x = dicominfo([fp '/' sub{i} '/dti/regDTI_30dir_b1000_iPAT2/' D(ii).name]);
       y = x.AcquisitionNumber;
       if ismember(y,s) == 0
           copyfile([fp '/' sub{i} '/dti/regDTI_30dir_b1000_iPAT2/' D(ii).name],[fp '/' sub{i} '/dti/rawQCed'])
       end
       clear x y
    end
end
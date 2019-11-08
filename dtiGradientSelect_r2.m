clearvars; clc; close all;

% This script moves all except for select gradients from one folder to another.
% For questions: theodore.turesky@childrens.harvard.edu


D =  {'Documents'}; % dir2(path);
n = 1; % change to zero if already converted from gradient to volumes

u = input('When the window appears, please select the folder containing dicoms for the first subject. OK? (y/n)  ','s');
fold1 = uigetdir('','Select first subject raw dti dicom folder');
%fold1 = fold1(1:120);

sub1 = input('What is the ID of the first subject?  ','s'); % subject IDs
k1 = strfind(fold1,sub1);
kn = k1+numel(sub1);
path = fold1(1:(k1-1));

v = input('Next, you are going to select the csv file containing the problematic gradients. OK? (y/n) ','s');
[f p] = uigetfile();
grad = regexp(fileread([p f]),'[\n\r]+','split');
grad = cellfun(@(s)sscanf(s,'%f,').', grad, 'UniformOutput',false);


for i = 1:size(D,1)
    ee = strrep(fold1(1:kn),sub1,num2str(D{i,1}));
    mkdir([ee 'DTI_QCToolAFQ/dicom2']);
    ff = strrep(fold1,sub1,num2str(D{i,1}));
    if i <= (size(grad,2));
        s = grad{1,i}+n;
    else
        s = [];
    end
    dic = dir2([ff '/*']);

    for ii = 1:size(dic,1)
       x = dicominfo([ff '/' dic(ii).name]);
       y = x.AcquisitionNumber;
       if ismember(y,s) == 0
          copyfile([ff '/' dic(ii).name],[ee 'DTI_QCToolAFQ/dicom2'])
       end
       clear x y
    end
end

% else
%     disp('number of subjects as indicated by bad gradients list, is different than number of subject directories')
% end
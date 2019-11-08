clear all; clc; close all;

M = load_untouch_nii('/Volumes/FunTown/allAnalyses/BangRS/processing/method3/rmot1inc2nd.nii'); % load mask from method 1
M.img(isnan(M.img))=0;
E = logical(M.img);
path = '/Volumes/FunTown/allAnalyses/BangRS/processing/connBangAdultTempICA2-seeds2/results/firstlevel/ANALYSIS_01/'; % path to BETA files for method 2
p = '005'; % source # 010
c = '001'; % condition #

nsub = 31; % number of subjects used in method 2


for i = 1:nsub 
    k = num2str(i);
    if i<10
        a = load_untouch_nii([path 'BETA_Subject00' k '_Condition' c '_Source' p '.nii']);
    else
        a = load_untouch_nii([path 'BETA_Subject0' k '_Condition' c '_Source' p '.nii']);
    end
    
   G = a.img.*single(E);
   y = find(G);
   h = y-100000;
   small(i,:) = mean(G(y));
   other(i,:) = mean(G(h));
end
    
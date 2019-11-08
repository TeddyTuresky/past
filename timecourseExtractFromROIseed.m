clear all; clc;

loc = 145;
cond = 2;
nsub = 30;
c = num2str(cond);

for i = 1:nsub
    k = num2str(i);
    if i < 10
        roi = load(['/Volumes/TKT/dyslexiaAnalysis/conn-updat-Art1-bpRS/results/preprocessing/ROI_Subject00' k '_Condition00' c '.mat']);
    else
        roi = load(['/Volumes/TKT/dyslexiaAnalysis/conn-updat-Art1-bpRS/results/preprocessing/ROI_Subject0' k '_Condition00' c '.mat']);
    end
    
    ntime = size(roi.data{1,loc},1);
    for ii = 1:ntime
        roiTC(ii,i) = roi.data{1,loc}(ii,1);
    end
end
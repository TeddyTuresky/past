clear all; close all; clc
cd /Volumes/TKT/subAnalysis-rh-corr

nscans = 64;

long = 'adults';
subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
    '12';'13';'14';'15';'16';'17']; 
  
        
for i = 1:length(subj)
    k = num2str(subj(i,:));
    cd(['a' k '/motorR']);
    R1 = load('rp_amotorR_004.txt');
    R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
    G = load('global_mean.txt');

    if all(R2 == 0);
        R2(1,1) = 1; % need to have at least one non-zero value in the
                    % regressor list. Otherwise, some subjects will
                    % end up with a greater number of regressors.
    end


    %Combine
    A1 = [R1(:,4:6) R2 G];
    fp = fopen('rotArtGlob.txt','wt');
    for ii = 1:nscans
        fprintf(fp,'%d %d %d %d %d\n',A1(ii,:));
    end
    fclose(fp);
    cd ../../
end
clear all;clc
for i = 41:46
    
    if i<10
        eval(sprintf('cd /Users/doggybot/Documents/MotorAnalysis/c0%d/Analysis/MotorR',i));
    else
        eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/English/e%d/Analysis/MotorR',i));
    end
    
    R1 = load('rp_004.txt');
    R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
    G = load('global_mean.txt');
    
    %Combine
    A1 = [R1 R2 G];
    fp = fopen('rpPlusglobalplusArt.txt','wt');
    for ii = 1:64
        fprintf(fp,'%d %d %d %d %d %d %d %d\n',A1(ii,:));
    end
    fclose(fp);
end
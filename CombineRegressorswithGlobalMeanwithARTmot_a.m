clear all;clc
for i = 1:17
    
     if i<10
        % eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a0%d/Analysis/MotorL',i));
         eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a0%d/Analysis/MotorR',i));
     else
       % eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a%d/Analysis/MotorL',i));
        eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a%d/Analysis/MotorR',i));
     end
    
    R1 = load('rp_004.txt');
    R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
    G = load('global_mean.txt');
    
    %Combine
    A1 = [R1(:,4:6) R2 G];
    fp = fopen('rp_rotPlusArtPlusGlobal.txt','wt');
    for ii = 1:64
        fprintf(fp,'%d %d %d %d %d\n',A1(ii,:));
    end
    fclose(fp);
end
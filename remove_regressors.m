clearvars; clc; close all;
% this script removes a regressor column from the multiple regressor file
% used in first-level statistics


for i = 1:17
    
    if i<10
        eval(sprintf('cd W:/Graduate_Students/ted/MotorDataAnalysis/Adults/a0%d/Analysis/MotorL',i));
    else
        eval(sprintf('cd W:/Graduate_Students/ted/MotorDataAnalysis/Adults/a%d/Analysis/MotorL',i));
    end
    
    R1 = load('rp_rotPlusArtPlusGlobal_1.txt');
    
    %Remove regressor
    A1 = R1(:,1:4);
    A2 = R1(:,1:3);
    fp = fopen('rp_rotPlusArt_1.txt','wt');
    fpt = fopen('rp_rot.txt','wt');
    for ii = 1:64
        fprintf(fp,'%d %d %d %d\n',A1(ii,:));
        fprintf(fpt,'%d %d %d\n',A2(ii,:));
    end
    fclose(fp);
    fclose(fpt);
end
clear all;clc
for i = 1:9
        eval(sprintf('cd W:\Graduate_Students\ted\MotorDataAnalysis\Adults\a0%d\Analysis\MotorL;',i));
        
        R1 = load('rp_004.txt');
        R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
        % G = load('global_mean.txt');
       
        % R1_rot = R1(:,4:6); % rotation motion only
        R2(1,1) = 1;  % add 1 to Art
        
        %Combine
        A1 = [R1 R2];
        fp = fopen('rpPlusArt_1.txt','wt');
        for ii = 1:64
            fprintf(fp,'%d %d %d %d %d %d %d\n',A1(ii,:));
        end
        
        fclose(fp);
         
end

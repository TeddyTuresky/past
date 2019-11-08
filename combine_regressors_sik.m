clear all;clc

for i = [11470 14483 24756 34308 39159 45085 68875 71693 73106 75020 79339 80197 82679 93524 96299];
    
        eval(sprintf('cd /export/w/Visitors/Sikoya/Data_Sikoya/RotationData_MonolingualControlAdults/s%d/analysis/IR_both',i));
        
        eval(sprintf('R1 = load(''rp_%d-IR1-006.txt'')',i));
        R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
        G = load('global_mean.txt');
               
        %Combine
        A1 = [R1 R2 G];
        fp = fopen('rpPlusArtPlusGlobal_1.txt','wt');
        for ii = 1:168
            fprintf(fp,'%d %d %d %d %d %d %d %d\n',A1(ii,:));
        end
        
        fclose(fp);
         
end

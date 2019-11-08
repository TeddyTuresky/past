clear all;clc

for i = [19583 26914 29453 34429 46096 46787 50931 64738 66592 74498 74905 85126 87498 92607];
    
        eval(sprintf('cd /export/w/Visitors/Edith/Rotation/RotationData_BilingualControlAdults/s%d/Analysis/%d_English_IRBoth',i,i)); % need to change directory
        
        k = num2str(i);
        
        R1 = load(['rp_' k '.txt']); % need to change this
        R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
        G = load('global_mean.txt');
        
        if all(R2 == 0);
            R2(1,1) = 1; % need to have at least one non-zero value in the
        end              % regressor list. Otherwise, some subjects will
                         % end up with a greater number of regressors
                         
        %Combine
        A1 = [R1 R2 G];
        fp = fopen('rpArtGlobal_1.txt','wt');
        for ii = 1:84
            fprintf(fp,'%d %d\n',A1(ii,:));
        end
        
        fclose(fp);
         
end

clear all;clc

for i = 1:17
    
     if i<10
         eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a0%d/Analysis/MotorL',i));
         % eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a0%d/Analysis/MotorR',i));
     else
        eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a%d/Analysis/MotorL',i));
        % eval(sprintf('cd /export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a%d/Analysis/MotorR',i));
     end
    
    B = load('rp_rotPlusArtPlusGlobal.txt');
    B(1,4) = 1;

    fp = fopen('rp_rotPlusArtPlusGlobal_1.txt','wt');
    for ii = 1:64
        fprintf(fp,'%d %d %d %d %d\n',B(ii,:));
    end
    fclose(fp);
end
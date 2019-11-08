clear all; close all; clc
cd /Volumes/TKT/MotorAnalysis/

hand = ['L';'R']; 
group = ['a';'c'];
nscans = 64;

for h = 1:length(hand);
    hand1 = hand(h);
    for g = 1:length(group);
        group1 = group(g);
        if group1 == 'a';
            long = 'adults';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'13';'14';'15';'16';'17']; 
        else
            long = 'children';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23'];
        end
        
        for i = 1:length(subj)
            k = num2str(subj(i,:));
            cd([long '/' group1 k '/analysis/motor' hand1]);
            R1 = load(['rp_amotor' hand1 '_004.txt']);
            R2 = load('BadScanRegressors_1.5perc_0.75mm.txt');
            G = load('global_mean.txt');
            
            if all(R2 == 0);
                R2(1,1) = 1; % need to have at least one non-zero value in the
                            % regressor list. Otherwise, some subjects will
                            % end up with a greater number of regressors.
            end
            
            rp_deg(:,1:3)= R1(:,4:6)*180/pi; % Convert rotation movement to degrees
                delta = zeros(nscans,1);                 
                for r = 2:nscans
                    delta_trn(r,1) = (R1(r-1,1) - R1(r,1))^2 +...
                        (R1(r-1,2) - R1(r,2))^2 +...
                        (R1(r-1,3) - R1(r,3))^2;
                    delta_trn(r,1) = sqrt(delta_trn(r,1));
                    delta_rot(r,1) = 1.28*(rp_deg(r-1,1) - rp_deg(r,1))^2 +...
                        1.28*(rp_deg(r-1,2) - rp_deg(r,2))^2 +...
                        1.28*(rp_deg(r-1,3) - rp_deg(r,3))^2;
                    delta_rot(r,1) = sqrt(delta_rot(r,1));
                    delta(r,1) = (R1(r-1,1) - R1(r,1))^2 +...
                        (R1(r-1,2) - R1(r,2))^2 +...
                        (R1(r-1,3) - R1(r,3))^2 +...
                        1.28*(rp_deg(r-1,1) - rp_deg(r,1))^2 +...
                        1.28*(rp_deg(r-1,2) - rp_deg(r,2))^2 +...
                        1.28*(rp_deg(r-1,3) - rp_deg(r,3))^2;
                    delta(r,1) = sqrt(delta(r,1));
                end
            
            %Combine
            A1 = [R1(:,4:6) R2];
            fp = fopen('rotArt_noGlob.txt','wt');
            for ii = 1:nscans
                fprintf(fp,'%d %d %d %d\n',A1(ii,:));
            end
            fclose(fp);
            cd ../../../../
        end
    end
end
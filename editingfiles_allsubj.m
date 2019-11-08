clear all; close all; clc
cd /Volumes/TKT/dyslexiaAnalysis

dir = 'rpRMSartGlobal';

hand = ['L';'R']; 
group = ['cp';'dp';'ca'];

for h = 1:length(hand);
    hand1 = hand(h);
    for g = 1:length(group);
        group1 = group(g,:);
        if group1 == 'cp';
            long = 'conped';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';
                '90';'91']; 
        elseif group1 == 'dp'
            long = 'dysped';
            subj = ['01';'02';'03';'04';'05';'06';'07';'08'; '09';'10';'11';
                '12';'13';'14';'15';'16';'17';'18';'19';'20';'21';'22';'23';
                '24';'25';'26';'27';'28';'29';'30';'31';'32';'33';'34';'35';
                '36';'37';'38';'39';'40';'41';'90';'91';'92';'93';'94'];
        else
            long = 'conped_pres';
            subj = ['01';'04';'05';'07';'10';'11';'12';'14';'15';'17';'18';
                '20';'22'];
        end
        
        for i = 1:length(subj);
        	try
                if isdir([long '/' group1 subj(i,:) '/analysis/motor' hand1]) == 1;
                    mkdir([long '/' group1 subj(i,:) '/analysis/motor' hand1],dir);
                end
                %copyfile([long '/' group1 subj(i,:) '/motor' hand1],[long '/' group1 subj(i,:) '/analysis/motor' hand1]);
                %copyfile([long '/' group1 subj(i,:) '/mprage3'],[long '/' group1 subj(i,:) '/analysis/mprage3']);
                %delete([long '/' group1 subj(i,:) '/analysis/*']);
            catch
                disp([subj(i,:) 'did not make'])
            end
        end
    end
end
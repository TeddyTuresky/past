clear all; clc;

cd /Volumes/FunTown/allAnalyses/BangRS/other/InterData/
D = dir2('*');

% D =  {'PRE_INF044_T2_20171209'};
    
% 'PRE_INF002_T3_20170221';
% 'PRE_INF003_T3_20170126';
% 'BEG_INF007_T3_20161230';
% 'PRE_INF010_T2_20161215';
% 'PRE_INF012_T3_20161219';
% 'BEG_INF013_T3_20170105';
% 'PRE_INF015_T3_20170418';
% 'PRE_INF017_T3_20161012';
% 'PRE_INF018_T3_20161102';
% 'PRE_INF020_T3_20161018';
% 'PRE_INF022_T3_20170217';
% 'PRE_INF029_T3_20161205';
% 'PRE_INF030_T2_20180217';
% 'PRE_INF031_T2_20180217';
% 'PRE_INF033_T3_20161118';
% 'PRE_INF034_T3_20161118';
% 'PRE_INF035_T3_20161116';
% 'PRE_INF037_T3_20161229';
% 'PRE_INF041_T3_20170726'};

j = 1;

for i=1:size(D,1)
    
    if exist([D(i).name '/dtitrilin'],'dir') == 7
    G{j,1} = D(i).name;
    %sub_dirs{1,j}=['/Volumes/FunTown/allAnalyses/BangRS/other/InterData/',D(i).name,'/dtitrilin'];
    j = j + 1;
    end
    
    
end

sub_group=ones(1,size(sub_dirs,2));

afq = AFQ_Create('cutoff',[5,95],'sub_dirs',sub_dirs,'sub_group',sub_group);
afq.params.track.faThresh = 0.1;
afq.params.track.faMaskThresh = 0.1;
afq.params.track.angleThresh = 40;

[afq patient_data control_data norms abn abnTracts] = AFQ_run(sub_dirs, sub_group, afq);

save ('/Volumes/FunTown/allAnalyses/BangRS/dti/output1.mat');
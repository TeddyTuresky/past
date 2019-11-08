

clear all; clc;

cd /Users/doggybot/Documents/MotorAnalysis/children

K = ls('-d','*');
subj = strsplit(strtrim(K));
n_subj = length(subj);
for i = 1:n_subj
    cd(subj{i})
    L = ls('-d','*');
    run = strsplit(strtrim(L),{'\t','\n'});
    n_run = length(run);
    mkdir('analysis');
    mkdir('rawData');
    
    for ii = 1:n_run
        movefile(run{ii},'rawData');
    end
    cd ../
end
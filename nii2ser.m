clear all; clc

cd /Volumes/y/cfmi_data/csl_data5

subj = dir('*');
con_subj = strvcat(subj.name);
A = input('first subject ID?  ');
k = num2str(A);
b = ismember(con_subj,k, 'rows');  
indx = find(b,1);
n_subj = length(subj) - indx + 1; 

for h = 1:n_subj; 
    g = subj(h+indx-1).name; 
    eval(sprintf('sess = dir(''%s/*.STU'');',g));
    n_sess = length(sess);
    
    for i = 1:n_sess
        t = sess(i).name;
        eval(sprintf('cd ./%s/%s;',g,t));
        K = ls('-d','*/');
        C = strsplit(K,'/');
        runs = strtrim(C);
        n_run = length(runs);
    
        for ii = 1:n_run
            s = runs{ii};
            eval(sprintf('acq = dir(''%s/*.ACQ'');',s));
            n_acq = length(acq);
            
            for iii = 1:n_acq
                r = acq(iii).name;

                eval(sprintf('copyfile(''%s/%s/*.nii'',''%s'');',s,r,s));
            end
        end
        cd ../../
    end
end
    
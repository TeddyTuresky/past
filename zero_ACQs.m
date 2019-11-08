clear all; clc
% This script renames scan folders so dicom --> nifti conversion is easier.
% It does this by adding a 0 to the beginning of ACQ folders


cd /Volumes/y/cfmi_data/csl_data

subj = dir('*');
n_subj = length(subj) - 4; % dir command pulls unncecessary folders

for h = 1:n_subj;
    g = subj(h+4).name; % same reasoning as above
    eval(sprintf('cd ./%s/;',g));
    runs = dir('*.STU');
    n_runs = length(runs);
    
    for i = 1:n_runs
        t = runs(i).name;
        eval(sprintf('cd ./%s/;',t));
        SERs = dir('*.SER');
        n_SER = length(SERs);

        for ii = 1:n_SER
            s = SERs(ii).name;
            eval(sprintf('cd ./%s/;',s));
            ACQs = dir('*ACQ');
            n_ACQ = length(ACQs);

            for iii = 1:n_ACQ
                % k = num2str(ii);
                % d = [k '.ACQ'];
                % eval(sprintf('cd ./%s/;',d))

                str = ACQs(iii).name;
                k = strfind(str, '.');
                if k == 2
                     newname = ['0' str];
                     movefile(str,newname);
                end
            end
        cd ../    
        end
    cd ../    
    end
    cd ../
end
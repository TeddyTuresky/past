clear all; clc

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
                r = ACQs(iii).name;
                eval(sprintf('cd ./%s/',r));
                IMAs = dir('*.IMA');
                n_IMA = length(IMAs);
                
                if n_IMA > 60
                    delete *.nii
                    IMAs = strvcat(IMAs(:).name);
                    hdr = spm_dicom_headers(IMAs);

                    % convert DICOMs to .nii
%                     for iv = 1:n_IMA
%                         eval(sprintf('hdr(%d,1) = spm_dicom_headers(IMAs(%d).name);',iv,iv));
%                     end
                    spm_dicom_convert(hdr,'all','flat','nii');
                end
            cd ../
            end
        cd ../    
        end
    cd ../    
    end
    cd ../
end
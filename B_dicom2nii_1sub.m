clear all; clc

cd /Users/resky/Documents/10363

subj = '10363';
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

            % convert DICOMs to .nii
                if n_IMA > 60 % for MPRAGE files
                IMAs = strvcat(IMAs(:).name);
                hdr = spm_dicom_headers(IMAs);
                spm_dicom_convert(hdr,'all','flat','nii');

                else
                    for iv = 1:n_IMA % for EPI files
                        eval(sprintf('hdr = spm_dicom_headers(IMAs(%d).name);',iv));
                        spm_dicom_convert(hdr,'all','flat','nii');
                    end
                end
                cd ../
        end
        disp(['scan run ' s ' complete'])
        cd ../
    end
    disp(['scan session ' t ' complete'])
    cd ../
end
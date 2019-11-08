clear all; clc

cd /Volumes/y/cfmi_data/data4Edith

subj = dir('*');
n_subj = length(subj) - 2; % dir command pulls unncecessary folders. may need to change

for h = 1:n_subj;
    g = subj(h+2).name; % same reasoning as above
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
            cd ../
        end
        cd ../
    end
    cd ../
end

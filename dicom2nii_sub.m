clear all; clc

cd /Volumes/y/cfmi_data/csl_pract


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

            if n_IMA > 60
            % delete *.nii
            IMAs = strvcat(IMAs(:).name);
            hdr = spm_dicom_headers(IMAs);
            spm_dicom_convert(hdr,'all','flat','nii');

            else
                for iv = 1:n_IMA
                    eval(sprintf('hdr = spm_dicom_headers(IMAs(%d).name);',iv));
                    spm_dicom_convert(hdr,'all','flat','nii');
                end
            end
            cd ../
    end
    cd ../
end
  

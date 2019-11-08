clear all; clc

cd /Volumes/main10.csl.georgetown.edu/cfmi_data/csl_pract4

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

        rep = ones(n_SER,1);
        dataArray = {};
        dataArray_num = {};
        for ii = 1:n_SER
            s = SERs(ii).name;
            eval(sprintf('cd ./%s/;',s));
            ACQs = dir('*ACQ');
            n_ACQ = length(ACQs);

            IMAs = dir([ACQs(1).name '/*.IMA']);
            n_IMA = length(IMAs);

            % Form table of scan runs
            first_file = IMAs(1).name;
            info = dicominfo([ACQs(1).name '/' first_file]);
            dataArray{ii,1} = info.SeriesDescription;
            dataArray_num{ii,1} = [info.SeriesInstanceUID '.SER'];

            cd ../
        end                

        for iv = 2:n_SER
            for v = 1:(iv-1)
                if strcmp(dataArray{iv,1},dataArray{v,1})
                    rep(iv) = rep(iv) + 1;
                end
            end
        end

        g = int2str(rep);

        for vi = 1:n_SER
             dataArrayREP{vi,1} = [dataArray{vi,1} ' ' g(vi,:)];
        end
                
        % Rename SERs
        for vii = 1:n_SER    
            for viii = 1:n_SER
                if strcmp(SERs(vii).name,dataArray_num{viii,1})
                   movefile(SERs(vii).name,dataArrayREP{viii,1});
                end
            end
        end
        
        cd ../
    end
    cd ../
    % clearvars rep dataArray dataArray_num dataArrayREP
end

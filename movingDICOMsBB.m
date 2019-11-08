clear all; clc; close all;
%does not work correctly if you have more than two runs of the same
%protocol.

cd /Users/cinnamon/Documents/babyMRIcomp
dep = '/Users/cinnamon/Documents/interBabyMRI';

k = ls('-d','*/');
sub = strsplit(strtrim(k));
nsub = length(sub); 


for i = 1:nsub
    a{i} = strsplit(strtrim(ls('-d',[sub{i} 'DICOM/*/*/*'])),{'\t','\n'});
    numa(i,1) = size(a{i},2);
    mkdir(dep,sub{i});
    
    for ii = 1:numa(i)
        if isdir(a{i}{ii}) == 0
%             [filepath,name] = fileparts(a{i}{ii});
%             fn{i}{ii} = name;


            try
                d{i}{ii} = dicominfo(a{i}{1,ii});
                p{i}{ii} = d{i}{ii}.SeriesDescription;
                t{i}{ii} = d{i}{ii}.SeriesTime;
                b{i}{ii} = d{i}{ii}.PatientBirthDate;
                q{i}{ii} = d{i}{ii}.AcquisitionDate;
                mb{i}{ii} = str2num(b{i}{ii}(5:6));
                mq{i}{ii} = str2num(q{i}{ii}(5:6));
                db{i}{ii} = str2num(b{i}{ii}(7:8))/30; % estimate 30 days/month
                dq{i}{ii} = str2num(q{i}{ii}(7:8))/30;
                
                age{i}(ii,1) = (mq{i}{ii}+dq{i}{ii})-(mb{i}{ii}+db{i}{ii});
            
                if isdir([dep '/' sub{i} p{i}{ii}]) == 1 
                    depf = dir2([dep '/' sub{i} p{i}{ii}]);
                    d2 = dicominfo([dep '/' sub{i} p{i}{ii} '/' depf(1).name]);
                    if strcmp(d2.SeriesTime,t{i}{ii}) == 1
                        copyfile(a{i}{1,ii},[dep '/' sub{i} p{i}{ii}]);
                    else
                        mkdir ([dep '/' sub{i} p{i}{ii} '_2'])
                        copyfile(a{i}{1,ii},[dep '/' sub{i} p{i}{ii} '_2']);
                    end
                else
                    mkdir([dep '/' sub{i} p{i}{ii}]);
                    copyfile(a{i}{ii},[dep '/' sub{i} p{i}{ii}]);
                end
            
            catch
                disp(['missing data for ' a{i}{1,ii}]);
            end
        end
        
    end
    aage(i,1) = mean(age{i},1);


end    
 
    
        
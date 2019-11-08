% this script will change the names of all the .SER files (run files),
% according to the order indicated in the serdes.txt files

clear all; clc;

cd /Volumes/main10.csl.georgetown.edu/cfmi_data/csl_pract

subj = dir('*');
n_subj = length(subj) - 4; % dir command pulls ncecessary folders (minus 4 unnecessary)
for h = 1:n_subj;
    g = subj(h+4).name; % same reasoning as above
    eval(sprintf('cd ./%s/;',g));
    sess = dir('*.STU');
    n_sess = length(sess);
    
    for i = 1:n_sess
    t = sess(i).name;
        eval(sprintf('cd ./%s/;',t));

% Initialize variables.
filename = [pwd '/serdes.txt'];
delimiter = '\t';

% Format string for each line of text:
%   column1: text (%s)
%	column2: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

% Close the text file.
fclose(fileID);



% Suffix repeat SER names
            n_dat = length(dataArray{1});
            rep = ones(n_dat,1);

            for ii = 2:n_dat
                for iii = 1:(ii-1)
                    if strcmp(dataArray{:,1}{ii},dataArray{:,1}{iii})
                        rep(ii) = rep(ii) + 1;
                    end
                end
            end

            g = int2str(rep);

            for iv = 1:n_dat
            %    if rep(iv) > 1
                    dataArrayREP{iv,1} = [dataArray{:,1}{iv} ' ' g(iv,:)];
            %    else
            %        dataArrayREP{iv,1} = dataArray{:,1}{iv};
            %    end
            end

% Rename SERs
           SERs = dir('*.SER');
           n_SER = length(SERs); 
           for v = 1:n_SER
                for vi = 1:n_SER
                    if strcmp(SERs(v).name,dataArray{:,2}{vi})
                       movefile(SERs(v).name,dataArrayREP{vi});
                    end
                end
           end
   
 % clearvars filename delimiter formatSpec fileID dataArray dataArrayREP ans rep;

           cd ../

    end
    cd ../
end
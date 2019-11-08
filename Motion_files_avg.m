%This produces a spreadsheet with motion parameters for each subject,
%motorL or motorR.
%It will ask you to select the number of the 1st scan. For instance if you
%exlcude the 1st 3 scans due to a desire to minimize T1 effects in your
%data, you would input 4
%Next it will ask for a inter-scan threshold cut-off. The default is 0.2mm
%Finally it will ask for the directory in which the motion parameter file
%is.
clear path program_path filenames
first_scan = spm_input('Number of the 1st scan processed',1,'n',1,1);%should not be greater than 10
cutoffmm = spm_input(sprintf('Inter-scan thresh. in mm'),1,'r',0.2,1);%This is the inter-scan movement threshold
input = spm_select(Inf,'dir','Select Directory');
for i=1:size(input,1)
    filenames{i,1}=input(i,:);
end

current_dir=pwd;
ScreenView = 0;
AdjustRPfiles=0;
rrs = get(0,'screensize');
rrf = get(0,'defaultfigurepos');
dllw = get(0,'defaultlinelinewidth');
dalw = get(0,'defaultaxeslinewidth');
m = min((rrs(3)-200)/rrf(3), (rrs(4)-200)/rrf(4));
defpos = [200, rrs(4)-m*rrf(4), m*rrf(3), m*rrf(4)];
set(0,'defaultfigurepos',defpos);

set(0,'defaultaxeslinewidth',2);
set(0,'defaultlinelinewidth',2);

values_matrix_header = {'mean_interscanx','maxinterscanx','stdinterscanx','mean_firstscanx'...
    'maxfirstscanx','stdfirstscanx','mean_interscany','maxinterscany','stdinterscany'...
    'mean_firstscany','maxfirstscany', 'stdfirstscany','mean_interscanz','maxinterscanz'...
    'stdinterscanz''mean_firstscanz','maxfirstscanz','stdfirstscanz','hand','subject'}; 
values_matrix = zeros(size(input,1),20); % average values by subject and hand
for i=1:size(filenames,1);
                     clear rp trim_filename numelrp interscanx interscany interscanz firstscanx firstscany firstscanz maxmvmntx maxmvmnty maxmvmntz numel
                     trim_filename = strtrim(filenames{i});  
                     rp=sprintf('%srp_00%d.txt',trim_filename,first_scan);
                     fclose('all');
                     g=0;
                            rp = spm_load(rp);

                            numelrp = numel(rp(:,1));

                            interscanx = zeros(numelrp-1,1);
                            interscany = zeros(numelrp-1,1);
                            interscanz = zeros(numelrp-1,1);
                            firstscanx = zeros(numelrp-1,1);
                            firstscany = zeros(numelrp-1,1);
                            firstscanz = zeros(numelrp-1,1);

                            for m = 1:numelrp-1
                                interscanx(m,1) = rp(m+1,1)-rp(m,1);
                                interscany(m,1) = rp(m+1,2)-rp(m,2);
                                interscanz(m,1) = rp(m+1,3)-rp(m,3);
                                firstscanx(m,1) = rp(m+1,1)-rp(1,1);
                                firstscany(m,1) = rp(m+1,2)-rp(1,2);
                                firstscanz(m,1) = rp(m+1,3)-rp(1,3);
                            end;

                            absinterscanx = abs(interscanx);
                            absinterscany = abs(interscany);
                            absinterscanz = abs(interscanz);
                            absfirstscanx = abs(firstscanx);
                            absfirstscany = abs(firstscany);
                            absfirstscanz = abs(firstscanz);
                            
                            mean_interscanx = mean(absinterscanx);
                            mean_interscany = mean(absinterscany);
                            mean_interscanz = mean(absinterscanz);
                            mean_firstscanx = mean(absfirstscanx);
                            mean_firstscany = mean(absfirstscany);
                            mean_firstscanz = mean(absfirstscanz);
                            
                            maxinterscanx = max(absinterscanx);
                            maxinterscany = max(absinterscany);
                            maxinterscanz = max(absinterscanz);
                            maxfirstscanx = max(absfirstscanx);
                            maxfirstscany = max(absfirstscany);
                            maxfirstscanz = max(absfirstscanz);
                            stdinterscanx = std(absinterscanx);
                            stdinterscany = std(absinterscany);
                            stdinterscanz = std(absinterscanz);
                            stdfirstscanx = std(absinterscanx);
                            stdfirstscany = std(absinterscany);
                            stdfirstscanz = std(absinterscanz);

                            values_matrix(i,1) = mean_interscanx;
                            values_matrix(i,2) = maxinterscanx;
                            values_matrix(i,3) = stdinterscanx;
                            values_matrix(i,4) = mean_firstscanx;
                            values_matrix(i,5) = maxfirstscanx;
                            values_matrix(i,6) = stdfirstscanx;
                            
                            values_matrix(i,7) = mean_interscany;
                            values_matrix(i,8) = maxinterscany;
                            values_matrix(i,9) = stdinterscany;
                            values_matrix(i,10) = mean_firstscany;
                            values_matrix(i,11) = maxfirstscany;
                            values_matrix(i,12) = stdfirstscany;
                            
                            values_matrix(i,13) = mean_interscanz;
                            values_matrix(i,14) = maxinterscanz;
                            values_matrix(i,15) = stdinterscanz;
                            values_matrix(i,16) = mean_firstscanz;
                            values_matrix(i,17) = maxfirstscanz;
                            values_matrix(i,18) = stdfirstscanz;
                            
                            
                            % pulls characters from input to identify
                            % hands and subjects. Left = 1; Right = 2
                            % this part requires the path structure
                            % /subj/Analysis/MotorL
                          
                            T = input(i,:);
                            if strfind(T, 'MotorL') ~= 0;
                                values_matrix(i,19) = 1;
                                SL = strfind(T, 'MotorL');
                                BL = T((SL-12):(SL-11));
                                values_matrix(i,20) = str2num(BL);
                            else
                                % strfind(input(i), 'MotorL') == 0;
                                values_matrix(i,19) = 2;
                                SR = strfind(T, 'MotorR');
                                BR = T((SR-12):(SR-11));
                                values_matrix(i,20) = str2num(BR);
                            end
                            
                            % pulls characters from input to identify
                            % subjects
                            % S = strfind(input(i), 'a%f');
                            % subj
                            
                            % subj = sscanf(input(i),[current_dir,'Adults/']'%f'
                            %subj = sscanf(input(i),'/export/w/Graduate_Students/ted/MotorDataAnalysis/Adults/a%f/MotorL',[2,inf]);
end                            
                            
% write spreadsheet to excel
xlswrite('all_motion',values_matrix);

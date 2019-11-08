%This produces a spreadsheet describing the mean and max discplacements
%from the origin and inter-scan movements.
%It will ask you to select the number of the 1st scan. For instance if you
%exlcude the 1st 3 scans due to a desire to minimize T1 effects in your
%data, you would input 4
%Next it will ask for a inter-scan threshold cut-off. The default is 0.2mm
%Finally it will ask for the directory in which the motion parameter file
%is in.
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

for i=3:(size(filenames,1)+2);
                     clear rp trim_filename numelrp interscan_pit interscan_rol interscan_yaw...
                         firstscan_pit firstscan_rol firstscan_yaw
                     
                     trim_filename = strtrim(filenames{i});
                     if strfind(trim_filename,'motorL') ~= 0
                        a = 'R';
                     else a = 'L';
                     end
                     rp=sprintf('%s/rp_amotor%s_00%d.txt',trim_filename,a,first_scan);
                     fclose('all');
                     g=0;
                            rp = spm_load(rp);

                            numelrp = numel(rp(:,1));

                            interscan_pit = zeros(numelrp-1,1);
                            interscan_rol = zeros(numelrp-1,1);
                            interscan_yaw = zeros(numelrp-1,1);
                            firstscan_pit = zeros(numelrp-1,1);
                            firstscan_rol = zeros(numelrp-1,1);
                            firstscan_yaw = zeros(numelrp-1,1);

                            for m = 1:numelrp-1
                                interscan_pit(m,1) = rp(m+1,4)-rp(m,4);
                                interscan_rol(m,1) = rp(m+1,5)-rp(m,5);
                                interscan_yaw(m,1) = rp(m+1,6)-rp(m,6);
                                firstscan_pit(m,1) = rp(m+1,4)-rp(1,4);
                                firstscan_rol(m,1) = rp(m+1,5)-rp(1,5);
                                firstscan_yaw(m,1) = rp(m+1,6)-rp(1,6);
                            end;

                            absinterscan_pit = abs(interscan_pit);
                            absinterscan_rol = abs(interscan_rol);
                            absinterscan_yaw = abs(interscan_yaw);
                            absfirstscan_pit = abs(firstscan_pit);
                            absfirstscan_rol = abs(firstscan_rol);
                            absfirstscan_yaw = abs(firstscan_yaw);

                            mean_interscan_pit = mean(absinterscan_pit);
                            mean_interscan_rol = mean(absinterscan_rol);
                            mean_interscan_yaw = mean(absinterscan_yaw);
                            mean_firstscan_pit = mean(absfirstscan_pit);
                            mean_firstscan_rol = mean(absfirstscan_rol);
                            mean_firstscan_yaw = mean(absfirstscan_yaw);
                            
                            maxinterscan_pit = max(absinterscan_pit);
                            maxinterscan_rol = max(absinterscan_rol);
                            maxinterscan_yaw = max(absinterscan_yaw);
                            maxfirstscan_pit = max(absfirstscan_pit);
                            maxfirstscan_rol = max(absfirstscan_rol);
                            maxfirstscan_yaw = max(absfirstscan_yaw);
                            stdinterscan_pit = std(absinterscan_pit);
                            stdinterscan_rol = std(absinterscan_rol);
                            stdinterscan_yaw = std(absinterscan_yaw);
                            stdfirstscan_pit = std(absinterscan_pit);
                            stdfirstscan_rol = std(absinterscan_rol);
                            stdfirstscan_yaw = std(absinterscan_yaw);

                            values_matrix(i,1) = mean_interscan_pit;
                            values_matrix(i,2) = maxinterscan_pit;
                            values_matrix(i,3) = stdinterscan_pit;
                            values_matrix(i,4) = mean_firstscan_pit;
                            values_matrix(i,5) = maxfirstscan_pit;
                            values_matrix(i,6) = stdfirstscan_pit;
                            
                            values_matrix(i,7) = mean_interscan_rol;
                            values_matrix(i,8) = maxinterscan_rol;
                            values_matrix(i,9) = stdinterscan_rol;
                            values_matrix(i,10) = mean_firstscan_rol;
                            values_matrix(i,11) = maxfirstscan_rol;
                            values_matrix(i,12) = stdfirstscan_rol;
                            
                            values_matrix(i,13) = mean_interscan_yaw;
                            values_matrix(i,14) = maxinterscan_yaw;
                            values_matrix(i,15) = stdinterscan_yaw;
                            values_matrix(i,16) = mean_firstscan_yaw;
                            values_matrix(i,17) = maxfirstscan_yaw;
                            values_matrix(i,18) = stdfirstscan_yaw;
                            
                            
                            % pulls characters from input to identify
                            % hands and subjects. Left = 1; Right = 2
                            % this part requires the path structure
                            % /subj/analysis/motorL
                            
                            hand = {};
                            if strfind(trim_filename, 'motorL') ~= 0;
                                  hand{i+2,1} = 'motorR';
                                
%                                 values_matrix(i,19) = 1;
%                                 SL = strfind(trim_filename, 'motorL');
%                                 BL = trim_filename((SL-12):(SL-11));
%                                 values_matrix(i,20) = str2num(BL);
                            else
                                hand{i+2,1} = 'motorL';
%                                 values_matrix(i,19) = 2;
%                                 SR = strfind(trim_filename, 'motorR');
%                                 BR = trim_filename((SR-12):(SR-11));
%                                 values_matrix(i,20) = str2num(BR);
                            end
                            subj = {};
                            if strfind(trim_filename, 'a') ~= 0;
                                  subj{i+2,1} = 'motorR';
                                
%                                 values_matrix(i,19) = 1;
%                                 SL = strfind(trim_filename, 'motorL');
%                                 BL = trim_filename((SL-12):(SL-11));
%                                 values_matrix(i,20) = str2num(BL);
                            else
                                hand{i+2,1} = 'motorL';
%                                 values_matrix(i,19) = 2;
%                                 SR = strfind(trim_filename, 'motorR');
%                                 BR = trim_filename((SR-12):(SR-11));
%                                 values_matrix(i,20) = str2num(BR);
                            end
                            
end                            
                            
% write spreadsheet to excel
xlswrite('all_rotation.xlsx',values_matrix);
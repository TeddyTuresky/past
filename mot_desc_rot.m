%This produces a spreadsheet describing the mean and max discplacements
%from the origin and inter-scan movements.
%It will ask you to select the number of the 1st scan. For instance if you
%exlcude the 1st 3 scans due to a desire to minimize T1 effects in your
%data, you would input 4
%Next it will ask for a inter-scan threshold cut-off. The default is 0.2mm
%Finally it will ask for the directory in which the motion parameter file
%is in.
clear all; clc;
clear path program_path filenames
first_scan = spm_input('Number of the 1st scan processed',1,'n',1,1);%should not be greater than 10
cutoffmm = spm_input(sprintf('Inter-scan thresh. in mm'),1,'r',0.2,1);%This is the inter-scan movement threshold
input = spm_select(Inf,'dir','Select Directory');
for i=1:size(input,1)
    filenames{i,1}=input(i,:);
end

hand = {};
subj = {};

for i=1:size(filenames,1);
         clear rp trim_filename numelrp interscan_pit interscan_rol interscan_yaw...
             firstscan_pit firstscan_rol firstscan_yaw

         trim_filename = strtrim(filenames{i});
         if strfind(trim_filename,'motorL') ~= 0
            a = 'L';
         else a = 'R';
         end
         rp=sprintf('%s/rp_amotor%s_00%d.txt',trim_filename,a,first_scan);
         fclose('all');
         g=0;
                rp = load(rp);

                numelrp = numel(rp(:,1));
                
                interscanx = zeros(numelrp-1,1);
                interscany = zeros(numelrp-1,1);
                interscanz = zeros(numelrp-1,1);
                firstscanx = zeros(numelrp-1,1);
                firstscany = zeros(numelrp-1,1);
                firstscanz = zeros(numelrp-1,1);
                interscan_pit = zeros(numelrp-1,1);
                interscan_rol = zeros(numelrp-1,1);
                interscan_yaw = zeros(numelrp-1,1);
                firstscan_pit = zeros(numelrp-1,1);
                firstscan_rol = zeros(numelrp-1,1);
                firstscan_yaw = zeros(numelrp-1,1);

                for m = 1:numelrp-1
                    interscanx(m,1) = rp(m+1,1)-rp(m,1);
                    interscany(m,1) = rp(m+1,2)-rp(m,2);
                    interscanz(m,1) = rp(m+1,3)-rp(m,3);
                    firstscanx(m,1) = rp(m+1,1)-rp(1,1);
                    firstscany(m,1) = rp(m+1,2)-rp(1,2);
                    firstscanz(m,1) = rp(m+1,3)-rp(1,3);
                    interscan_pit(m,1) = rp(m+1,4)-rp(m,4);
                    interscan_rol(m,1) = rp(m+1,5)-rp(m,5);
                    interscan_yaw(m,1) = rp(m+1,6)-rp(m,6);
                    firstscan_pit(m,1) = rp(m+1,4)-rp(1,4);
                    firstscan_rol(m,1) = rp(m+1,5)-rp(1,5);
                    firstscan_yaw(m,1) = rp(m+1,6)-rp(1,6);
                end;
                
                absinterscanx = abs(interscanx);
                absinterscany = abs(interscany);
                absinterscanz = abs(interscanz);
                absfirstscanx = abs(firstscanx);
                absfirstscany = abs(firstscany);
                absfirstscanz = abs(firstscanz);
                absinterscan_pit = abs(interscan_pit);
                absinterscan_rol = abs(interscan_rol);
                absinterscan_yaw = abs(interscan_yaw);
                absfirstscan_pit = abs(firstscan_pit);
                absfirstscan_rol = abs(firstscan_rol);
                absfirstscan_yaw = abs(firstscan_yaw);
                                            
                mean_interx(i,1) = mean(absinterscanx);
                mean_intery(i,1) = mean(absinterscany);
                mean_interz(i,1) = mean(absinterscanz);
                mean_firstx(i,1) = mean(absfirstscanx);
                mean_firsty(i,1) = mean(absfirstscany);
                mean_firstz(i,1) = mean(absfirstscanz);

                maxinterx(i,1) = max(absinterscanx);
                maxintery(i,1) = max(absinterscany);
                maxinterz(i,1) = max(absinterscanz);
                maxfirstx(i,1) = max(absfirstscanx);
                maxfirsty(i,1) = max(absfirstscany);
                maxfirstz(i,1) = max(absfirstscanz);
                
                stdinterx(i,1) = std(absinterscanx);
                stdintery(i,1) = std(absinterscany);
                stdinterz(i,1) = std(absinterscanz);
                stdfirstx(i,1) = std(absinterscanx);
                stdfirsty(i,1) = std(absinterscany);
                stdfirstz(i,1) = std(absinterscanz);

                mean_inter_pit(i,1) = mean(absinterscan_pit);
                mean_inter_rol(i,1) = mean(absinterscan_rol);
                mean_inter_yaw(i,1) = mean(absinterscan_yaw);
                mean_first_pit(i,1) = mean(absfirstscan_pit);
                mean_first_rol(i,1) = mean(absfirstscan_rol);
                mean_first_yaw(i,1) = mean(absfirstscan_yaw);

                maxinter_pit(i,1) = max(absinterscan_pit);
                maxinter_rol(i,1) = max(absinterscan_rol);
                maxinter_yaw(i,1) = max(absinterscan_yaw);
                maxfirst_pit(i,1) = max(absfirstscan_pit);
                maxfirst_rol(i,1) = max(absfirstscan_rol);
                maxfirst_yaw(i,1) = max(absfirstscan_yaw);
                
                stdinter_pit(i,1) = std(absinterscan_pit);
                stdinter_rol(i,1) = std(absinterscan_rol);
                stdinter_yaw(i,1) = std(absinterscan_yaw);
                stdfirst_pit(i,1) = std(absinterscan_pit);
                stdfirst_rol(i,1) = std(absinterscan_rol);
                stdfirst_yaw(i,1) = std(absinterscan_yaw);
                
                % Mean square displacement in two scans. Credited to Paul 
                % Mazaika, Sue Whitfield, Jeff Cooper, and Max Gray.
                rp_deg(:,1:3)= rp(:,4:6)*180/pi; % Convert rotation movement to degrees
                delta = zeros(numelrp,1);                 
                for r = 2:numelrp
                    delta(r,1) = (rp(r-1,1) - rp(r,1))^2 +...
                        (rp(r-1,2) - rp(r,2))^2 +...
                        (rp(r-1,3) - rp(r,3))^2 +...
                        1.28*(rp_deg(r-1,1) - rp_deg(r,1))^2 +...
                        1.28*(rp_deg(r-1,2) - rp_deg(r,2))^2 +...
                        1.28*(rp_deg(r-1,3) - rp_deg(r,3))^2;
                    delta(r,1) = sqrt(delta(r,1));
                end

                absdelta = abs(delta);
                mean_inter_disp(i,1) = mean(absdelta);
                max_inter_disp(i,1) = max(absdelta);
                std_inter_disp(i,1) = std(absdelta);
             
                % pulls characters from input to identify
                % hands and subjects. Left = 1; Right = 2
                % this part requires the path structure
                % /subj/analysis/motorL

                
                if strfind(trim_filename, 'motorL') ~= 0;
                    hand{i,1} = 'motorL';
                else
                    hand{i,1} = 'motorR';
                end

                k = strfind(trim_filename,'/');
                n_del = length(k);
                subj{i,1} = trim_filename((k(n_del-2) + 1):(k(n_del-1)-1));                                  
                         
end

% compute averages across dimensions
mean_inter_xyz = mean([mean_interx,mean_intery,mean_interz],2);
mean_first_xyz = mean([mean_firstx,mean_firsty,mean_firstz],2);
maxinter_xyz = mean([maxinterx,maxintery,maxinterz],2);
maxfirst_xyz = mean([maxfirstx,maxfirsty,maxfirstz],2);

mean_inter_pry = mean([mean_inter_pit,mean_inter_rol,mean_inter_yaw],2);
mean_first_pry = mean([mean_first_pit,mean_first_rol,mean_first_yaw],2);
maxinter_pry = mean([maxinter_pit,maxinter_rol,maxinter_yaw],2);
maxfirst_pry = mean([maxfirst_pit,maxfirst_rol,maxfirst_yaw],2);

% assemble table
empty = cell(size(input,1),1);
T = table(subj,hand,mean_interx,mean_intery,mean_interz,...
    mean_firstx,mean_firsty,mean_firstz,...
    maxinterx,maxintery,maxinterz,maxfirstx,...
    maxfirsty,maxfirstz,stdinterx,stdintery,...
    stdinterz,stdfirstx,stdfirsty,stdfirstz,...
    mean_inter_pit,mean_inter_rol,mean_inter_yaw,...
    mean_first_pit,mean_first_rol,mean_first_yaw,...
    maxinter_pit,maxinter_rol,maxinter_yaw,maxfirst_pit,...
    maxfirst_rol,maxfirst_yaw,stdinter_pit,stdinter_rol,...
    stdinter_yaw,stdfirst_pit,stdfirst_rol,stdfirst_yaw,empty,...
    mean_inter_xyz,mean_first_xyz,maxinter_xyz,maxfirst_xyz,...
    mean_inter_pry,mean_first_pry,maxinter_pry,maxfirst_pry,...
    empty,mean_inter_disp,max_inter_disp,std_inter_disp);

% write spreadsheet to excel
writetable(T,'mot_rotation.csv');
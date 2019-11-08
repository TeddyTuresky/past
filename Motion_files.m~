%This produces a pdf file with a plot of the motion parameters as well as
%a report of the number of scans that exceed a pre-set inter-scan threshold
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

for i=1:size(filenames,1);
                     clear rp trim_filename numelrp interscany interscanx interscanz firstscanx firstscany firstscanz maxmvmntx maxmvmnty maxmvmntz numel
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

                            maxinterscanx = sprintf('%0.3g',max(absinterscanx));
                            maxinterscany = sprintf('%0.3g',max(absinterscany));
                            maxinterscanz = sprintf('%0.3g',max(absinterscanz));
                            maxfirstscanx = sprintf('%0.3g',max(absfirstscanx));
                            maxfirstscany = sprintf('%0.3g',max(absfirstscany));
                            maxfirstscanz = sprintf('%0.3g',max(absfirstscanz));
                            stdinterscanx = sprintf('%0.3g',std(absinterscanx));
                            stdinterscany = sprintf('%0.3g',std(absinterscany));
                            stdinterscanz = sprintf('%0.3g',std(absinterscanz));
                            stdfirstscanx = sprintf('%0.3g',std(absinterscanx));
                            stdfirstscany = sprintf('%0.3g',std(absinterscany));
                            stdfirstscanz = sprintf('%0.3g',std(absinterscanz));
                            maxmvmntx = sprintf('%0.3g',max(rp(:,1))-min(rp(:,1)));
                            maxmvmnty = sprintf('%0.3g',max(rp(:,2))-min(rp(:,2)));
                            maxmvmntz = sprintf('%0.3g',max(rp(:,3))-min(rp(:,3)));
                            interscan1mmx = sprintf('%0.3g',100*(length(find(absinterscanx>cutoffmm))/length(absinterscanx)));
                            interscan1mmy = sprintf('%0.3g',100*(length(find(absinterscany>cutoffmm))/length(absinterscany)));
                            interscan1mmz = sprintf('%0.3g',100*(length(find(absinterscanz>cutoffmm))/length(absinterscanz)));
                            figure(i);
                            clear subplot plot text
                            subplot(3,1,1);
                            plot(rp(:,1:3));
                            set(gca,'xlim',[0 size(rp,1)+1]);
                            title('Motion Parameters: blue = x/pitch, green = y/roll, red= z/yaw ');
                            xlabel('Scan Number');
                            ylabel('Movement in mm');

                            subplot(3,1,2);
                            plot(rp(:,4:6));
                            set(gca,'xlim',[0 size(rp,1)+1]);
                            xlabel('Scan Number');
                            ylabel('Movement in degrees');
                            subplot(3,1,3);
                            text(0,1,'REALIGNMENT STATS (mm)');
                            text(0,.6,'max interscan mvmt');
                            text(0,.4,'std interscan mvmt');
                            text(0,.2,'max from origin');
                            text(0,0,'std from origin');
                            text(0,-.2,'max to min');
                            text(0,-.4,'%interscan>threshold');
                            text(.3,.8,'x');
                            text(.4,.8,'y');
                            text(.5,.8,'z');
                            text(.5,1,'Interscan Threshold (mm) =')
                            text(.8,1,num2str(cutoffmm));
                            text(.3,.6,maxinterscanx);
                            text(.4,.6,maxinterscany);
                            text(.5,.6,maxinterscanz);
                            text(.3,.4,stdinterscanx);
                            text(.4,.4,stdinterscany);
                            text(.5,.4,stdinterscanz);
                            text(.3,.2,maxfirstscanx);
                            text(.4,.2,maxfirstscany);
                            text(.5,.2,maxfirstscanz);
                            text(.3,0,stdfirstscanx);
                            text(.4,0,stdfirstscany);
                            text(.5,0,stdfirstscanz);
                            text(.3,-.2,maxmvmntx);
                            text(.4,-.2,maxmvmnty);
                            text(.5,-.2,maxmvmntz);
                            text(.3,-.4,interscan1mmx);
                            text(.4,-.4,interscan1mmy);
                            text(.5,-.4,interscan1mmz);
                            axis off;
                         SavedFilename = strtrim(sprintf('%s',filenames{i}));
                         cd(SavedFilename)
                          print('-painters', '-dpdf','Motion Parameters');
                          cd(current_dir);
                      fclose('all');
                    clf;
                    close; 
end



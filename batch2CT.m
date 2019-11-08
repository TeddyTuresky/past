clearvars; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sub = {'0001a' '0002ab' '0097p'};
load('With the path, whatever your matlabbatch is named (w/.mat)')
out = 'with the path, what name do you what the output file to be?';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

matlabbatch = repmat(matlabbatch,1,(length(subj)));

for j = 1:length(sub);
             for i = 1:n_img
                matlabbatch{1,j}.spm.spatial.realign.estwrite.data{1,1}{i,1} = strrep(matlabbatch{1,j}.spm.spatial.realign.estwrite.data{1,1}{i,1},sub{1},sub{j});
             end
end

save([out '.mat'],'matlabbatch');
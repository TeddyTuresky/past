clear all; clc;

cd /Volumes/TKT/MotorAnalysis/processing

proc = '7ModSpec-nomot_offsets';

aL = load([proc '-aL.mat']);
aR = load([proc '-aR.mat']);
cL = load([proc '-cL.mat']);
cR = load([proc '-cR.mat']);


matlabbatch = [aL.matlabbatch aR.matlabbatch cL.matlabbatch cR.matlabbatch];

save([proc '_all.mat'],'matlabbatch');
% this script renames .nii files with a prefix of your choice.

clear all; clc;


adult = ['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12';'13'...
    ;'14';'15';'16';'17'];
child = ['01';'02';'03';'04';'05';'06';'07';'08';'09';'10';'11';'12';'13'...
    ;'14';'15';'16';'17';'18';'19';'20';'21';'22';'23'];

cd /Users/doggybot/Documents/MotorAnalysis

for i = 1:length(adult)
    copyfile(['adults/a' adult(i,:) '/' 'rawData/*'],['adults/a' adult(i,:) '/analysis']);
end

for ii = 1:length(child)
    copyfile(['children/c' child(ii,:) '/' 'rawData/*'],['children/c' child(ii,:) '/analysis']);
end
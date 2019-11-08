clear all
error_message={};
error=1;

fp = '/Users/toor/Documents'; % directory containing gradients

sub =  {'pilot6/DTI_QCToolAFQ';'pilot7/DTI_QCToolAFQ';'pilot8/DTI_QCToolAFQ'};

subno = size(sub,1);

for i = 1:subno
    sub_dirs{1,i} = [fp '/' sub{i,1} '/dtitrilin'];
end
 

sub_group=zeros(1,subno);

afq = AFQ_Create('cutoff',[5,95],'sub_dirs',sub_dirs,'sub_group',sub_group);
afq.params.track.faThresh = 0.1;
afq.params.track.faMaskThresh = 0.1;
afq.params.track.angleThresh = 40;

[afq patient_data control_data norms abn abnTracts] = AFQ_run(sub_dirs, sub_group, afq);

save ([fp '/output_bang-pilots.mat']);
%%
% 2018.05.02
% 1.重新筛选心肌梗死的数据，仅从diag描述中筛选
% 2.随机选择相同比例的训练数据和测试数据

%%
clc
clear
path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\MI0502_MedianWave';

type = {'前壁心肌梗死','侧壁心肌梗死','前侧壁心肌梗死','前间隔心肌梗死','间壁心肌梗死','下壁心肌梗死','下后壁心肌梗死','急性心肌梗死','正常心电图'};
% for jj = 1:length(type)
%     MI_path = [path '\' type{jj}]; 
%     list = dir(fullfile(MI_path,'*.xml'));
%     disp([MI_path '  ' num2str(length(list))])
% end
classes_list = {'qianbi','cebi','qiancebi','qianjiange','jianbi','xiabi','xiahoubi','jixing','normal'};
organize_MI(path,outpth,type,classes_list);
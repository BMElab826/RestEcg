%%
% 2018.05.02
% 1.����ɸѡ�ļ����������ݣ�����diag������ɸѡ
% 2.���ѡ����ͬ������ѵ�����ݺͲ�������

%%
clc
clear
path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\MI0502_MedianWave';

type = {'ǰ���ļ�����','����ļ�����','ǰ����ļ�����','ǰ����ļ�����','����ļ�����','�±��ļ�����','�º���ļ�����','�����ļ�����','�����ĵ�ͼ'};
% for jj = 1:length(type)
%     MI_path = [path '\' type{jj}]; 
%     list = dir(fullfile(MI_path,'*.xml'));
%     disp([MI_path '  ' num2str(length(list))])
% end
classes_list = {'qianbi','cebi','qiancebi','qianjiange','jianbi','xiabi','xiahoubi','jixing','normal'};
organize_MI(path,outpth,type,classes_list);
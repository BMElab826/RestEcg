%%
% ���񣺸���ECG��meas_matrix�е�QA��RA��QD�жϸ�����Q�����쳣���

%% 
clc;
clear;
close;

rootpath = 'E:\DataBase\errorQ_180517';
matlist = dir(fullfile( rootpath, '*.mat' ));

%% ����ÿ��������Meas_Matrix
for ii=1:length(matlist)
    mat_path = fullfile(rootpath, matlist(ii).name);
    load(mat_path);
    for jj = 1:length(DATA)
        xml_name = DATA(jj).name;
        meas_matrix = DATA(jj).Meas_Matrix;
    end
end
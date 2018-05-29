%%
% 任务：根据ECG的meas_matrix中的QA、RA、QD判断各导联Q波正异常情况

%% 
clc;
clear;
close;

rootpath = 'E:\DataBase\errorQ_180517';
matlist = dir(fullfile( rootpath, '*.mat' ));

%% 读出每例样本的Meas_Matrix
for ii=1:length(matlist)
    mat_path = fullfile(rootpath, matlist(ii).name);
    load(mat_path);
    for jj = 1:length(DATA)
        xml_name = DATA(jj).name;
        meas_matrix = DATA(jj).Meas_Matrix;
    end
end
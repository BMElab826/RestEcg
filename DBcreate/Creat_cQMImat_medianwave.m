%% 
% day: 181509
% 保存每个样本的median_wave为mat, 并下采样为250Hz
% 同一个文件下的样本为同一类标签，以文件名来判定标签：
%       000000： 0
%       100000： 1
%       010000： 2
%       001000： 3
%       000100： 4
%       000010： 5
%%
clc;
clear;
close;
%%
rootpath = 'E:\DataBase\cQ_MI0508';
outpath = 'E:\DataBase\cQmat_MI0508';

%%
m=0;
subpath = dir(rootpath);
for ii = 1:length(subpath)
    if( isequal( subpath(ii).name, '.' )||...
        isequal( subpath(ii).name, '..')||...
        ~subpath(ii).isdir)               % 如果不是目录则跳过
        continue;
    end
    
    % 定义标签
    if strcmp(subpath(ii).name, '000000')
        label = '0';
    elseif strcmp(subpath(ii).name, '100000')
            label = '1';
    elseif strcmp(subpath(ii).name, '010000')
            label = '2';
    elseif strcmp(subpath(ii).name, '001000')
            label = '3';
    elseif strcmp(subpath(ii).name, '000100')
            label = '4';
    elseif strcmp(subpath(ii).name, '000010')
            label = '5';
    end
    
    % 保存路径
    savepath = fullfile(outpath, subpath(ii).name);
    if ~exist(savepath, 'dir')
        mkdir(savepath)
    end
    
    % 解析data，下采样，并保存
    xmlnames = dir(fullfile(rootpath, subpath(ii).name, '*.xml'));
    for jj = 1:length(xmlnames)
        xmlpath = fullfile(rootpath, subpath(ii).name, xmlnames(jj).name);
        [wave_median,adu,leads,fs,~] = get_medianwave(xmlpath);
        if fs==500
            wave_median = wave_median(1:2:end,:);
        end
%         wave_median = double(wave_median)*adu(1)/1000;
%         if length(medianwave) ~= 300 || length(leads) ~= 8
%             disp(xmlpath)
%             break
%         end
        m = m+1;
        disp(m)
        s = num2str(m, '%05d');
        savename = [label '_' s];
        save([savepath '\' savename], 'wave_median')            
    end   
end

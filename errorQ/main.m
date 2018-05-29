%%
% date: 2018.05.17
% author: huangjiao 
% 功能：
%     1、读出关于Q波的正异常描述
%     2、从异常Q波中解析出异常的导联情况，并写入变量1
%     3、从median_wave中找出Q波幅值，R波幅值，Q波时间，根据阈值，判断各导联的正异常情况，写入变量2
%     4、根据变量1、变量2计算各导联的准确率

% 阈值：根据ECG的meas_matrix中的QA、RA、QD判断各导联Q波正异常情况，找出阈值，参考明尼苏达编码
% 首先需要确认从median_wave中计算的QA、RA、QD与meas_metrix的差异
%%
clc
clear all;
close all;
data_path = 'E:\DataBase\180413ecg\data\raw_MI';  % raw_MI;Classify_f
draw = 0;

%%
sub_path = dir(data_path);
n = 0; m = 1; 
tQwave = []; pQwave = [];
leads_vector = [];  pre_leads_vector = [];
for ii = 1:length(sub_path)
    if( isequal( sub_path(ii).name, '.' )||...
        isequal( sub_path(ii).name, '..')||...
        ~sub_path(ii).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile( data_path, sub_path(ii).name, '*.xml' );
    xml_file = dir( subdirpath ); 
    %%
    for jj = 1:length(xml_file)
        class_path = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
        [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu]=musexmlread(class_path);
        wave_median = round(wave_median*adu);
       %% 
        tQwave(:,:,m) = Meas_Matrix(:, 3:5);
        tmp_leads_vector = read_lead_error(diag) ; % diag中没有“异常Q波”的描述时，返回为空
        if isempty(tmp_leads_vector) 
            tmp_leads_vector = zeros(1,12);
        elseif sum(tmp_leads_vector) == 0
            continue  
        end
        leads_vector(m, :) = tmp_leads_vector;
        median_wave12 = calu_median_wave12(wave_median); % 12导联各自的中值波形,按照 meas_matrix 导联顺序排列
        [QA, QD, RA] = calu_Q(median_wave12, Meas_Orig, fs); 
        pQwave(:,:,m) = [QA QD RA];
        pre_leads_vector(m,:) = predict_Q(QA, QD, RA); 
        Tpre_leads_vector(m,:) = predict_Q(Meas_Matrix(:, 3), Meas_Matrix(:, 4), Meas_Matrix(:, 5));
        m = m+1;
       %%
        % 绘图查看wave_meidan
        if draw ==1
            plot_wave_median(Meas_Orig, median_wave12, 12)
        end
        
%        %% 计算各导联的波形特征点位置 [Ponset P Poffset QRSonset R QRSoffset Tonset T Toffset]
%         meanRR = (rpos(end) - rpos(1)) / (length(rpos)-1);
%         rr = meanRR * 2; % 单位 ms
%         for mm = 1:12
%             lead_ecg = median_wave12(1:2:end,mm);
%             [waveposabs , amp] = matmgc('analyze_beat_v1', lead_ecg/1000 , rr);
%             figure;plot(lead_ecg);hold on;plot(waveposabs,lead_ecg(waveposabs),'*r');
% %                    hold on; plot(ceil(idxs/2),lead_ecg(ceil(idxs/2)),'.b');
%                    hold off;
%         end
                
    end                
end     
error_matrix = Qwave_argu_statistics(tQwave, pQwave);
% acc_leads_matrix = errorQ_statistics(leads_vector, pre_leads_vector);
[Acc_matrix, Sen_matrix, Spe_matrix]= errorQ_statistics(leads_vector, pre_leads_vector);
[TAcc_matrix, TSen_matrix, TSpe_matrix]= errorQ_statistics(leads_vector, Tpre_leads_vector);

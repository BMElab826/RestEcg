% 测试振幅法/面积法计算的心电轴
% 根据不同的方法测试结果
clc;
clear all;
close all;

load('E:\DataBase\MuseDB_500Hz.mat')
fid = fopen('cmp_diag.txt', 'w+');
fprintf(fid, 'ID, diag, diag_predict, RAxis, cul_RAxis, 绝对误差 \r\n');

fid20 = fopen('abs20.txt', 'w+');
fprintf(fid20, 'ID, diag, diag_predict, RAxis, cul_RAxis, 绝对误差 \r\n');

m = 1;  p=1; r=1; t=1;
pp=0; rr=0; tt=0;
cmp_PAxis = [];
cmp_RAxis = [];
cmp_TAxis = [];

total = 0;
corr = 0;
error = 0;
num = 0;

for ii = 1:length(DATA)
%% 从DATA中获取中值波形
%     ecgI = DATA(ii).wave_median(:, 1);
%     ecgII = DATA(ii).wave_median(:, 2);
%     ecgIII= ecgII - ecgI;
    wave0 = double(DATA(ii).wave_median)*DATA(ii).adu/1000;
    ecgI = wave0(:,1);
    ecgII = wave0(:,2);
    ecgIII = ecgII - ecgI;
    
%% 计算中值波行
%     ecg = DATA(ii).wave;
%     segdata =  beat_segment(ecg, DATA(ii).rpos, DATA(ii).QRStype, 0, 0.5, 0.7, DATA(ii).fs);
%     wave_median  = baseline_median(segdata,5); % way =1,2,3,4,5
%     ecgI = wave_median(:,1);
%     ecgII = wave_median(:,2);
%%
    rpos = [DATA(ii).Meas.POnset, DATA(ii).Meas.POffset, DATA(ii).Meas.QOnset, DATA(ii).Meas.QOffset, DATA(ii).Meas.TOffset];
%% 画图查看
%     figure
%     subplot(3,1,1)
%     plot_ecg_beat_type(ecgI,rpos,'()()('); title('Lead I');
%     subplot(3,1,2)
%     plot_ecg_beat_type(ecgII,rpos,'()()('); title('Lead II');
%     subplot(3,1,3)
%     plot_ecg_beat_type(ecgIII,rpos,'()()('); title('Lead III');
% 检测极值点
%     plot(ecgI)
%     [idx, extremum] = nibp_peakfind(ecgI, 1,0.01);
%     hold on; plot(idx,ecgI(idx),'r*');hold off;
%%
    try
        PAxis = DATA(ii).Meas.PAxis;
    catch
%         continue
%         non_PAxis(k) = ii;
%         k = k+1;
        PAxis = nan;
    end
    RAxis = DATA(ii).Meas.RAxis;
    TAxis = DATA(ii).Meas.TAxis;
%% 用 median wave 中的 PQRST 定位信息确定各波面积
%     [cul_PAxis, ~] = Area_EAxis(ecgI, ecgII, rpos(1), rpos(2), 'P');
%     [cul_RAxis, ~] = Area_EAxis(ecgI, ecgII, rpos(3), rpos(4), 'QRS');
%     [cul_TAxis, ~] = Area_EAxis(ecgI, ecgII, rpos(4), rpos(5), 'T');

%% 用的 Meas_Matrix 中各波的振幅的代数和
%     Meas_Matrix = DATA(ii).Meas_Matrix;
%     [cul_PAxis, cul_RAxis, cul_TAxis] = Amp_EAxis(Meas_Matrix );

%% 用的 Meas_Matrix 中各波的 QRS 面积
%     Meas_Matrix = DATA(ii).Meas_Matrix;
%     cul_PAxis = 0;
%     cul_RAxis = Area_Meas_Matrix(Meas_Matrix );
%     cul_TAxis = 0;

%% 用 median wave 中的 PQRST 定位信息确定各波段振幅最大值和最小值代数和
    cul_PAxis = acrdiac_EAxis(ecgI, ecgII, rpos(1), rpos(2));
    cul_RAxis = acrdiac_EAxis(ecgI, ecgII, rpos(3), rpos(4));
    cul_TAxis = acrdiac_EAxis(ecgI, ecgII, rpos(4), rpos(5));

%% 用 median wave 中的 PQRST 定位信息确定各波段振幅极值代数和
%     [cul_PAxis, ~] = extremum_EAxis(ecgI, ecgII, rpos(1), rpos(2), 'P');
%     [cul_RAxis, ~] = extremum_EAxis(ecgI, ecgII, rpos(3), rpos(4), 'QRS');
%     [cul_TAxis, ~] = extremum_EAxis(ecgI, ecgII, rpos(4), rpos(5), 'T');

%% 对比diag
    total = total +1;
    diag_Meas = DATA(ii).diag;
    diag_orig = DATA(ii).diag_orig;
    
% 1、读取DATA中 diag 和 diag_orig 的信息
%     diag_t = get_diag_t(diag_Meas, diag_orig);
% 2、都根据标准判断
    diag_t = cmp_diag(RAxis);
    
    diag = cmp_diag(cul_RAxis);
    if strfind(diag_t,diag)
        corr = corr +1;
    else
%         disp('_______________________________')
%         disp(ii)
%         disp(diag_t)
%         disp(diag)
        error = error+1;
        fprintf(fid, '%s, %s, %s, %d, %d, %d \r\n', num2str(ii), diag_t, diag, RAxis, cul_RAxis, abs(RAxis - cul_RAxis));
    end 
    

%% 计算绝对误差
    cmp_PAxis(m, :) = [PAxis, cul_PAxis, abs(PAxis - cul_PAxis) ];
    cmp_RAxis(m, :) = [RAxis, cul_RAxis, abs(RAxis - cul_RAxis) ];
    cmp_TAxis(m, :) = [TAxis, cul_TAxis, abs(TAxis - cul_TAxis) ];
    
    thre = 20;
    if abs(PAxis - cul_PAxis) <= thre
        pp = pp+1;
    end

    if abs(RAxis - cul_RAxis) <= thre
        rr = rr + 1;
    end

    if abs(TAxis - cul_TAxis) <= thre
        tt = tt+1;
    end
    m = m+1;
    
    if abs(RAxis - cul_RAxis) > 5
%         disp('--------------------------')
%         disp(ii)
%         disp(RAxis)
%         disp(cul_RAxis)
        num = num+1;
        if ~strcmp(diag_t, diag) 
            disp(ii)
        end
        fprintf(fid20, '%s, %s, %s, %d, %d, %d \r\n', num2str(ii), char(diag_t), diag, RAxis, cul_RAxis, abs(RAxis - cul_RAxis));
    end
    
end
    corr_percent = (corr/total)*100;
    percent_P = (pp/(m-1))*100;
    percent_R = (rr/(m-1))*100;
    percent_T = (tt/(m-1))*100;
    mean_diff_P = mean(cmp_PAxis(:,3));std_P = std(cmp_PAxis(:,3));
    mean_diff_R = mean(cmp_RAxis(:,3));std_R = std(cmp_RAxis(:,3));
    mean_diff_T = mean(cmp_TAxis(:,3));std_T = std(cmp_TAxis(:,3));
    
    subplot(3,1,1)
    plot(cmp_PAxis(:,3)); title(['mean' ' = ' num2str(mean_diff_P) '    '  'std'  '  =  '    num2str(std_P) ]);
    subplot(3,1,2)
    plot(cmp_RAxis(:,3)); title(['mean' ' = ' num2str(mean_diff_R) '    '  'std'  '  =  '    num2str(std_R) ]);
    subplot(3,1,3)
    plot(cmp_TAxis(:,3)); title(['mean' ' = ' num2str(mean_diff_T) '    '  'std'  '  =  '    num2str(std_T) ]);
 
    fclose(fid);
    fclose(fid20);





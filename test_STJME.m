clc;
clear all;
close all;

load('E:\DataBase\MuseDB_500Hz.mat')
for ii = 1:length(DATA)
    adu = DATA(ii).adu;
    wave_median = ceil(DATA(ii).wave_median * adu);
    meas_matrix = DATA(ii).Meas_Matrix;
    idxs = [DATA(ii).Meas.POnset, DATA(ii).Meas.POffset, DATA(ii).Meas.QOnset, DATA(ii).Meas.QOffset, DATA(ii).Meas.TOffset];
    rpos = DATA(ii).rpos;
%     for kk = 1:length(rpos)-1
%         RR(kk) = rpos(kk+1) - rpos(kk);
%     end
%     meanRR = mean(RR);
    meanRR = (rpos(end) - rpos(1)) / (length(rpos)-1);
    rr = meanRR * 2; % 单位 ms
    
%% 12导联各自的中值波形,按照 meas_matrix 导联顺序排列
    wave_me(:,1) = wave_median(:,3);  
    wave_me(:,2) = wave_median(:,4); 
    wave_me(:,3) = wave_median(:,5);  
    wave_me(:,4) = wave_median(:,6);  
    wave_me(:,5) = wave_median(:,7);  
    wave_me(:,6) = wave_median(:,8); 
    wave_me(:,7) = wave_median(:,1);   
    wave_me(:,8) = ceil(wave_median(:,1) - (wave_median(:,2)/2));    
    wave_me(:,9) = wave_median(:,2);           
    wave_me(:,10) = ceil(wave_median(:,2) - (wave_median(:,1)/2));
    wave_me(:,11)  = wave_median(:,2) - wave_median(:,1);
    wave_me(:,12) = ceil(-(wave_median(:,1)+wave_median(:,2))/2);  
%% 各导联中值波形的最大值的差值max 与 RA 的绝对差值
    for jj = 1:12
        ecg = wave_me(:,jj);
        diff_RA(jj, ii) = abs(max(ecg(idxs(3):idxs(4))) - meas_matrix(jj,5));
    end
%% 计算每个导联的波形特征点位置 [Ponset P Poffset QRSonset R QRSoffset Tonset T Toffset]
    % [waveposabs , amp] = matmgc('analyze_beat_v1', x , rr);
    % 'analyze_beat_v1' 需要的采样率是250，x 单位mv, rr 单位 ms

    % 12导联各自的STJ：J 点（QRSoffset）相对于QRSonset的振幅偏差
    % 12导联各自的STM：J点加上平均RR间期的1/16确定M点，相对于QRSonset的振幅偏差
    idx_STM = ceil((meanRR/2)/16);
    % 12导联各自的STE：J点加上平均RR间期的1/8确定E点，相对于QRSonset的振幅偏差
    idx_STE = ceil((meanRR/2)/8);
    
    for mm = 1:12
        lead_ecg = wave_me(1:2:end,mm);
        [waveposabs , amp] = matmgc('analyze_beat_v1', lead_ecg/1000 , rr);
%         figure;plot(lead_ecg);hold on;plot(waveposabs,lead_ecg(waveposabs),'*r');
%                hold on; plot(ceil(idxs/2),lead_ecg(ceil(idxs/2)),'.b');
%                hold off;
        STJ(mm) = lead_ecg(waveposabs(6)) ;%- lead_ecg(waveposabs(4));
        STM(mm) = lead_ecg(waveposabs(6) + idx_STM) ;%- lead_ecg(waveposabs(4));
        STE(mm) = lead_ecg(waveposabs(6) + idx_STE) ;%- lead_ecg(waveposabs(4));
    end
%% 用meas中的[Ponset Poffset QRSonset QRSoffset Toffset] 计算STJ\STM\STE
%     idx_STM = ceil(meanRR/16);
%     idx_STE = ceil(meanRR/8); 
%     for mm = 1:12
%         lead_ecg = wave_me(:,mm);
%         STJ(mm) = lead_ecg(idxs(4)) ;%- lead_ecg(idxs(3));
%         STM(mm) = lead_ecg(idxs(4) + idx_STM) ;%- lead_ecg(idxs(3));
%         STE(mm) = lead_ecg(idxs(4) + idx_STE) ;%- lead_ecg(idxs(3));
%     end    

%% 计算的STJ\STM\STE 与 meas_matrix 中所给值的绝对误差
    for nn = 1:12
        diff_STJ(nn,ii) = abs(STJ(nn) - meas_matrix(nn,12));
        diff_STM(nn,ii) = abs(STM(nn) - meas_matrix(nn,13));
        diff_STE(nn,ii) = abs(STE(nn) - meas_matrix(nn,14));
    end

end

%% 计算每个导联的平均绝对误差和标准差
    for nn = 1:12
%         mean_diff_STJ(nn) = mean(diff_STJ(nn,:)); std_diff_STJ(nn) = std(diff_STJ(nn,:));
%         mean_diff_STM(nn) = mean(diff_STM(nn,:)); std_diff_STM(nn) = std(diff_STM(nn,:));
%         mean_diff_STE(nn) = mean(diff_STE(nn,:)); std_diff_STE(nn) = std(diff_STE(nn,:));  
%         % STJ
%         present_J(1,nn) = (sum(diff_STJ(nn,:) <= 5)/ii)*100;
%         present_J(2,nn) = (sum(diff_STJ(nn,:) <= 10)/ii)*100;
%         present_J(3,nn) = (sum(diff_STJ(nn,:) <= 15)/ii)*100;
%         present_J(4,nn) = (sum(diff_STJ(nn,:) <= 20)/ii)*100;
%         % STM
%         present_M(1,nn) = (sum(diff_STM(nn,:) <= 5)/ii)*100;
%         present_M(2,nn) = (sum(diff_STM(nn,:) <= 10)/ii)*100;
%         present_M(3,nn) = (sum(diff_STM(nn,:) <= 15)/ii)*100;
%         present_M(4,nn) = (sum(diff_STM(nn,:) <= 20)/ii)*100;
%         % STE
%         present_E(1,nn) = (sum(diff_STE(nn,:) <= 5)/ii)*100;
%         present_E(2,nn) = (sum(diff_STE(nn,:) <= 10)/ii)*100;
%         present_E(3,nn) = (sum(diff_STE(nn,:) <= 15)/ii)*100;
%         present_E(4,nn) = (sum(diff_STE(nn,:) <= 20)/ii)*100;
        
        J(1,nn) = mean(diff_STJ(nn,:)); J(2,nn) = std(diff_STJ(nn,:));
        M(1,nn) = mean(diff_STM(nn,:)); M(2,nn) = std(diff_STM(nn,:));
        E(1,nn) = mean(diff_STE(nn,:)); E(2,nn) = std(diff_STE(nn,:));  
        % STJ
        J(3,nn) = (sum(diff_STJ(nn,:) <= 5)/ii)*100;
        J(4,nn) = (sum(diff_STJ(nn,:) <= 10)/ii)*100;
        J(5,nn) = (sum(diff_STJ(nn,:) <= 15)/ii)*100;
        J(6,nn) = (sum(diff_STJ(nn,:) <= 20)/ii)*100;
        % STM
        M(3,nn) = (sum(diff_STM(nn,:) <= 5)/ii)*100;
        M(4,nn) = (sum(diff_STM(nn,:) <= 10)/ii)*100;
        M(5,nn) = (sum(diff_STM(nn,:) <= 15)/ii)*100;
        M(6,nn) = (sum(diff_STM(nn,:) <= 20)/ii)*100;
        % STE
        E(3,nn) = (sum(diff_STE(nn,:) <= 5)/ii)*100;
        E(4,nn) = (sum(diff_STE(nn,:) <= 10)/ii)*100;
        E(5,nn) = (sum(diff_STE(nn,:) <= 15)/ii)*100;
        E(6,nn) = (sum(diff_STE(nn,:) <= 20)/ii)*100;
    end

diff_STJ = diff_STJ';
diff_STM = diff_STM';
diff_STE = diff_STE';
subplot(311)
plot(diff_STJ); title('diff\_STJ');
subplot(312)
plot(diff_STM); title('diff\_STM');
subplot(313)
plot(diff_STE); title('diff\_STE');



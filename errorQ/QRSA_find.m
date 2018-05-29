function [Qidx, QA, QD, Ridx, RA] = QRSA_find(ecg, fs, time_start, time_end, thr, draw)
%%
% Input: 
%    ecg：任一导联的median_wave
%    fs: 采样频率
%    time_start: QOnset
%    time_end：QOffset
%    thr: 阈值
%    draw: 是否画图，默认不画
% Output:
%    Qidx: Q波位点
%    QA: Q波振幅
%    QD: Q波持续时间
%    Ridx: R波位点 
%    RA: R波振幅
% 说明：R波可能有复波

%%
if nargin==5, draw=0;end
ii = time_start;
m = 1;
flag = 1;
rising = [];
falling = [];
while ii<time_end-1
    switch flag
    case 1 
        if ecg(ii)<thr && ecg(ii+1)>thr
         rising(m)= ii;
         flag = 2;
        end
        ii = ii+1;
    
    case 2
        if ecg(ii)>thr && ecg(ii+1)<thr
            falling(m)= ii;
            m = m+1;
            flag = 1;
        end
        ii = ii+1;
    end
end

%% 
Ridx = [];
RA = [];
n = 1;

if length(rising) == 0 && length(falling)==0
    disp('没有找到上升沿和下降沿，请调整阈值thr 或判断为QS型')
    [QA,Qpos]=min(ecg(time_start:time_end)); 
    Qidx = Qpos+time_start-1;
    QD = (time_end-time_start)* (1/fs)*1000;
    Ridx=nan; RA=0;
elseif length(rising) == 0 && length(falling)~=0
    disp('没有找到上升沿，请调整阈值thr')
% elseif length(rising) ~= 0 && length(falling)==0
%     disp('没有找到下降沿，请调整阈值thr 或')
else
    % 定义Q波为QRS波中Qonset与第一个上升沿点之间的最小值
    [QA,Qpos]=min(ecg(time_start:rising(1))); 
    Qidx = Qpos+time_start-1; %计算Q波在median_wave中的绝对位置 
    if Qidx == time_start
        QD=0;
        QA=0;
    else
        QD = (rising(1)-time_start) * (1/fs)*1000; % 暂定QD是QOnset到上升沿第一个点的时间差, 单位ms
%         [~,tmp_max_idx] = max(ecg(Qidx:rising(1)));
%         tmp_idx = Qidx+tmp_max_idx-1;
%         [~, tmp_min_idx] = min(ecg(Qidx:tmp_idx)-ecg(time_start));
%         Qend_idx = Qidx+tmp_min_idx(1)-1;
%         QD = (Qend_idx-time_start) * (1/fs)*1000;
    end
    if length(rising)>=1 && length(falling)>=1 %&& (falling(1)-rising(1))>2
        [RA(1),Rpos]=max(ecg(rising(1):falling(1))); % 找到第一个R波及其位置
        Ridx(1) = Rpos+rising(1)-1; %计算R波在median_wave中的绝对位置
    elseif length(rising)==1 && length(falling)<1 && max(ecg(rising(1):time_end))>25  ...
            && max(ecg(rising(1):time_end))~=ecg(time_end) && time_end-rising(1)>8
        [RA(1),Rpos1]=max(ecg(rising(1):time_end)); 
        Ridx(1) = Rpos1+rising(1)-1; 
    end
    % 找到次级R波及其位置
    if length(rising)>=2 && length(falling)>=2 
        if (isempty(RA) && isempty(Ridx))
            [RA(1),Rpos]=max(ecg(rising(2):falling(2))); 
            Ridx(1) = Rpos+rising(2)-1; 
        else
            [RA2,Rpos2]=max(ecg(rising(2):falling(2))); 
            if RA2 > 5*RA
                RA(1) = RA2;
                Ridx(1) = Rpos2+rising(2)-1;
            elseif min(ecg(falling(1):rising(2))) >15
                RA(2) = RA2;
                Ridx(2) = Rpos2+rising(2)-1; 
            end
        end
    end
                    
end
if draw == 1    
    figure 
    subplot(2,1,1)
    plot(ecg);
    hold on
    plot(time_start,ecg(time_start),'*g');
    plot(time_end,ecg(time_end),'*g');
    plot(rising,ecg(rising),'.r');%找到阈值附近的上升点
    plot(falling,ecg(falling),'.r');%找到阈值附近的下降点
    hold off;

    subplot(2,1,2)
    plot(ecg)
    hold on;
    plot(Ridx,RA,'rv','MarkerFaceColor','r')
    plot(Qidx,QA,'rs','MarkerFaceColor','y')
    hold off;
end
        
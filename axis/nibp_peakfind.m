function [idx, extremum]=nibp_peakfind(pw,time_start,thr)
%%
% Input: 
%    pw：原始数据
%    time_start: 默认1
%    thr: 阈值
% Output:
%    idx: 极值点位置
%    extremum: 极值 


%%
% pw = pw1;
% thr = 0.5;
ii = time_start;
m = 1;
flag = 1;
rising = [];
falling = [];
while ii<length(pw)-1
    switch flag
    case 1 
        if pw(ii)<thr && pw(ii+1)>thr
         rising(m)= ii;
         flag = 2;
        end
        ii = ii+1;
    
    case 2
        if pw(ii)>thr && pw(ii+1)<thr
            falling(m)= ii;
            m = m+1;
            flag = 1;
        end
        ii = ii+1;
    end
end
% plot(pw);
% hold on
% plot(rising,pw(rising),'.r');%找到阈值附近的上升点
% plot(falling,pw(falling),'.r');%找到阈值附近的下降点

%% 
idx = [];
extremum = [];
n = 1;

if length(rising) == length(falling)
    num = length(rising);
elseif length(rising)-1 == length(falling)
    num = length(falling);
end

for k = 1:num
    if (rising(k)+1) == falling(k)
        continue
    end
    [high,pos1]=max(pw(rising(k):falling(k)));%找到峰值点及其位置
    idx(n) = pos1+rising(k)-1;%计算峰值点绝对位置
    extremum(n) = high;
    n = n+1;
    if (k+1) <= length(rising)
        [low,pos2]=min(pw(falling(k):rising(k+1)));%找到谷值点及其位置
        idx(n)=pos2+falling(k)-1;%计算谷值点绝对位置
        extremum(n) = low;
        n = n+1;
    end
end
    
% plot(peak_loc1,high,'.r');
% plot(peak_loc2,low,'.r');
        
function [idx, extremum]=nibp_peakfind(pw,time_start,thr)
%%
% Input: 
%    pw��ԭʼ����
%    time_start: Ĭ��1
%    thr: ��ֵ
% Output:
%    idx: ��ֵ��λ��
%    extremum: ��ֵ 


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
% plot(rising,pw(rising),'.r');%�ҵ���ֵ������������
% plot(falling,pw(falling),'.r');%�ҵ���ֵ�������½���

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
    [high,pos1]=max(pw(rising(k):falling(k)));%�ҵ���ֵ�㼰��λ��
    idx(n) = pos1+rising(k)-1;%�����ֵ�����λ��
    extremum(n) = high;
    n = n+1;
    if (k+1) <= length(rising)
        [low,pos2]=min(pw(falling(k):rising(k+1)));%�ҵ���ֵ�㼰��λ��
        idx(n)=pos2+falling(k)-1;%�����ֵ�����λ��
        extremum(n) = low;
        n = n+1;
    end
end
    
% plot(peak_loc1,high,'.r');
% plot(peak_loc2,low,'.r');
        
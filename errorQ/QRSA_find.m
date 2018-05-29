function [Qidx, QA, QD, Ridx, RA] = QRSA_find(ecg, fs, time_start, time_end, thr, draw)
%%
% Input: 
%    ecg����һ������median_wave
%    fs: ����Ƶ��
%    time_start: QOnset
%    time_end��QOffset
%    thr: ��ֵ
%    draw: �Ƿ�ͼ��Ĭ�ϲ���
% Output:
%    Qidx: Q��λ��
%    QA: Q�����
%    QD: Q������ʱ��
%    Ridx: R��λ�� 
%    RA: R�����
% ˵����R�������и���

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
    disp('û���ҵ������غ��½��أ��������ֵthr ���ж�ΪQS��')
    [QA,Qpos]=min(ecg(time_start:time_end)); 
    Qidx = Qpos+time_start-1;
    QD = (time_end-time_start)* (1/fs)*1000;
    Ridx=nan; RA=0;
elseif length(rising) == 0 && length(falling)~=0
    disp('û���ҵ������أ��������ֵthr')
% elseif length(rising) ~= 0 && length(falling)==0
%     disp('û���ҵ��½��أ��������ֵthr ��')
else
    % ����Q��ΪQRS����Qonset���һ�������ص�֮�����Сֵ
    [QA,Qpos]=min(ecg(time_start:rising(1))); 
    Qidx = Qpos+time_start-1; %����Q����median_wave�еľ���λ�� 
    if Qidx == time_start
        QD=0;
        QA=0;
    else
        QD = (rising(1)-time_start) * (1/fs)*1000; % �ݶ�QD��QOnset�������ص�һ�����ʱ���, ��λms
%         [~,tmp_max_idx] = max(ecg(Qidx:rising(1)));
%         tmp_idx = Qidx+tmp_max_idx-1;
%         [~, tmp_min_idx] = min(ecg(Qidx:tmp_idx)-ecg(time_start));
%         Qend_idx = Qidx+tmp_min_idx(1)-1;
%         QD = (Qend_idx-time_start) * (1/fs)*1000;
    end
    if length(rising)>=1 && length(falling)>=1 %&& (falling(1)-rising(1))>2
        [RA(1),Rpos]=max(ecg(rising(1):falling(1))); % �ҵ���һ��R������λ��
        Ridx(1) = Rpos+rising(1)-1; %����R����median_wave�еľ���λ��
    elseif length(rising)==1 && length(falling)<1 && max(ecg(rising(1):time_end))>25  ...
            && max(ecg(rising(1):time_end))~=ecg(time_end) && time_end-rising(1)>8
        [RA(1),Rpos1]=max(ecg(rising(1):time_end)); 
        Ridx(1) = Rpos1+rising(1)-1; 
    end
    % �ҵ��μ�R������λ��
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
    plot(rising,ecg(rising),'.r');%�ҵ���ֵ������������
    plot(falling,ecg(falling),'.r');%�ҵ���ֵ�������½���
    hold off;

    subplot(2,1,2)
    plot(ecg)
    hold on;
    plot(Ridx,RA,'rv','MarkerFaceColor','r')
    plot(Qidx,QA,'rs','MarkerFaceColor','y')
    hold off;
end
        
% ��ȡR��������R��λ�ý��зֶ�
% ��Ҫ�������ϵ�����ж���
% output: (nchan, 600, m) ÿ����������m������
% Author: guangyubin@bjut.edu.cn
%         2017/11/14

function segdata = beat_segment(wave,rpos,QRStype,type,tleft,tright,fs)%segdata
nchan = size(wave,2);
% tleft = 0.5;
% tright = 0.7;
m = 1;
rpos0 = rpos( (QRStype==type ));
ecgII = wave(:,2);
x0 = ecgII(rpos0(3) - tleft*fs+3: rpos0(3)+tright*fs-1+3);
wave_segment = [];
lag = -5:1:5;
for ii = 1:length(rpos0)
    if  rpos0(ii)+tright*fs +10< size(wave,1) && rpos0(ii) - tleft*fs+1-5 > 1
        for kk = 1:length(lag)
            x = ecgII(rpos0(ii) - tleft*fs+3+lag(kk): rpos0(ii)+tright*fs+lag(kk)-1+3);
            RR = corrcoef(x0,x);
            R(kk) = RR(1,2);
        end;
        [a, idx] = max(R);
        idxs(m) = idx;
        rpos_new(m) = rpos0(ii);
        m = m+1;
    end;
end
for chan = 1:nchan
    for jj = 1:length(rpos_new)
        tmp = wave(rpos_new(jj) - tleft*fs+lag(idxs(jj))+3: rpos_new(jj)+tright*fs+lag(idxs(jj))-1+3,chan);
        wave_segment(:,jj) = tmp;
    end
    segdata(chan,:,:) = wave_segment;
end
end
function plot_beat_pos(ecg,rpos,fs,type,LineStyle,tleft,tright)

rpos = double(rpos);
% type = double(type);
if nargin < 4
    type = [];
    LineStyle = '+r';
    tleft = 1;
    tright = length(ecg);
end;
if nargin < 5
    LineStyle = '+r';
    tleft = 1;
    tright = length(ecg);
end;
if nargin < 6
    tleft = 1;
    tright = length(ecg);
end;
if tright > length(ecg)
    tright = length(ecg);
end;

if tleft < 1
    tleft = 1;
end;


idx = find(rpos>tleft & rpos<tright);
rpos1 = rpos(idx);

x = ecg(tleft:tright);

plot(1000*(tleft:tright)/fs,x,'b');
hold on;plot(1000*rpos1/fs,ecg(rpos1),LineStyle,'LineWidth',2);
xlabel('Time(ms)'); ylabel('mV');
if ~isempty(type)
    type1 = type(idx);
    for kk = 1:length(type1)        
        if type1(kk)~=1
            clr = 'red';
        else
            clr = 'black';
        end;
        if ischar(type1)
            text(rpos1(kk),ecg(rpos1(kk)),(type1(kk)),'Color',clr);
        else
            text(rpos1(kk),ecg(rpos1(kk)),num2str(type1(kk)),'Color',clr);
        end
    end;
end
hold off;
% title(num2str([length(rpos1) length(find(type1==5))]))
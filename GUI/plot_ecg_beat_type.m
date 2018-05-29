function plot_ecg_beat_type(ecg,rpos,type,tleft,tright)

rpos = double(rpos);
type = (type);
if nargin < 4
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
type1 = type(idx);
x = ecg(tleft:tright);

plot(tleft:tright,x);
% ylim([-4 4]);
% xlim([tleft,tright]);
hold on;plot(rpos1,ecg(rpos1),'.');
for kk = 1:length(type1)
    if type1(kk)~=1
        clr = 'red';
    else
        clr = 'black';
    end;
    if ischar(type)
          text(rpos1(kk),ecg(rpos1(kk)),(type1(kk)),'Color',clr);
    else
        text(rpos1(kk),ecg(rpos1(kk)),num2str(type1(kk)),'Color',clr);
    end
end;
hold off;
% title(num2str([length(rpos1) length(find(type1==5))]))
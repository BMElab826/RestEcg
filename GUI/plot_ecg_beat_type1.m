function plot_ecg_beat_type(ecg,rpos,type)

rpos1 = rpos(~isnan(rpos) & rpos > 0);
type1= type(~isnan(rpos)& rpos > 0);
if ~isempty(rpos1)
plot(ecg);
hold on;plot(rpos1,ecg(rpos1),'.');
for kk = 1:length(type1)
    if type1(kk)~=1
        clr = 'red';
    else
        clr = 'black';
    end;
    text(rpos1(kk),ecg(rpos1(kk)),num2str(type1(kk)),'Color',clr);
end;
hold off;
end
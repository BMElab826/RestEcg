function plot_ecg_chan1(ecg,fs,rpos,type,p0,dur, txtpos,mark , pqtpos  ,shownbeat)


rpos = double(rpos);

% type = double(type);
nsec = floor(length(ecg)/fs);
if nargin <=9
        shownbeat = 0;
end
if nargin <=6
    p0 = 0;
    dur = 10;
    txtpos = 0.95;
    mark = '*r';
    pqtpos = [];

end;
if nargin < 9
    pqtpos = [];
end;
if p0 +dur > nsec
    p0 = nsec - dur;
end;
if p0 < 0
    p0 = 0;
end;

type1 = [];
idx = find(rpos>p0*fs & rpos<(p0+dur)*fs);
rpos1 = rpos(idx);
for ii = 1 : length(idx)
    if ~ischar( type(idx(ii)))
        type1{ii} = num2str(type(idx(ii)));
    else
       type1{ii} = (type(idx(ii))); 
    end
end
x = ecg(1+p0*fs:(p0+dur)*fs);
mx = mean(x);
x = x - mx;
t = (p0+1/fs:1/fs:p0+dur);
plot(t,x,'k');
grid on
ymin = -5;
ymax = 5;
ylim([ymin ymax]);
Y = ymin:0.5:ymax;

set(gca,'ytick',Y) 

set(gca,'GridColor',[1 0 0 ],'MinorGridColor',[0.8 0 0],'GridAlpha',0.25,'MinorGridAlpha',0.6);
set(gca,'XTick',p0:0.2:p0+dur-0.2,'XTickLabel',sec2str(p0:1:p0+dur));
set(gca,'YTickLabel','');
xlim([p0,p0+dur]);

% hold on;plot(rpos1/fs,ecg(rpos1),mark);
hold on;plot(rpos1/fs,ecg(rpos1)- mx,mark);

if ~isempty(pqtpos)
    pqtpos1 = pqtpos(idx,:);
    for jj = 1: size(pqtpos1,2)
        plot(pqtpos1(:,jj)/fs,ecg(pqtpos1(:,jj)) - mx,'.r');
    end
end

if ~isempty(type1)
for kk = 1:length(type1)
    if type1{kk}~='N'
        clr = 'red';
    else
        clr = 'blue';
    end;
%     text(rpos1(kk)/fs,ecg(rpos1(kk)),num2str(type1(kk)),'Color',clr);

  if shownbeat==1
       text(rpos1(kk)/fs,ymax*txtpos,[(type1{kk}) '-' num2str(kk+idx(1)-1)],'Color',clr);
  else
      
         text(rpos1(kk)/fs,ymax*txtpos,[type1{kk}],'Color',clr);
  end
end;
end
hold off;

function y = sec2str(x)
   mm = 1;
   for ii = 1:length(x)
       h = floor(x(ii)/3600);
       m = floor((x(ii) - h*3600)/60);
       str = sprintf('%02d:%02d:%02d' , h,m ,mod(x(ii),60));
       y{mm} = str;
       y{mm+1} = '';
       y{mm+2} = '';
       y{mm+3} = '';
       y{mm+4} = '';
       mm = mm +5;
   end
   
% title(num2str([length(rpos1) length(find(type1==5))]))

function plot_restMedianWave(ecg,fs, pqrst , clr )

% if nargin < 3
%     pqtpos = [];
% end;


t = ( 1:size(ecg,1))/fs;
nchan  = size(ecg,2);
nheight = 4; 
for ii = 1 : size(ecg,2)
    x = ecg(:,ii);
    x = x - mean(x);
    plot(t,x-nheight*ii,'color',clr);hold on;
end
for ii = 1 : length(pqrst)
    plot([pqrst(ii)/fs  pqrst(ii)/fs ],[0 -nchan*nheight-nheight],'color','b','LineStyle','--');
end;
grid on; xlim([min(t) max(t)])
ylim([-nchan*nheight-nheight 0 ]);


set(gca,'ytick',-40:1:0)
set(gca,'GridColor',[1 0 0 ],'MinorGridColor',[0.8 0 0],'GridAlpha',0.25,'MinorGridAlpha',0.6);
set(gca,'XTick',0:0.2:t(end));
set(gca,'YTickLabel','');
set(gca,'XTickLabel','');
hold off;
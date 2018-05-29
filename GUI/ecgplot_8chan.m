
function ecgplot_8chan(d,fs,rpos,type,info,fout)
%
% clc
% clear
% path = 'D:\SVN\LibEcg\DamaiData\Oldpeople';
% % path = 'D:\SVN\MagitorPro\Bin\data';
% subname = 'Hanyuping20151202152631_out';
%
% fs = 400;
% N = 4;
% [d1 ] = bdfread(fullfile(path,[subname '.bdf']));
% t = 44600:44600+N*fs-1;
%
% fout = fullfile(path,[subname '.pdf']);


% x  =d1(1:3,t);

x(:,:) = d(:,:);
N = floor(size(d,2)/fs);

color1 = [255 174 200]/300;
color2 = [255 174 200]/255;


chan = size(x,1);
label = {'I','II','V1','V2','V3','V4','V5','V6'};
pos = [1 2 3 4 5 6 7 8];
% hfig = figure;

for ii=1:chan
    tmp = x(ii,:);
    tmp = tmp-mean(tmp);
    t = (0:length(tmp)-1)/fs;
    
    subplot((chan)/2,2,pos(ii));
    
    hold on;
    m = 0;
    for kk = -2: 0.1:2
        if mod(m,5)==0
            plot([min(t) max(t)],[kk kk],'Color',color1,'LineWidth',1);
        else
            plot([min(t) max(t)],[kk kk],'Color',color2,'LineWidth',0.5);
        end
        m=m+1;
        
    end;
    
    m = 0;
    for kk = min(t): 1/25: max(t)
        
        if mod(m,5)==0
            plot([kk kk],[-2 2],'Color',color1,'LineWidth',1);
        else
            plot([kk kk],[-2 2],'Color',color2,'LineWidth',0.5);
        end
        m = m+1;;
    end;
    
    
    m = 0;
    for kk = -2: 0.1:2
        if mod(m,5)==0
            plot([min(t) max(t)],[kk kk],'Color',color1,'LineWidth',1);
        end
        %         if mod(m,25) ==0
        %            plot([min(t) max(t)],[kk kk],'Color',[1 0 0],'LineWidth',2);
        %         end
        m=m+1;
        
    end;
    
    m = 0;
    for kk = min(t): 1/25: max(t)+1/25
        
        
        if mod(m,5)==0
            plot([kk kk],[-2 2],'Color',color1,'LineWidth',1);
        end
        if mod(m,25) ==0
            plot([kk kk],[-2 2],'Color',color1,'LineWidth',1);
        end
        m = m+1;;
    end;
    
    
    plot(t,tmp,'k','LineWidth',1);axis tight; title(label{ii},'position',[ -0.2 0]);
    plot(rpos/fs,tmp(rpos),'.');
    for kk = 1:length(rpos)
        text(rpos(kk)/fs,tmp(rpos(kk)),num2str(type(kk)),'Color','r');
    end
    
    axis off
    
    if ii == chan || ii == 7
        axis on
        set(gca,'XTick',[1:1:N]);
        set(gca,'XTickLabel',[1:N])
        set(gca,'YTickLabel',{''});
    end
    
    
end
%%
if nargin > 4
    a = get(gcf,'PaperSize');
    w = a(1);
    h = a(2);
    set(gcf,'PaperPosition',[0 0 h w]);
    set(gcf,'PaperOrientation','landscape');
    
    
    thtb = annotation('textbox', [0 0 1 0.08]);
    set(thtb,'String',{info,'Magitor Pro '},'EdgeColor','none','HorizontalAlignment','center','VerticalAlignment','middle');
    saveas(gcf,fout)
end
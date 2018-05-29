function [line1] = plot_heartrate(hr)

% if init == 1
t = (0:length(hr)-1);

line1= plot(t,hr,'b');hold on;
 
%  line2 = plot(pos,hr(pos),'.r'); hold off;
% else
%    hold on; line2 = plot(pos,hr(pos),'r'); hold off;
%    
% end
 
 
function y = sec2str(x)
   for ii = 1:length(x)
       h = floor(x(ii)/3600);
       m = floor((x(ii) - h*3600)/60);
       str = sprintf('%02d:%02d:%02d' , h,m ,mod(x(ii),60));
       y{ii} = str;
   end
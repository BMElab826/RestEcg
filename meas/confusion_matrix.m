% Descript: confusion_matrix
% Input:
%    group: true class label
%    class : test class label 
% Output:
%    m : confusion_matrix
%    F: F value, while is used for AF2017
%    acc: accuracy
% History:
%    Version 1.0.0    2017.3.14   guangyubin
% Author:
%     GuangyuBin@bjut.edu.cn. 
%     Beijing university of techonolgy

function [m,mF,acc,F] = confusion_matrix(group,class,fig)

if nargin < 3
    fig = 0 ;
end;
x = unique(group);

for ii = 1 : length(x)    
    for jj = 1:length(x)        
        m(ii,jj) = length(find(group==x(ii) & class==x(jj)));
    end
end

for ii = 1 : length(x)
    F(ii) = 2*m(ii,ii) / ((sum(m(ii,:))+sum(m(:,ii))));
end;
acc = (sum(diag(m)) /sum(sum(m)));
mF = (mean(F));
%%
if fig==1
 s = num2str(x','%7d');

    
    disp(['        ' s]);
        disp('---------------------------------------');
for ii = 1: length(x)
    s = num2str(m(ii,:),'%7d');
  str_e = sprintf('%7d|%s |%.4f',x(ii) ,s  ,F(ii));
    disp(str_e)
end;

   disp('---------------------------------------');
disp(['F =' num2str(mF) '   Acc = '  num2str(acc)]);
end


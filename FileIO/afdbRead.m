% Descript:
%      读取AFDB中的数据，并按照ann中的标记，对每一个rpos进行label
%       在Ann中，采用(AFIB 标记房颤的起始位置
% Author:
%       guangyubin@bjut.edu.cn，2017/10/9
%
function [af_label,ann,sig] = afdbRead(path,fname,rpos,bReadSig)
%%
% path = 'D:\Database_MIT\afdb\';
% fname ='04043';
if nargin <4
    bReadSig = 0 ;
end;
sig = [];
if bReadSig==1
    hd=readheader([path fname '.hea']);
    try
        sig=rdsign212([path fname '.dat'],2,1,hd.nsamp);
        sig = sig(:,2)/200;
    catch
    end;
end
ann = readannot([path fname '.atr']);

af_label = zeros(1,length(rpos));

for ii = 1:length(ann.time)-1
    if ~isempty(strfind(ann.aux(ii,:),'(AFIB'))  && isempty(strfind(ann.aux(ii+1,:),'(AFIB'))
        af_label(rpos >= ann.time(ii) & rpos <=ann.time(ii+1)) = 1;
    end
end;
if ~isempty(strfind(ann.aux(end,:),'(AFIB'))
    af_label(rpos >=ann.time(end)) = 1;
end

%%

%  figure;plot(sig);hold on;plot(AFIndex);
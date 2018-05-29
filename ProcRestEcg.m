function [dataout, qrs, meanwave, pqrst] = ProcRestEcg(data,fs)
%%
% load('D:\MGCDB\muse\musedb_500Hz');
% data = DATA(1).wave;
if fs == 500
    data = data(1:2:end,:);
end

II = data(:,2);
V2 = data(:,4);
V3 = data(:,5);

qrs = matmgc('beat_detector_classify',(II+V2)/2,250);
QRSType = qrs.qrs(1,:);
rpos = qrs.time;
maxtype = FindMaxType(QRSType);
segdata = beat_segment(data,rpos,QRSType,maxtype,0.4,0.6,250);
meanwave = mean(segdata,3)';
rr = mean(diff(rpos))*1000/250;
[pqrst , amp] = matmgc('analyze_beat_v1',meanwave(:,2),rr);

dataout = data;
% qrs = matmgc('beat_detector',II,250);
% rpos = double(qrs.time);
% QRSType = (qrs.anntyp);
% 
% [maxType,numOfmaxType] = FindMaxType(QRSType);
% segdata = beat_segment(data,rpos,QRSType,maxType,0.4,0.6,250);
% meanwave = mean(segdata,3)';
% rr = mean(diff(rpos))*1000/250;
% [pqrst , amp] = matmgc('analyze_beat_v1',meanwave(:,2)*200,rr);   
% 
% qrs2 = matmgc('beat_detector_classify',II,250);
% clear matmgc
% qrs2 = beatlist.time;
 
% subplot(122);plot_restMedianWave(meanwave,fs,pqrst , 'r' );
% subplot(121);plot_restEcg(data,fs,rpos,QRSType, -1  )
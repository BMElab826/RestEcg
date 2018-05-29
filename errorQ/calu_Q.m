%%
% date: 2018.05.22
% author: huangjiao 
% 功能：从median_wave中读出QRS波中Q波的幅度QA、Q波的时间QD、R波的幅度RA
%       input: median_wave12, Meas_Orig, fs
%       output:12导联的QA、QD、RA
%% 
function [QA, QD, RA] = predict_Q(median_wave12, Meas_Orig, fs)
QA=[];
QD=[];
RA=[];

Qonset = ceil(Meas_Orig.QOnset/(500/fs));
Qoffset = ceil(Meas_Orig.QOffset/(500/fs));
% QRS12 = median_wave12(Qonset:Qoffset,:);
[~,len_leads] = size(median_wave12);
% figure
for ii = 1:len_leads
    ecg = median_wave12(:,ii);
%     subplot(2,6,ii);plot(ecg)
    [~, QA_lead, QD_lead, ~, RA_lead] = QRSA_find(ecg, fs, Qonset, Qoffset, 6.5, 0);
    if isempty(QA_lead); QA_lead=0;end
    if QA_lead == 0; QD_lead=0;end
    if isempty(RA_lead); RA_lead=0;end
    QA(ii,:) = abs(QA_lead);
    QD(ii,:) = QD_lead;
    RA(ii,:) = max(RA_lead);    % R波有次级波时，暂时取最大值作为主峰
end


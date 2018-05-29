%%
% date: 2018.05.25
% author: huangjiao 
% ���ܣ�ͳ�Ƽ���ĸ�������QA, QD, RA �� meas_meatrix�е�tQA, tQD, tRA�����
%     Input:
%     Output: 
%           error_matrix: 

function error_matrix = Qwave_argu_statistics(tQwave, pQwave)
d_Qwave = abs(pQwave-tQwave);
[~, ~, len] = size(d_Qwave);
for ii = 1:12
    d_QA = squeeze(d_Qwave(ii,1,:));
    precent_5_dQA(ii) = (sum(d_QA <= 5)/length(d_QA))*100;
    precent_10_dQA(ii) = (sum(d_QA <= 10)/length(d_QA))*100;
    precent_15_dQA(ii) = (sum(d_QA <= 15)/length(d_QA))*100;
    d_QD = squeeze(d_Qwave(ii,2,:));
    precent_5_dQD(ii) = (sum(d_QD <= 5)/length(d_QD))*100;
    precent_10_dQD(ii) = (sum(d_QD <= 10)/length(d_QD))*100;
    precent_15_dQD(ii) = (sum(d_QD <= 15)/length(d_QD))*100;
    d_RA = squeeze(d_Qwave(ii,3,:));
    precent_5_dRA(ii) = (sum(d_RA <= 5)/length(d_RA))*100;
    precent_10_dRA(ii) = (sum(d_RA <= 10)/length(d_RA))*100;
    precent_15_dRA(ii) = (sum(d_RA <= 15)/length(d_RA))*100;    
end
error_matrix = [precent_5_dQA; precent_10_dQA; precent_15_dQA; precent_5_dQD; precent_10_dQD; precent_15_dQD; ...
    precent_5_dRA; precent_10_dRA; precent_15_dRA];


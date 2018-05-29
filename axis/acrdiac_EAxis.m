function [EAxisDegree] = acrdiac_EAxis(ecgI, ecgII, WaveOnset, WaveOffset)
% ��������������,֪��PQRST����ֹλ��
% Input: 
%      ecgI: the data of I lead
%      ecgII�� the data of II lead
%      WaveOnset: 
%      WaveOffset:

% Output:
%      EAxisDegree: the degree of acrdiac electric axis

%% ��������Ӧ����P��qrs��Ⱥ��T�������򲨣���ֵ���͸��򲨣���ֵ���Ĵ�����
    maxI = max(ecgI(WaveOnset:WaveOffset));
    minI = min(ecgI(WaveOnset:WaveOffset));
    if minI > 0
        minI = 0;
    end
       
    maxII = max(ecgII(WaveOnset:WaveOffset));
    minII = min(ecgII(WaveOnset:WaveOffset));
    if minII > 0
        minI = 0;
    end

    val_I = maxI +minI;
    val_II = maxII +minII;   

%% Einthoven �������ۼ����ĵ���Ƕ�
EAxisDegree = EinthovenTriangle(val_I, val_II);
EAxisDegree = floor(EAxisDegree);
 
end
function [EAxisDegree, EAxisDiag] = Area_EAxis(ecgI, ecgII, WaveOnset, WaveOffset, WaveName)
% ��������������, ֪��PQRST����ֹλ��
% Input: 
%      ecgI: the data of I lead
%      ecgII�� the data of II lead
%      WaveOnset: ��Ӧ���ε���ֹ��
%      WaveOffset:
%      WaveName: 'P' / 'QRS' / 'T' һ��Ϊ'QRS'������QRS�жϵ�������ƫ

% Output:
%      EAxisDegree: the degree of acrdiac electric axis
%      EAxisDiag: the diagnosis of QRS electric axis

%% ��������Ӧ���Σ�P��qrs��Ⱥ��T�������
area_I = sum(ecgI(WaveOnset:WaveOffset));
area_II = sum(ecgII(WaveOnset:WaveOffset));

%% �����������
% area_I = max(ecgI(WaveOnset:WaveOffset))* (WaveOffset - WaveOnset)/2;
% area_II = max(ecgII(WaveOnset:WaveOffset))* (WaveOffset - WaveOnset)/2;

%% ����Einthoven �������ۼ����ĵ���Ƕȣ�PAxis, RAxis, TAxis
EAxisDegree = EinthovenTriangle(area_I, area_II);

%% �ж��ĵ������쳣
if strcmp('QRS',WaveName)
    if (-30 <= EAxisDegree) && (EAxisDegree <= 90)
        EAxisDiag = '��������';
    elseif (90 < EAxisDegree ) && (EAxisDegree <= 180)
        EAxisDiag = '������ƫ';
    elseif ((180 < EAxisDegree ) && (EAxisDegree < 270)) || ((-180 < EAxisDegree ) && (EAxisDegree < -90))
        EAxisDiag = '������ƫ';
    elseif ((-90 <= EAxisDegree ) && (EAxisDegree <-30))
        EAxisDiag = '������ƫ';
    else
        EAxisDiag = '���᲻ȷ��';
    end
else
%     disp('����QRS��Ⱥ�жϵ���')
    EAxisDiag = ' ';
end
 
end
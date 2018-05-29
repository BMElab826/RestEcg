function [EAxisDegree, EAxisDiag] = Area_EAxis(ecgI, ecgII, WaveOnset, WaveOffset, WaveName)
% 根据面积法测电轴, 知道PQRST的起止位置
% Input: 
%      ecgI: the data of I lead
%      ecgII： the data of II lead
%      WaveOnset: 相应波段的起止点
%      WaveOffset:
%      WaveName: 'P' / 'QRS' / 'T' 一般为'QRS'，根据QRS判断电轴左右偏

% Output:
%      EAxisDegree: the degree of acrdiac electric axis
%      EAxisDiag: the diagnosis of QRS electric axis

%% 各导联相应波段（P、qrs波群、T）的面积
area_I = sum(ecgI(WaveOnset:WaveOffset));
area_II = sum(ecgII(WaveOnset:WaveOffset));

%% 三角形求面积
% area_I = max(ecgI(WaveOnset:WaveOffset))* (WaveOffset - WaveOnset)/2;
% area_II = max(ecgII(WaveOnset:WaveOffset))* (WaveOffset - WaveOnset)/2;

%% 根据Einthoven 三角理论计算心电轴角度：PAxis, RAxis, TAxis
EAxisDegree = EinthovenTriangle(area_I, area_II);

%% 判断心电轴正异常
if strcmp('QRS',WaveName)
    if (-30 <= EAxisDegree) && (EAxisDegree <= 90)
        EAxisDiag = '电轴正常';
    elseif (90 < EAxisDegree ) && (EAxisDegree <= 180)
        EAxisDiag = '电轴右偏';
    elseif ((180 < EAxisDegree ) && (EAxisDegree < 270)) || ((-180 < EAxisDegree ) && (EAxisDegree < -90))
        EAxisDiag = '极度右偏';
    elseif ((-90 <= EAxisDegree ) && (EAxisDegree <-30))
        EAxisDiag = '电轴左偏';
    else
        EAxisDiag = '电轴不确定';
    end
else
%     disp('请用QRS波群判断电轴')
    EAxisDiag = ' ';
end
 
end
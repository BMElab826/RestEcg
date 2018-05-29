function [EAxisDegree] = acrdiac_EAxis(ecgI, ecgII, WaveOnset, WaveOffset)
% 根据振幅法测电轴,知道PQRST的起止位置
% Input: 
%      ecgI: the data of I lead
%      ecgII： the data of II lead
%      WaveOnset: 
%      WaveOffset:

% Output:
%      EAxisDegree: the degree of acrdiac electric axis

%% 各导联相应波（P、qrs波群、T）的正向波（正值）和负向波（负值）的代数和
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

%% Einthoven 三角理论计算心电轴角度
EAxisDegree = EinthovenTriangle(val_I, val_II);
EAxisDegree = floor(EAxisDegree);
 
end
function [EAxisDegree, EAxisDiag] = extremum_EAxis(ecgI, ecgII, WaveOnset, WaveOffset, WaveName)
% 根据振幅法测电轴,用 median wave 中的 PQRST 定位信息确定各波段振幅极值代数和
% Input: 
%      ecgI: the data of I lead
%      ecgII： the data of II lead
%      WaveOnset: 
%      WaveOffset:
%      WaveName: 'P' / 'QRS' / 'T' 一般为'QRS'，根据QRS判断电轴左右偏

% Output:
%      EAxisDegree: the degree of acrdiac electric axis
%      EAxisDiag: the diagnosis of QRS electric axis

% Update:
%      WaveName 为 'P' / 'T' 时，之计算其中的最大值

%% 各导联相应波（P、qrs波群、T）的极值代数和
if strcmp('QRS',WaveName)
    val_I = 0; val_II = 0;
    [idxI, extremumI] = nibp_peakfind(ecgI, 1, 5.1);
    for kk = 1:length(idxI)
        if (idxI(kk) > WaveOnset) && (idxI(kk) < WaveOffset)
            val_I = val_I+extremumI(kk);
        end
    end
    
    [idxII, extremumII] = nibp_peakfind(ecgII, 1, 5.1);
    for ii = 1:length(idxII)
        if (idxII(ii) > WaveOnset) && (idxII(ii) < WaveOffset)
            val_II = val_II+extremumII(ii);
        end
    end

    
elseif strcmp('P',WaveName) || strcmp('T',WaveName)
    val_I = 0; val_II = 0;
    [idxI, extremumI] = nibp_peakfind(ecgI, 1, 7.1);
    for kk = 1:length(idxI)
        if (idxI(kk) > WaveOnset) && (idxI(kk) < WaveOffset)
            val_I = val_I+extremumI(kk);
        end
    end
    
    [idxII, extremumII] = nibp_peakfind(ecgII, 1, 7.1);
    for ii = 1:length(idxII)
        if (idxII(ii) > WaveOnset) && (idxII(ii) < WaveOffset)
            val_II = val_II+extremumII(ii);
        end
    end
end
    
    

%% Einthoven 三角理论计算心电轴角度
EAxisDegree = EinthovenTriangle(val_I, val_II);

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
    disp('请用QRS波群判断电轴')
    EAxisDiag = '';
end
 
end
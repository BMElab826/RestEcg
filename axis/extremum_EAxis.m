function [EAxisDegree, EAxisDiag] = extremum_EAxis(ecgI, ecgII, WaveOnset, WaveOffset, WaveName)
% ��������������,�� median wave �е� PQRST ��λ��Ϣȷ�������������ֵ������
% Input: 
%      ecgI: the data of I lead
%      ecgII�� the data of II lead
%      WaveOnset: 
%      WaveOffset:
%      WaveName: 'P' / 'QRS' / 'T' һ��Ϊ'QRS'������QRS�жϵ�������ƫ

% Output:
%      EAxisDegree: the degree of acrdiac electric axis
%      EAxisDiag: the diagnosis of QRS electric axis

% Update:
%      WaveName Ϊ 'P' / 'T' ʱ��֮�������е����ֵ

%% ��������Ӧ����P��qrs��Ⱥ��T���ļ�ֵ������
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
    
    

%% Einthoven �������ۼ����ĵ���Ƕ�
EAxisDegree = EinthovenTriangle(val_I, val_II);

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
    disp('����QRS��Ⱥ�жϵ���')
    EAxisDiag = '';
end
 
end
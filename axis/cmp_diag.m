function EAxisDiag = cmp_diag(RAxis)
%% �ж��ĵ������쳣
% input: 
%      RAxis: QRS ƽ���ĵ���
% output��
%      EAxisDiag: �жϵĵ������ 

% if strcmp('QRS',WaveName)
    if (-30 < RAxis) && (RAxis < 90)
        EAxisDiag = '��������';
    elseif (90 <= RAxis ) && (RAxis <= 180)
        EAxisDiag = '������ƫ';
    elseif ((180 < RAxis ) && (RAxis < 270)) || ((-180 < RAxis ) && (RAxis < -90))
        EAxisDiag = '���᲻ȷ��';%'������ƫ';
    elseif ((-90 <= RAxis ) && (RAxis <= -30))
        EAxisDiag = '������ƫ';
    else
        EAxisDiag = '�ĵ������쳣';%'���᲻ȷ��';
    end
% else
% %     disp('����QRS��Ⱥ�жϵ���')
%     EAxisDiag = '';
end
 
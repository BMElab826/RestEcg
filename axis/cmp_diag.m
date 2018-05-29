function EAxisDiag = cmp_diag(RAxis)
%% 判断心电轴正异常
% input: 
%      RAxis: QRS 平均心电轴
% output：
%      EAxisDiag: 判断的电轴情况 

% if strcmp('QRS',WaveName)
    if (-30 < RAxis) && (RAxis < 90)
        EAxisDiag = '电轴正常';
    elseif (90 <= RAxis ) && (RAxis <= 180)
        EAxisDiag = '电轴右偏';
    elseif ((180 < RAxis ) && (RAxis < 270)) || ((-180 < RAxis ) && (RAxis < -90))
        EAxisDiag = '电轴不确定';%'极度右偏';
    elseif ((-90 <= RAxis ) && (RAxis <= -30))
        EAxisDiag = '电轴左偏';
    else
        EAxisDiag = '心电数据异常';%'电轴不确定';
    end
% else
% %     disp('请用QRS波群判断电轴')
%     EAxisDiag = '';
end
 
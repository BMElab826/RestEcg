function Axis_angle = EinthovenTriangle(sum_I, sum_II)
% Einthoven 三角理论计算心电轴角度
% Input: 
%      amp_I:  导联 I 的 P / QRS / T 波群正负波振幅代数和
%      amp_II: 导联 III 的 P / QRS / T 波群正负波振幅代数和

% Output:
%      Axis_angle: 相应波的心电轴偏离角度

x = abs((2/sqrt(3))*(sum_II/sum_I - 0.5));
angle = (atan(x)/pi)*180;
if isnan(angle)
    disp(angle)
    disp(sum_I)
    disp(sum_II)
end
if sum_I > 0 && sum_II > 0
    Axis_angle = angle;
elseif sum_I > 0 && sum_II < 0
    Axis_angle = -angle;
elseif sum_I < 0 && sum_II > 0
    Axis_angle = 180 - angle;
elseif sum_I < 0 && sum_II < 0
    Axis_angle = 180 + angle;
elseif sum_I < 0 && sum_II == 0
    Axis_angle = 150;
elseif sum_I > 0 && sum_II == 0
    Axis_angle = -30;
elseif sum_I == 0 && sum_II < 0
    Axis_angle = -90;
elseif sum_I == 0 && sum_II > 0
    Axis_angle = 90;  
else Axis_angle = 30;
    
end
%%
% function Axis_angle = EinthovenTriangle(sum_I, sum_III)
% % Einthoven 三角理论计算心电轴角度
% % Input: 
% %      amp_I:  导联 I 的 P / QRS / T 波群正负波振幅代数和
% %      amp_III: 导联 III 的 P / QRS / T 波群正负波振幅代数和
% 
% % Output:
% %      Axis_angle: 相应波的心电轴偏离角度
% 
% x = abs((2/sqrt(3))*(sum_III/sum_I + 0.5));
% angle = (atan(x)/pi)*180;
% if isnan(angle)
%     disp(angle)
%     disp(sum_I)
%     disp(sum_III)
% end
% if sum_I > 0 && sum_III >= 0
%     Axis_angle = angle;
% elseif sum_I >= 0 && sum_III < 0
%     Axis_angle = -angle;
% elseif sum_I <= 0 && sum_III > 0
%     Axis_angle = 180 - angle;
% elseif sum_I < 0 && sum_III <= 0
%     Axis_angle = 180 + angle;
% else Axis_angle = 30;
% 
% end


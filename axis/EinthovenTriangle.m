function Axis_angle = EinthovenTriangle(sum_I, sum_II)
% Einthoven �������ۼ����ĵ���Ƕ�
% Input: 
%      amp_I:  ���� I �� P / QRS / T ��Ⱥ���������������
%      amp_II: ���� III �� P / QRS / T ��Ⱥ���������������

% Output:
%      Axis_angle: ��Ӧ�����ĵ���ƫ��Ƕ�

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
% % Einthoven �������ۼ����ĵ���Ƕ�
% % Input: 
% %      amp_I:  ���� I �� P / QRS / T ��Ⱥ���������������
% %      amp_III: ���� III �� P / QRS / T ��Ⱥ���������������
% 
% % Output:
% %      Axis_angle: ��Ӧ�����ĵ���ƫ��Ƕ�
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


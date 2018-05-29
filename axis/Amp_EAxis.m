function [PAxis, RAxis, TAxis] = Amp_EAxis(Meas_Matrix )
% ��������������,��muse��Meas_Matrix�и�������ļ���
% Input: 
%      Meas_Matrix: ��������

% Output:
%      PAxis: 
%      RAxis: 
%      TAxis: 

%% ���� I median wave ��صĸ������򲨺͸��򲨵����������
I_PA = Meas_Matrix(7,1);
I_PPA = Meas_Matrix(7,2);
sumI_P = I_PA + I_PPA;

I_QA = Meas_Matrix(7,3);
I_RA = Meas_Matrix(7,5);
I_SA = Meas_Matrix(7,7);
I_RPA = Meas_Matrix(7,9);
I_SPA = Meas_Matrix(7,11);
sumI_QRS = I_QA + I_RA + I_SA + I_RPA + I_SPA;

I_TA = Meas_Matrix(7,15);
I_TPA = Meas_Matrix(7,16);
sumI_T = I_TA + I_TPA ;
%% ���� II median wave ��صĸ������򲨺͸��򲨵����
II_PA = Meas_Matrix(9,1);
II_PPA = Meas_Matrix(9,2);
sumII_P = II_PA + II_PPA;

II_QA = Meas_Matrix(9,3);
II_RA = Meas_Matrix(9,5);
II_SA = Meas_Matrix(9,7);
II_RPA = Meas_Matrix(9,9);
II_SPA = Meas_Matrix(9,11);
sumII_QRS = II_QA + II_RA + II_SA + II_RPA + II_SPA;

II_TA = Meas_Matrix(9,15);
II_TPA = Meas_Matrix(9,16);
sumII_T = II_TA + II_TPA ;

%% ���� III median wave ��صĸ������򲨺͸��򲨵����
% III_PA = Meas_Matrix(11,1);
% III_PPA = Meas_Matrix(11,2);
% sumIII_P = III_PA + III_PPA;
% 
% III_QA = Meas_Matrix(11,3);
% III_RA = Meas_Matrix(11,5);
% III_SA = Meas_Matrix(11,7);
% III_RPA = Meas_Matrix(11,11);
% III_SPA = Meas_Matrix(11,11);
% sumIII_QRS = III_QA + III_RA + III_SA + III_RPA + III_SPA;
% 
% III_TA = Meas_Matrix(11,15);
% III_TPA = Meas_Matrix(11,16);
% sumIII_T = III_TA + III_TPA ;

%% ����Einthoven �������ۼ����ĵ���Ƕȣ�PAxis, RAxis, TAxis
PAxis = EinthovenTriangle(sumI_P, sumII_P);
RAxis = EinthovenTriangle(sumI_QRS, sumII_QRS);
TAxis = EinthovenTriangle(sumI_T, sumII_T);

end 

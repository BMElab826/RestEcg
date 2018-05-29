function  [RAxis] = Area_Meas_Matrix(Meas_Matrix)
%%
QA_I = Meas_Matrix(7,3);
QD_I = Meas_Matrix(7,4);
Qarea_I = QA_I * QD_I / 2;

RA_I = Meas_Matrix(7,5);
RD_I = Meas_Matrix(7,6);
Rarea_I = RA_I * RD_I / 2;

SA_I = Meas_Matrix(7,7);
SD_I = Meas_Matrix(7,8);
Sarea_I = SA_I * SD_I / 2;

sumI_QRS = Qarea_I + Rarea_I +Sarea_I ;
%% 
QA_III = Meas_Matrix(11,3);
QD_III = Meas_Matrix(11,4);
Qarea_III = QA_III * QD_III / 2;

RA_III = Meas_Matrix(11,5);
RD_III = Meas_Matrix(11,6);
Rarea_III = RA_III * RD_III / 2;

SA_III = Meas_Matrix(11,7);
SD_III = Meas_Matrix(11,8);
Sarea_III = SA_III * SD_III / 2;

sumIII_QRS = Qarea_III + Rarea_III +Sarea_III ;
%%
RAxis = EinthovenTriangle(sumI_QRS, sumIII_QRS);



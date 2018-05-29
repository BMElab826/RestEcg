function [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientID]...
    = musexmlread(fname)
% 1307 1452 1869



% fname = fullfile('D:\DataBase\MUSE',list(1869).name);

% fid = fopen(fname,'r','native','ISO-8859-1');

fid = fopen(fname,'r','native','UTF-8');
str = fscanf(fid,'%s');
fclose(fid);
idx0 = strfind(str,'<');
idx1 = strfind(str,'>');
if length(idx1) == length(idx0)+1
    tmp = idx1(1:length(idx0)) - idx0;
    a = 1:length(idx0);
    x = find((tmp<0));
    idx1(x(1)) = [];
end;

if length(idx0)~= length(idx1)
    fid = fopen(fname,'r','native');
    str = fscanf(fid,'%s');
    idx0 = strfind(str,'<');
    idx1 = strfind(str,'>');
    fclose(fid);
end
[PatientID,iend]= museGetPatientID(str,idx0,idx1,1);
[Meas,iend]= museGetRestingECGMeasurements(str,idx0,idx1,iend);
[Meas_Orig,iend]= museGetOriginalRestingECGMeas(str,idx0,idx1,iend);
[diag,iend] = museGetDiagnosis(str,idx0,idx1,iend);
[diag_orig,iend] = museGetOriginalDiagnosis(str,idx0,idx1,iend);
[Meas_Matrix,iend]= museGetMeasurementMatrix(str,idx0,idx1,iend);
[rpos,QRStype,iend] = museGetQRSTimesTypes(str,idx0,idx1,iend);
[wave_median,adu,label1,sr1,iend]= museGetMedianWaveform(str,idx0,idx1,iend);
[wave,adu2,label2,sr2,iend]= museGetRhythmWaveform(str,idx0,idx1,iend);

wave = double(wave);
sr = sr2;
wave_median = double(wave_median);
adu = adu(1);
label = label1;





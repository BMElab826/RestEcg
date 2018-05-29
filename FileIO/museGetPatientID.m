
function [PatientInfo,ii]= museGetPatientID(str,idx0,idx1,istart)

ss = 0;
m = 1;
kk = 1;
diag = {};
PatientInfo.PatientID=[];
PatientInfo.PatientLastName=[];
PatientInfo.PatientAge=[];
PatientInfo.Gender=[];
PatientInfo.HeightCM=[];
PatientInfo.WeightKG=[];
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    switch ss
        case 0
            if strcmp('PatientDemographics',x) 
                ss = 1;
            end
        case 1
            if strcmp('/PatientDemographics',x)
                break;
            end
            if strcmp('PatientID',x)
                PatientInfo.PatientID = (str(idx1(ii)+1:idx0(ii+1)-1));
            end
            if strcmp('PatientLastName',x)
                PatientInfo.PatientLastName = (str(idx1(ii)+1:idx0(ii+1)-1));
            end
            if strcmp('PatientAge',x)
                PatientInfo.PatientAge = (str(idx1(ii)+1:idx0(ii+1)-1));
            end
            if strcmp('Gender',x)
                PatientInfo.Gender = (str(idx1(ii)+1:idx0(ii+1)-1));
            end
            if strcmp('HeightCM',x)
                PatientInfo.HeightCM = (str(idx1(ii)+1:idx0(ii+1)-1));
            end
            if strcmp('WeightKG',x)
                PatientInfo.WeightKG = (str(idx1(ii)+1:idx0(ii+1)-1));
            end            
            
    end    
end
if ss ==0 
    ii = istart;
end;

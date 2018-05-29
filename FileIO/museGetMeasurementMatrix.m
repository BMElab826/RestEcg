function [stanard_MeasMatrix,ii]= museGetMeasurementMatrix(str,idx0,idx1,istart)

ss = 0;
kk = 1;
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    
    if strcmp('MeasurementMatrix',x)
        x1 = (str(idx1(ii)+1:idx0(ii+1)-1));
        input = uint8(x1);
        Meas_Matrix = typecast(org.apache.commons.codec.binary.Base64.decodeBase64(input), 'uint8')';
        stanard_MeasMatrix = decodeMuseMeasMatrix(Meas_Matrix);
        break;
    end;
end


function [rpos,QRStype,ii] = museGetQRSTimesTypes(str,idx0,idx1,istart)
m = 1;
n = 1;
ss = 0;
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    switch ss
        case 0
            if strcmp('QRSTimesTypes',x)
                ss = 1;
            end;
        case 1
            if strcmp('/QRSTimesTypes',x)         
                break;
            end;
            if strcmp('QRS',x)
                ss = 2;
            end;
        case 2
            if strcmp('Type',x)
                x1 = str(idx1(ii)+1:idx0(ii+1)-1);
                QRStype(m) = str2double(x1);
                ss = 3;
            end;
        case 3
            if strcmp('Time',x)
                x1 = str(idx1(ii)+1:idx0(ii+1)-1);
                rpos(m) = str2double(x1);
                m = m +1;
                ss = 1;
            end;
            
    end;
end
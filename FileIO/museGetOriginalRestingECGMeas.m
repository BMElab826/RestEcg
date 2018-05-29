
function [Meas,ii]= museGetOriginalRestingECGMeas(str,idx0,idx1,istart)
m = 1;
n = 1;
ss = 0;
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    if ss==0
        if strcmp('OriginalRestingECGMeasurements',x)
            ss = 1;
        end
    else
        if strcmp('/OriginalRestingECGMeasurements',x)
            break;
        else if x(1)~='/'
                x1 = str2double(str(idx1(ii)+1:idx0(ii+1)-1));
                eval(['Meas.' x '= x1;'] );
                m = m+2;
            end
        end
    end
    
end


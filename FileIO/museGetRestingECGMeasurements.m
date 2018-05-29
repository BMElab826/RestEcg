
function [Mes ,ii]= museGetRestingECGMeasurements(str,idx0,idx1,istart)
m = 1;
n = 1;
ss = 0;
% Mes.VentricularRate = [];
% Mes.AtrialRate = [];
% Mes.PRInterval = [];
% Mes.QRSDuration = [];
% Mes.QTInterval = [];
% Mes.QTCorrected = [];
% Mes.PAxis = [];
% Mes.RAxis = [];
% Mes.TAxis = [];
% Mes.QRSCount = [];
% Mes.QOnset = [];
% Mes.QOffset = [];
% Mes.POnset = [];
% Mes.POffset = [];
% Mes.TOffset = [];
% Mes.ECGSampleBase = [];
% Mes.ECGSampleExponent = [];
% Mes.QTcFrederica = [];
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    if ss==0
        if strcmp('RestingECGMeasurements',x)
            ss = 1;
        end
    else
        if strcmp('/RestingECGMeasurements',x)
            break;
        else if x(1)~='/'
                x1 = str2double(str(idx1(ii)+1:idx0(ii+1)-1));
                eval(['Mes.' x '= x1;'] );
                m = m+2;
            end
        end
    end
    
end



function [diag,ii]= museGetOriginalDiagnosis(str,idx0,idx1,istart)

ss = 0;
kk = 1;
diag = {};
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    switch ss
        case 0
            if strcmp('OriginalDiagnosis',x) 
                ss = 1;
            end
        case 1
            if strcmp('/OriginalDiagnosis',x)
                break;
            end
            if strcmp('DiagnosisStatement',x)
                ss = 2;
            end
        case 2
            if strcmp('StmtText',x)
                diag{kk} = (str(idx1(ii)+1:idx0(ii+1)-1));
                kk = kk +1;   
                ss =1;
            end
    end    
end
if ss == 0 
    ii = istart;
end;


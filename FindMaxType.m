function [maxType,numOfmaxType] = FindMaxType(QRStype)
% QRStype = qrs.anntyp;
c = unique(QRStype);
for ii = 1:length(c)
    mm(ii) = length(QRStype(QRStype==c(ii)));
end;

[val index ] = max(mm);
maxType = c(index);
numOfmaxType = val;
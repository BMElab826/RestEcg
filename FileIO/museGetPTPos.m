function pos = museGetPTPos(Meas)

pos(3) = Meas.QOnset;
pos(4) = Meas.QOffset;
pos(5) = Meas.TOffset;
% QTInterval = Meas.QTInterval;
% PRInterval = Meas.PRInterval;

if isfield(Meas,'POnset')
    pos(1) = Meas.POnset;
else 
    pos(1) = nan;

end

if isfield(Meas,'POffset')
    pos(2) = Meas.POffset;
else
    pos(2) = nan;
end
   
  
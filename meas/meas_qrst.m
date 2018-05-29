% 测量PQRST QT间期等的准确性
function res= meas_qrst(tPos1,tPos2)
res = zeros(8,7);
res(1,:) = meas_qt(tPos1(:,5)-tPos1(:,3),tPos2(:,5)-tPos2(:,3));
res(2,:) = meas_qt(tPos1(:,4)-tPos1(:,3),tPos2(:,4)-tPos2(:,3));
res(3,:) = meas_qt(tPos1(:,3)-tPos1(:,1),tPos2(:,3)-tPos2(:,1));
for ii = 1:size(tPos1,2)
    
    res(3+ii,:) = meas_qt(tPos1(:,ii),tPos2(:,ii));
end



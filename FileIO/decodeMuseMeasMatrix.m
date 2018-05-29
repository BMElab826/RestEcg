function  stanard_MeasMatrix = decodeMuseMeasMatrix(Meas_Matrix)
stanard_MeasMatrix= [];
chanlist = [3, 4,5,6,7,8,1,11,2,12,9,10];
y = Meas_Matrix(37:end);
y = reshape(y,[212 12]);
pos = [7, 23,39,43,55,59,71,75,87,91,103,119,123,127,159,175];
for ii = 1:length(pos)
    for jj = 1:12
        stanard_MeasMatrix(jj,ii) = typecast(y([pos(ii) pos(ii)+1],chanlist(jj)),'int16');
    end
end;
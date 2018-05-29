% 测量QT间隔准确性的度量标准
function res= meas_qt(qt0,qt1)
index = find(~isnan(qt0) & ~isnan(qt1));
qt0 = qt0(index);
qt1 = qt1(index);
md = mean(qt1-qt0);
err1 = (abs(qt1-qt0));
err1 = err1(~isnan(err1));

n5 = length(find(err1 <5))/length(err1);
n10 = length(find(err1 <10))/length(err1);
n20 = length(find(err1 <20))/length(err1);
n30 = length(find(err1 <30))/length(err1);
n40 =length(find(err1 <40))/length(err1);
n100 = length(find(err1 <100))/length(err1);

avg_err = mean(err1);
std_err = std(err1);

str = sprintf('%6.4f   %6.4f   %6.4f   %6.4f   %6.4f   %6.4f   %6.4f   %6.4f',[md,avg_err,std_err,n5,n10,n20,n40,n100]);
disp(str);
res = [avg_err,std_err,n5,n10,n20,n40,n100] ;


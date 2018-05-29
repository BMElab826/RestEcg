% 评价两个波形相似度的函数
% method 
% correlation: 相关系数
% aver: 绝对平均误差等等。
%%
function [meas,corr_all_lead] = eval_waves_similarity(wave1,wave2 , method)
    corr_all_lead = corrcoef(wave1,wave2);
    corr_all_lead = corr_all_lead(1,2);
    for n=1:size(wave1,2)
          x = wave1(:,n) - mean(wave1(:,n));
          y = wave2(:,n) - mean(wave2(:,n));
        if strcmp('correlation',method)
           acor = xcorr(x,y,5,'coef')  ;         
            meas(n) = max(acor);
        elseif strcmp('aver',method)
            meas(n) = mean(abs(x-y));
        end
    end
end
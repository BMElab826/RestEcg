% 测试Median波形产生的准确性
clc
close all;
clear all;
load('E:\DataBase\MuseDB_500Hz.mat');
fs = 500;

% method :  'correlation' / 'aver'
% method = input('please input the method(correlation/aver): ','s');
%%
% cor1 = zeros(length(DATA),8);
% cor2 = cor1;cor3 = cor1;cor4 = cor1;
% err1 = cor1;err2 = cor1;err3 = cor1;err4 = cor1;
%%
for ii = 1:length(DATA)%94%1309%102 93467 
   ecg = DATA(ii).wave;
   segdata =  beat_segment(ecg, DATA(ii).rpos, DATA(ii).QRStype, 0, 0.5, 0.7, DATA(ii).fs);
   wave0 = double(DATA(ii).wave_median)*DATA(ii).adu/1000;
   [ileft,iright ] = find_zeros_idxs(wave0(:,1));  
   wave0 = wave0(ileft:iright,:);
   wave1 = baseline_median(segdata,1); % way =1,2,3,4,5
   wave1 = wave1(ileft:iright,:);
   wave2 = baseline_median(segdata,2); % way =1,2,3,4,5
   wave2 = wave2(ileft:iright,:);
   wave3 = baseline_median(segdata,3); % way =1,2,3,4,5
   wave3 = wave3(ileft:iright,:);
   wave4 = baseline_median(segdata,4); % way =1,2,3,4,5
   wave4 = wave4(ileft:iright,:);
   cor1(ii,:) = eval_waves_similarity(wave1, wave0,'correlation');
   err1(ii,:) = eval_waves_similarity(wave1, wave0,'aver');
   cor2(ii,:) = eval_waves_similarity(wave2, wave0,'correlation');
   err2(ii,:) = eval_waves_similarity(wave2, wave0,'aver');
   cor3(ii,:) = eval_waves_similarity(wave3, wave0,'correlation');
   err3(ii,:) = eval_waves_similarity(wave3, wave0,'aver');
   cor4(ii,:) = eval_waves_similarity(wave4, wave0,'correlation');
   err4(ii,:) = eval_waves_similarity(wave4, wave0,'aver');
end
%%
cor1(isnan(cor1)) = 1;
cor2(isnan(cor2)) = 1;
cor3(isnan(cor3)) = 1;
cor4(isnan(cor4)) = 1;
disp([mean(mean(cor1)) mean(mean(cor2)) mean(mean(cor3)) mean(mean(cor4))]);
disp([length(find(cor1>=0.95))/(size(cor1,1)*size(cor1,2))...
    length(find(cor2>=0.95))/(size(cor1,1)*size(cor1,2))...
    length(find(cor3>=0.95))/(size(cor1,1)*size(cor1,2))...
    length(find(cor4>=0.95))/(size(cor1,1)*size(cor1,2))]);
% mean_err = mean(trim_meas_err);
% std_err =  std(trim_meas_err);



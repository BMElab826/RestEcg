clc;
clear all;
close all;

load('E:\DataBase\MuseDB_500Hz.mat')
% lst = [5,7,8,10,12,13,14,15,16,17,23,24,25,26,27,224,264,276,300,316,317,382,394,396,456,463,467,539,620,678,695,758,797,822,891,916,945,956,977,1001,1066,1067,1116,1134,1170,1192,1212,1227,1372];
lst = 1126 % [209	264	268	427	481	618	630	917	1032	1161	1165	1201]; %[5,7,15,16,17,23,26,316,317,916];  % non_cul_RAxis

 for kk = 1:length(lst)
     ii = lst(kk);
    ecgI = DATA(ii).wave_median(:, 1);
    ecgII = DATA(ii).wave_median(:, 2);
    
    rpos = [DATA(ii).Meas.POnset, DATA(ii).Meas.POffset, DATA(ii).Meas.QOnset, DATA(ii).Meas.QOffset, DATA(ii).Meas.TOffset];
    
    [maxI,idx1P] = max(ecgI(rpos(3):rpos(4)));
    [minI,idx1PP] = min(ecgI(rpos(3):rpos(4)));

    [maxII,idx2P,] = max(ecgII(rpos(3):rpos(4)));
    [minII,idx2PP] = min(ecgII(rpos(3):rpos(4)));
    
    figure
    subplot(2,1,1)
     plot_ecg_beat_type(ecgI,rpos,'()()(');  hold on; plot(idx1P+rpos(3)-1, ecgI(idx1P+rpos(3)-1),'*'); 
                                             hold on; plot(idx1PP+rpos(3)-1, ecgI(idx1PP+rpos(3)-1),'*'); 
                                             hold off;
                                             title(ii)
                                             disp(ecgI(idx1P+rpos(3)-1))
    subplot(2,1,2)
     plot_ecg_beat_type(ecgII,rpos,'()()('); hold on;  plot(idx2P+rpos(3)-1, ecgII(idx2P+rpos(3)-1),'*');
                                             hold on;  plot(idx2PP+rpos(3)-1, ecgII(idx2PP+rpos(3)-1),'*');
                                             hold off;
    
end
%% 12导联各自的中值波形,按照 meas_matrix 导联顺序排列
function median_wave12 = calu_median_wave12(wave_median)
    median_wave12(:,1) = wave_median(:,3);  % v1
    median_wave12(:,2) = wave_median(:,4);  % v2
    median_wave12(:,3) = wave_median(:,5);  % v3
    median_wave12(:,4) = wave_median(:,6);  % v4
    median_wave12(:,5) = wave_median(:,7);  % v5
    median_wave12(:,6) = wave_median(:,8);  % v6
    median_wave12(:,7) = wave_median(:,1);  % I 
    median_wave12(:,8) = ceil(wave_median(:,1) - (wave_median(:,2)/2));  % aVL  
    median_wave12(:,9) = wave_median(:,2);  % II         
    median_wave12(:,10) = ceil(wave_median(:,2) - (wave_median(:,1)/2)); % aVF 
    median_wave12(:,11)  = wave_median(:,2) - wave_median(:,1); % III
    median_wave12(:,12) = ceil(-(wave_median(:,1)+wave_median(:,2))/2);  % aVR
% way:1,2,3,4,5
function median_wave = baseline_median(segdata,way)
    c = [];
    for kk = 1:size(segdata,1)
        m = 1;
        wave_md2 = [];
        wave_md2_lp = [];
        wave_md2_hp = [];
        for jj = 1:size(segdata,3);
            tmp = segdata(kk,:,jj);
            y = ecg_baseline(tmp,0.5/500);
            wave_md2(:,m) = tmp;
            wave_md2_lp(:,m)  =y ;
            wave_md2_hp(:,m)  = tmp - y;
            m = m +1;
        end; 
        LP = cat(2,median(wave_md2_lp(:,1:3:end),2),median(wave_md2_lp(:,2:3:end),2),mean(wave_md2_lp(:,3:3:end),2));
        HP = cat(2,mean(wave_md2_hp(:,1:3:end),2),mean(wave_md2_hp(:,2:3:end),2),mean(wave_md2_hp(:,3:3:end),2));
        if way==1
            median_wave(:,kk) = median(LP,2) + median(HP,2);
        elseif way==2
            median_wave(:,kk) = median(wave_md2_hp,2)+median(wave_md2_lp,2);
        elseif way==3
            median_wave(:,kk) = median(wave_md2,2); 
        elseif way==4
            median_wave(:,kk) = mean(wave_md2,2); 
        elseif way==5    
            LP = cat(2,median(wave_md2_lp(:,1:3:end),2),median(wave_md2_lp(:,2:3:end),2),mean(wave_md2_lp(:,3:3:end),2));
            HP = cat(2,median(wave_md2_hp(:,1:3:end),2),median(wave_md2_hp(:,2:3:end),2),mean(wave_md2_hp(:,3:3:end),2));
            median_wave(:,kk) = mean(LP,2) + mean(HP,2);        
    end
    
end
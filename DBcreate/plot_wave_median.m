function plot_wave_median(Meas_Orig, wave_median)
    meas_rpos = [];
    if isfield(Meas_Orig, 'POnset')
        meas_rpos = [meas_rpos Meas_Orig.POnset];
    end
    if isfield(Meas_Orig, 'POnset')
        meas_rpos = [meas_rpos Meas_Orig.POffset];
    end
    if isfield(Meas_Orig, 'QOnset')
        meas_rpos = [meas_rpos Meas_Orig.QOnset];
    end
    if isfield(Meas_Orig, 'QOffset')
        meas_rpos = [meas_rpos Meas_Orig.QOffset];
    end 
    if isfield(Meas_Orig, 'TOffset')
        meas_rpos = [meas_rpos Meas_Orig.TOffset];
    end 
    figure;
    subplot(2,1,1)
    plot(wave_median)
    subplot(2,1,2)
    plot_ecg_beat_type(wave_median(:,1),meas_rpos,'()()('); title('Lead I');
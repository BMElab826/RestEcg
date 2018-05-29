clc;
clear;
close;
list = {'前壁心肌梗死','侧壁心肌梗死','前侧壁心肌梗死','前间隔心肌梗死','间壁心肌梗死','下壁心肌梗死','下后壁心肌梗死','急性心肌梗死','正常心电图'};
classes_list = {'qianbi','cebi','qiancebi','qianjiange','jianbi','xiabi','xiahoubi','jixing','normal'};
root_path = 'E:\DataBase\180413ecg\data\Classify_f\';

for ii = 1:length(list)
    dir_path = [root_path list{ii}];
    dir_list = dir([dir_path  '\*.xml']);
    save_path = ['E:\DataBase\MI_500Hz\' classes_list{ii} '\'];
    if ~exist(save_path,'dir')
        mkdir(save_path);
    end
    disp([num2str(ii-1) '   '  dir_path '   ' save_path])
    
    m = 0; 
    for jj = 1:length(dir_list)
        fname = fullfile(dir_path,dir_list(jj).name);
        [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu]=musexmlread(fname);
        if  Meas.ECGSampleBase==500&&...
                isfield(Meas,'PRInterval')&&isfield(Meas,'QTInterval')...
                &&isfield(Meas,'POffset')&&isfield(Meas,'POnset')
            a1 = Meas.PRInterval-2*( Meas.QOnset - Meas.POnset);
            a2 = Meas.QTInterval - 2*(  Meas.TOffset-Meas.QOnset);
            a3 =  Meas.QRSDuration - 2*(  Meas.QOffset-Meas.QOnset);
            if a1==0 && a2==0 && a3 == 0
                if fs==500
                    m = m+1;
                    name = [num2str((ii-1)) '_' num2str(fs) '_' num2str(m)];
                    disp([save_path, name])
                    save([save_path name], 'wave_median')
                end
            end
        end
    end
    disp(m)
    if length(dir_list) ~= m
        disp(dir_path)
    end
    num(ii) = m;
end
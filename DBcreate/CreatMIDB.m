clc
clear all;
close all;
root_path = 'E:\DataBase\180413ecg\data\Classify_f\';
list = {'Ç°±ÚÐÄ¼¡¹£ËÀ','²à±ÚÐÄ¼¡¹£ËÀ','Ç°²à±ÚÐÄ¼¡¹£ËÀ','Ç°¼ä¸ôÐÄ¼¡¹£ËÀ','¼ä±ÚÐÄ¼¡¹£ËÀ','ÏÂ±ÚÐÄ¼¡¹£ËÀ','ÏÂºó±ÚÐÄ¼¡¹£ËÀ','¼±ÐÔÐÄ¼¡¹£ËÀ','Õý³£ÐÄµçÍ¼'};
classes_list = {'qianbi','cebi','qiancebi','qianjiange','jianbi','xiabi','xiahoubi','jixing','normal'};
%133
% DATA = [];
% m = 1;
sum_all = 0;
list_ca = [];
for jj = 1:length(list)
    DATA = [];
    m = 1;
    dir_path = [root_path list{jj}];
    dir_list = dir([dir_path  '\*.xml']);
    disp([num2str(jj-1) '   '  dir_path ])
    for ii = 1:length(dir_list)
        fname = fullfile(dir_path,dir_list(ii).name);
        [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu]=musexmlread(fname);
        if  Meas.ECGSampleBase==500&&...
                isfield(Meas,'PRInterval')&&isfield(Meas,'QTInterval')...
                &&isfield(Meas,'POffset')&&isfield(Meas,'POnset')
            a1 = Meas.PRInterval-2*( Meas.QOnset - Meas.POnset);
            a2 = Meas.QTInterval - 2*(  Meas.TOffset-Meas.QOnset);
            a3 =  Meas.QRSDuration - 2*(  Meas.QOffset-Meas.QOnset);
            if a1==0 && a2==0 && a3 == 0
                if fs==500
                    DATA(m).wave = wave*adu/1000;
                    DATA(m).rpos = floor(rpos*Meas.ECGSampleBase/(2*fs));
                    DATA(m).QRStype = QRStype;
                    DATA(m).wave_median = wave_median;                
                    DATA(m).fs = fs;                    
                    DATA(m).lead_label = label;
                    DATA(m).Meas = Meas;                   
                    DATA(m).Meas_Orig = Meas_Orig;                    
                    DATA(m).diag = diag;
                    DATA(m).diag_orig = diag_orig;          
                    DATA(m).Meas_Matrix = Meas_Matrix;
                    % laobel of Horizontal Axis  ºáÖá
                    DATA(m).Hor_label_Meas_Matrix = cellstr(char('PA', 'PPA', 'QA', 'QD', 'RA', 'RD', 'SA', 'SD', 'RPA', 'RPD', 'SPA', 'STJ', 'STM', 'STE', 'TA', 'TPA'))';
                    % laobel of  Vertical Axis ×ÝÖá
                    DATA(m).Ver_label_Meas_Matrix = cellstr(char('V1','V2','V3','V4','V5','V6','I','aVL','II','aVF','III','aVR'));
                    DATA(m).adu = adu;
                    DATA(m).class_label = jj-1;
                    m = m +1;
                end
            end
        end
    end
    list_ca(:,jj) = m-1;
    sum_all = sum_all + (m-1);
    disp(['classes is ' list{jj} '£»  label is ' num2str(jj-1) ])
    save_path = ['E:\DataBase\180413ecg\data\' classes_list{jj} '.mat' ];
    disp(save_path)
    save(save_path, 'DATA','-v7.3')
end

%     save('E:\DataBase\180413ecg\data\MI_500Hz.mat','DATA','-v7.3');    
%     load('E:\DataBase\180413ecg\data\MI_500Hz.mat');
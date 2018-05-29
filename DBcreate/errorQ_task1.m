%%
% date: 2018.05.17
% author: huangjiao 
% ���ܣ�
%     1�������������ݣ�ÿ����������д��һ��struct�����һ��mat�ļ�
%     2��������Q�������쳣��������csv�ļ�
% ���񣺸���ECG��meas_matrix�е�QA��RA��QD�жϸ�����Q�����쳣���
%%
clc
clear
data_path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\errorQ_180517\';
draw = 0;
if ~exist(outpth, 'dir')
    mkdir(outpth)
end

fid1 = fopen('diag�쳣Q��_����.csv','w+');
%%
sub_path = dir(data_path);
n = 0;
for ii = 1:length(sub_path)
    if( isequal( sub_path(ii).name, '.' )||...
        isequal( sub_path(ii).name, '..')||...
        ~sub_path(ii).isdir)               % �������Ŀ¼������
        continue;
    end
    DATA = []; m = 0;
    subdirpath = fullfile( data_path, sub_path(ii).name, '*.xml' );
    xml_file = dir( subdirpath ); 
    for jj = 1:length(xml_file)
        class_path = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
        [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu]=musexmlread(class_path);
        % ��ͼ�鿴wave_meidan
        if draw ==1
            plot_wave_median(Meas_Orig, wave_median)
        end
        m = m+1;
        read_diag(fid1,xml_file(jj).name,diag,diag_orig)
        DATA(m).name = xml_file(jj).name;
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
        % laobel of Horizontal Axis  ����
        DATA(m).Hor_label_Meas_Matrix = cellstr(char('PA', 'PPA', 'QA', 'QD', 'RA', 'RD', 'SA', 'SD', 'RPA', 'RPD', 'SPA', 'STJ', 'STM', 'STE', 'TA', 'TPA'))';
        % laobel of  Vertical Axis ����
        DATA(m).Ver_label_Meas_Matrix = cellstr(char('V1','V2','V3','V4','V5','V6','I','aVL','II','aVF','III','aVR'));
        DATA(m).adu = adu;
    end
    save_path = [outpth sub_path(ii).name '.mat' ];
    disp(save_path)
    save(save_path, 'DATA','-v7.3')
                    
end     
%%
fclose(fid1);

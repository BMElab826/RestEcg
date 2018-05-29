%%
% 2018.05.08
% 1.diag������ɸѡQ���쳣
% 2.�����������£���diag_orig��ɸѡ�ļ�����
% 3����д��ǩ����ʽ:Q���쳣��ǰ/��/���ļ�������

%%
clc
clear
data_path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\Q_MI0508';

typeQ = {'�쳣Q��'};
type = {'ǰ���ļ�����','����ļ�����','ǰ����ļ�����','ǰ����ļ�����','����ļ�����','�±��ļ�����','�º���ļ�����','�����ļ�����'};
fid1 = fopen('diag�쳣Q��_diag_orig��������ǩ.csv','w+');
%%
sub_path = dir(data_path);
Q_path = {}; m=0;
for ii = 1:length(sub_path)
    if( isequal( sub_path(ii).name, '.' )||...
        isequal( sub_path(ii).name, '..')||...
        ~sub_path(ii).isdir)               % �������Ŀ¼������
        continue;
    end
    subdirpath = fullfile( data_path, sub_path(ii).name, '*.xml' );
    xml_file = dir( subdirpath ); 
    for jj = 1:length(xml_file)
        class_path = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
        [diag,diag_orig] = musereaddiag(class_path);
        % diag�г����쳣Q������
        diag_str = [];
        for kk = 1:length(diag)
            diag_str = [diag_str  diag{kk}];
        end  
        diag_orig_str = [];
        for nn = 1:length(diag_orig)
            diag_orig_str = [diag_orig_str  diag_orig{nn}];
        end
        flag = 0;
        for hh = 1:length(type)
            if ~isempty(strfind(diag_str,'�쳣Q��')) && ~isempty(strfind(diag_orig_str,type{hh}))
                flag = flag+1;
                target = type{hh};
            end
        end
        if flag == 1
            fprintf(fid1,'%s,',class_path);
            fprintf(fid1,'%s,',target);
            fprintf(fid1,'\r\n');
            if ~exist(fullfile(outpth,target),'dir')
                mkdir(fullfile(outpth,target));
            end
            copyfile(class_path, fullfile(outpth,target));
            m = m+1;
            disp(m)
        end
    end        
end    
fclose(fid1);
Q_path = Q_path';
%%
clc
clear
data_path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\cQ_MI0508';

typeQ = {'�쳣Q��'};
type = {'ǰ���ļ�����','����ļ�����','ǰ����ļ�����','ǰ����ļ�����','����ļ�����','�±��ļ�����','�º���ļ�����','�����ļ�����'};
fid1 = fopen('diag�쳣Q��_diag_orig��������ǩ(���ϱ�ǩ)1.csv','w+');
%%
sub_path = dir(data_path);
n = 0; num_100000=0; num_010000=0; num_001000=0; num_000100=0; num_000010=0; num_000001=0;
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
        sQ = [];
        for kk = 1:length(diag)
            if strfind(diag{kk},'�쳣Q��')
                n = n+1;
                disp(n)
                str = diag{kk};
                str(str==',') = ';';
                sQ = [sQ str];
                fprintf(fid1,'%s,' , xml_file(jj).name);
                fprintf(fid1,'%s,' , sQ);
                
                m = '000000';
                s = [];
                for hh = 1:length(diag_orig)
                    if ~isempty(strfind(diag_orig{hh},'�ļ�����'))
                         s = [s ','  diag_orig{hh}];
                    end
                    if (~isempty(strfind(diag_orig{hh},'�±��ļ�����')) || ~isempty(strfind(diag_orig{hh},'�º���ļ�����')) )            
                        m(1) = '1';
                        num_100000 = num_100000 +1;
                    end;
                    if (~isempty(strfind(diag_orig{hh},'ǰ����ļ�����')) || ~isempty(strfind(diag_orig{hh},'����ļ�����')) )
                        m(2) = '1';
                        num_010000 = num_010000 +1;
                    end;
                    if ~isempty(strfind(diag_orig{hh},'ǰ���ļ�����') )
                         m(3) = '1';
                         num_001000 = num_001000 +1;
                    end;
                    if ~isempty(strfind(diag_orig{hh},'ǰ����ļ�����'))
                          m(4) = '1';
                          num_000100 = num_000100 +1;
                    end;
                    if ~isempty(strfind(diag_orig{hh},'����ļ�����')) && isempty(strfind(diag_orig{hh},'ǰ����ļ�����')) && isempty(strfind(diag_orig{hh},'�߲���ļ�����'))
                         m(5) = '1';
                         num_000010 = num_000010 +1;
                    end;
                    if ~isempty(strfind(diag_orig{hh},'�߲���ļ�����'))
                         m(6) = '1'; 
                         num_000001 = num_000001 +1;
                    end;        
                end
                fprintf(fid1,'%s,%s' ,(m),s);
                fprintf(fid1,'\r\n');
                if length(strfind(m,'1')) == 1
                    output_file = fullfile(outpth,m);
                    if ~exist(output_file, 'dir')
                        mkdir(output_file)
                    end
                    copyfile(class_path, output_file);
                end
                if isempty(strfind(m,'1'))
                    output_file = fullfile(outpth,m);
                    if ~exist(output_file, 'dir')
                        mkdir(output_file)
                    end
                    copyfile(class_path, output_file);
                end                
            end;            
        end         
    end        
end    
fclose(fid1);

% ��ȡdiag�й����쳣Q��������
% ��ȡ�����쳣Q��ʱ��orig�й��ڡ��ļ������������� 
function read_diag(fid1,xml_name,diag,diag_orig)
        sQ = []; 
        fprintf(fid1,'%s,' , xml_name);
        for kk = 1:length(diag)
            if strfind(diag{kk},'�쳣Q��')
                str = diag{kk};
                str(str==',') = ';';
                sQ = [sQ str];
                fprintf(fid1,'%s,' , sQ);
                
                m = '000000';
                s = [];
                for hh = 1:length(diag_orig)
                    if ~isempty(strfind(diag_orig{hh},'�ļ�����'))
                         s = [s ','  diag_orig{hh}];
                    end
                    if (~isempty(strfind(diag_orig{hh},'�±��ļ�����')) || ~isempty(strfind(diag_orig{hh},'�º���ļ�����')) )            
                        m(1) = '1';
                    end;
                    if (~isempty(strfind(diag_orig{hh},'ǰ����ļ�����')) || ~isempty(strfind(diag_orig{hh},'����ļ�����')) )
                        m(2) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'ǰ���ļ�����') )
                         m(3) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'ǰ����ļ�����'))
                          m(4) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'����ļ�����')) && isempty(strfind(diag_orig{hh},'ǰ����ļ�����')) && isempty(strfind(diag_orig{hh},'�߲���ļ�����'))
                         m(5) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'�߲���ļ�����'))
                         m(6) = '1'; 
                    end;        
                end
                if strcmp(m,'000000')
                    s = '��ȷ�����쳣Q��';
                end 
                fprintf(fid1,'%s,%s' ,(m),s);
            end   
        end
        if isempty(sQ)
            sQ = '����Q��';
            fprintf(fid1,'%s', sQ);
        end
        fprintf(fid1,'\r\n');
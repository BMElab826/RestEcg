% 读取diag中关于异常Q波的描述
% 读取出现异常Q波时，orig中关于“心肌梗死”的描述 
function read_diag(fid1,xml_name,diag,diag_orig)
        sQ = []; 
        fprintf(fid1,'%s,' , xml_name);
        for kk = 1:length(diag)
            if strfind(diag{kk},'异常Q波')
                str = diag{kk};
                str(str==',') = ';';
                sQ = [sQ str];
                fprintf(fid1,'%s,' , sQ);
                
                m = '000000';
                s = [];
                for hh = 1:length(diag_orig)
                    if ~isempty(strfind(diag_orig{hh},'心肌梗死'))
                         s = [s ','  diag_orig{hh}];
                    end
                    if (~isempty(strfind(diag_orig{hh},'下壁心肌梗死')) || ~isempty(strfind(diag_orig{hh},'下后壁心肌梗死')) )            
                        m(1) = '1';
                    end;
                    if (~isempty(strfind(diag_orig{hh},'前间隔心肌梗死')) || ~isempty(strfind(diag_orig{hh},'间壁心肌梗死')) )
                        m(2) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'前壁心肌梗死') )
                         m(3) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'前侧壁心肌梗死'))
                          m(4) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'侧壁心肌梗死')) && isempty(strfind(diag_orig{hh},'前侧壁心肌梗死')) && isempty(strfind(diag_orig{hh},'高侧壁心肌梗死'))
                         m(5) = '1';
                    end;
                    if ~isempty(strfind(diag_orig{hh},'高侧壁心肌梗死'))
                         m(6) = '1'; 
                    end;        
                end
                if strcmp(m,'000000')
                    s = '不确定型异常Q波';
                end 
                fprintf(fid1,'%s,%s' ,(m),s);
            end   
        end
        if isempty(sQ)
            sQ = '正常Q波';
            fprintf(fid1,'%s', sQ);
        end
        fprintf(fid1,'\r\n');
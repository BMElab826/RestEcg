%%
path = 'D:\MGCDB\muse\classify\�ĵ�ͼ������STT\';
list = dir(fullfile(path,'*.mat'));
fid = fopen(fullfile(path,'index.csv'),'w');
for ii = 1:length(list)
    load(fullfile(path,list(ii).name));
    fprintf(fid,'%s,' , list(ii).name(1:end-4));
    s = [] ;
    for kk = 1:length(DATA.diag)
        if contains(DATA.diag{kk},'�ĵ�ͼ������','IgnoreCase',true)
            str = DATA.diag{kk};
            str(str==',') = ';';
            s = [s str];
            index{ii,1} =  DATA.diag{kk};
        end;
    end;
     fprintf(fid,'%s,' , s);
    m = '000000';
    s = [];
    for kk = 1:length(DATA.diag_orig)
        
        if contains(DATA.diag_orig{kk},'�ļ�ȱѪ')
             s = [s ','  DATA.diag_orig{kk}];
        end
        if (contains(DATA.diag_orig{kk},'�±��ļ�ȱѪ') || contains(DATA.diag_orig{kk},'�º���ļ�ȱѪ'))             
            m(1) = '1';
           
        end;
        if (contains(DATA.diag_orig{kk},'ǰ����ļ�ȱѪ') || contains(DATA.diag_orig{kk},'����ļ�ȱѪ')) 
            m(2) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'ǰ���ļ�ȱѪ') 
             m(3) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'ǰ����ļ�ȱѪ')
              m(4) = '1';
       
        end;
         if contains(DATA.diag_orig{kk},'����ļ�ȱѪ') && ...
                 ~contains(DATA.diag_orig{kk},'ǰ����ļ�ȱѪ')&& ...
                 ~contains(DATA.diag_orig{kk},'�߲���ļ�ȱѪ')&&...
                  ~contains(DATA.diag_orig{kk},'�²���ļ�ȱѪ')
             m(5) = '1';
         end;
        if contains(DATA.diag_orig{kk},'�²���ļ�ȱѪ')
             m(6) = '1';  
        end;
        
    end
    fprintf(fid,'%s,%s' ,(m),s);
    index{ii,2} =  s;
    fprintf(fid,'\n' );
end
fclose(fid);
%%
path = 'D:\MGCDB\muse\classify\�쳣Q��\';
list = dir('D:\MGCDB\muse\classify\�쳣Q��\*.mat');

fid = fopen(fullfile(path,'index.csv'),'w');


for ii = 1:length(list)
    load(fullfile(path,list(ii).name));
    fprintf(fid,'%s,' , list(ii).name(1:end-4));
    s = [] ;
    for kk = 1:length(DATA.diag)
        if contains(DATA.diag{kk},'�쳣Q��','IgnoreCase',true)
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
        
        if contains(DATA.diag_orig{kk},'�ļ�����')
             s = [s ','  DATA.diag_orig{kk}];
        end
        if (contains(DATA.diag_orig{kk},'�±��ļ�����') || contains(DATA.diag_orig{kk},'�º���ļ�����'))             
            m(1) = '1';
           
        end;
        if (contains(DATA.diag_orig{kk},'ǰ����ļ�����') || contains(DATA.diag_orig{kk},'����ļ�����')) 
            m(2) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'ǰ���ļ�����') 
             m(3) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'ǰ����ļ�����')
              m(4) = '1';
       
        end;
         if contains(DATA.diag_orig{kk},'����ļ�����') && ~contains(DATA.diag_orig{kk},'ǰ����ļ�����')&& ~contains(DATA.diag_orig{kk},'�߲���ļ�����')
             m(5) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'�߲���ļ�����')
             m(6) = '1';
  
        end;
        
    end
    fprintf(fid,'%s,%s' ,(m),s);
    index{ii,2} =  s;
    fprintf(fid,'\n' );
end
fclose(fid);
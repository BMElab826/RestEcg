%%
path = 'D:\MGCDB\muse\classify\Òì³£Q²¨\';
list = dir('D:\MGCDB\muse\classify\Òì³£Q²¨\*.mat');

fid = fopen(fullfile(path,'index.csv'),'w');


for ii = 1:length(list)
    load(fullfile(path,list(ii).name));
    fprintf(fid,'%s,' , list(ii).name(1:end-4));
    s = [] ;
    for kk = 1:length(DATA.diag)
        if contains(DATA.diag{kk},'Òì³£Q²¨','IgnoreCase',true)
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
        
        if contains(DATA.diag_orig{kk},'ÐÄ¼¡¹£ËÀ')
             s = [s ','  DATA.diag_orig{kk}];
        end
        if (contains(DATA.diag_orig{kk},'ÏÂ±ÚÐÄ¼¡¹£ËÀ') || contains(DATA.diag_orig{kk},'ÏÂºó±ÚÐÄ¼¡¹£ËÀ'))             
            m(1) = '1';
           
        end;
        if (contains(DATA.diag_orig{kk},'Ç°¼ä¸ôÐÄ¼¡¹£ËÀ') || contains(DATA.diag_orig{kk},'¼ä±ÚÐÄ¼¡¹£ËÀ')) 
            m(2) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'Ç°±ÚÐÄ¼¡¹£ËÀ') 
             m(3) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'Ç°²à±ÚÐÄ¼¡¹£ËÀ')
              m(4) = '1';
       
        end;
         if contains(DATA.diag_orig{kk},'²à±ÚÐÄ¼¡¹£ËÀ') && ~contains(DATA.diag_orig{kk},'Ç°²à±ÚÐÄ¼¡¹£ËÀ')&& ~contains(DATA.diag_orig{kk},'¸ß²à±ÚÐÄ¼¡¹£ËÀ')
             m(5) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'¸ß²à±ÚÐÄ¼¡¹£ËÀ')
             m(6) = '1';
  
        end;
        
    end
    fprintf(fid,'%s,%s' ,(m),s);
    index{ii,2} =  s;
    fprintf(fid,'\n' );
end
fclose(fid);
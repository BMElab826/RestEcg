%%
path = 'D:\MGCDB\muse\classify\心电图不正常STT\';
list = dir(fullfile(path,'*.mat'));
fid = fopen(fullfile(path,'index.csv'),'w');
for ii = 1:length(list)
    load(fullfile(path,list(ii).name));
    fprintf(fid,'%s,' , list(ii).name(1:end-4));
    s = [] ;
    for kk = 1:length(DATA.diag)
        if contains(DATA.diag{kk},'心电图不正常','IgnoreCase',true)
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
        
        if contains(DATA.diag_orig{kk},'心肌缺血')
             s = [s ','  DATA.diag_orig{kk}];
        end
        if (contains(DATA.diag_orig{kk},'下壁心肌缺血') || contains(DATA.diag_orig{kk},'下后壁心肌缺血'))             
            m(1) = '1';
           
        end;
        if (contains(DATA.diag_orig{kk},'前间隔心肌缺血') || contains(DATA.diag_orig{kk},'间壁心肌缺血')) 
            m(2) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'前壁心肌缺血') 
             m(3) = '1';
        
        end;
        if contains(DATA.diag_orig{kk},'前侧壁心肌缺血')
              m(4) = '1';
       
        end;
         if contains(DATA.diag_orig{kk},'侧壁心肌缺血') && ...
                 ~contains(DATA.diag_orig{kk},'前侧壁心肌缺血')&& ...
                 ~contains(DATA.diag_orig{kk},'高侧壁心肌缺血')&&...
                  ~contains(DATA.diag_orig{kk},'下侧壁心肌缺血')
             m(5) = '1';
         end;
        if contains(DATA.diag_orig{kk},'下侧壁心肌缺血')
             m(6) = '1';  
        end;
        
    end
    fprintf(fid,'%s,%s' ,(m),s);
    index{ii,2} =  s;
    fprintf(fid,'\n' );
end
fclose(fid);
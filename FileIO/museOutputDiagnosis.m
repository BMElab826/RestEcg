%%
clc
clear
list = dir('D:\DataBase\MUSE\*.xml');
fid1 = fopen('diag.csv','w+');
fid2 = fopen('diag_org.csv','w+');
for ii = 1:length(list)
    fname = fullfile('D:\DataBase\MUSE',list(ii).name);
    try
        [wave,rpos,QRStype,wave_median,sr,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu,PatientID]=musexmlread(fname);
        fprintf(fid1,[list(ii).name ',']);
        fprintf(fid2,[list(ii).name ',']);
            fprintf(fid1,[PatientID ',']);
        fprintf(fid2,[PatientID ',']);    
        for kk = 1:length(diag_orig)
            fprintf(fid1,'%s,',diag_orig{kk});
        end;
        fprintf(fid1,'\r\n');
        
        for kk = 1:length(diag)
            fprintf(fid2,'%s,',diag{kk});
        end;
        fprintf(fid2,'\r\n');
        
    catch
        disp(ii);
    end
    
end
fclose(fid1);
fclose(fid2);
%%


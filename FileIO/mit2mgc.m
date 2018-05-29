%%
path_old = 'D:\Database_MIT\mitdb\';

path = 'D:\MGCDB\mitdb250\';

list = dir([path_old '*.dat']);
for sub = 1 %1:length(list)
    record = list(sub).name;
    record = record(1:length(record)-4);
    heasig_old=readheader(fullfile(path_old,[record '.hea']));
    
    ecg=rdsign212(fullfile(path_old,[record '.dat']),heasig_old.nsig,1,heasig_old.nsamp);
    ecg = ecg(:,1) - heasig_old.adczero(1);
    ann_old= readannot(fullfile(path_old,[record '.atr']));
    
    heasig = heasig_old;
    heasig.nsig = 1;
    heasig.freq = 250;
    heasig.fmt(1) = 16;
    heasig.adcres(1) = 16;
    heasig.gain= [200 200];
    
    
    ecg1 = resample(ecg,heasig.freq,heasig_old.freq );
    ecg1 = ecg1(1:floor(length(ecg1)/250)*250);
    fid = fopen(fullfile(path,[record '.dat']),'wb+');
    fwrite(fid,ecg1,'short');
    fclose(fid);
    
    heasig.nsamp = length(ecg1);
    fid = fopen(fullfile(path,[record '.hea']),'w+');
    fprintf(fid,'%s %d %d %d \r\n' , heasig.recname, heasig.nsig,heasig.freq,heasig.nsamp);
    for ii = 1:heasig.nsig
        fprintf(fid,'%s %d %d %d %d %d %d %d %s\n' , heasig.fname(ii,:), heasig.fmt(ii),heasig.gain(ii),...
            heasig.adcres(ii), 0,0,0,0, heasig.desc(ii,:));
    end
    fclose(fid);
    
    ann = ann_old;
    ann.time  = floor(ann_old.time*heasig.freq/heasig_old.freq) ;
    writeannot(fullfile(path,[record '.atr']),ann);
    matmgc('file_analysis',fullfile(path,[record ]),fullfile(path,[record '.qrs']),'mgc');
    
%       matmgc('file_analysis',fullfile(path,[record ]),fullfile(path,[record '.qrs']),'mgc');
%    A(:,sub) =  matmgc('mit_bxb',path,record,'atr','ate','5:0');
end
%%
clc
A1 = sum(A,2);
str = sprintf('%.4f %.4f %.4f %.4f',1-A1(3)/(A1(1)+A1(3)),...
1-A1(2)/(A1(1)+A1(3)),...
1-A1(5)/(A1(4)+A1(6)),...
1-A1(6)/(A1(4)+A1(6)));
disp(str);








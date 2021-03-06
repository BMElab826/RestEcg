function [wave_median,adu,label1,sr1,iend] = get_medianwave(fname)
fid = fopen(fname,'r','native','UTF-8');
str = fscanf(fid,'%s');
fclose(fid);
idx0 = strfind(str,'<');
idx1 = strfind(str,'>');
if length(idx1) == length(idx0)+1
    tmp = idx1(1:length(idx0)) - idx0;
    a = 1:length(idx0);
    x = find((tmp<0));
    idx1(x(1)) = [];
end;

if length(idx0)~= length(idx1)
    fid = fopen(fname,'r','native');
    str = fscanf(fid,'%s');
    idx0 = strfind(str,'<');
    idx1 = strfind(str,'>');
    fclose(fid);
end;
[wave_median,adu,label1,sr1,iend]= museGetMedianWaveform(str,idx0,idx1,1);
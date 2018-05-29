%% ¶ÁÈ¡MAGICMEDÊý¾Ý

function [heasig,ecg]  = loadmgcdata(fname)
ecg = [] ;
if strfind(fname,'.dat')
    fname = fname(1:end-4);
end;
heasig=readheader([fname '.hea']);
if isempty(heasig)
    heasig.fmt(1) = 16;
    heasig.gain(1) = 81.239998;
    heasig.freq = 250;
   
end;


if heasig.fmt(1) == 212

    ecg=rdsign212([fname '.dat'],1,1,heasig.nsamp);
    ecg = ecg/heasig.gain(1);
    ecg= ecg - mean(ecg);
end;
if heasig.fmt(1) == 16
    fid = fopen([fname '.dat']);
if fid < 0
    disp('no .dat files')
    return;
end;
ecg = fread(fid,[heasig.nsig heasig.nsamp],'short');
fclose(fid);
ecg = ecg/heasig.gain(1);

end
% 
% fid = fopen([fname '.ann']);
% if fid >= 0
%     d = fread(fid,[40 inf],'uint8');
%     d = uint8(d);
%     AnnWarning=[];
%     m = 1;
%     nWarning = 1;
%     for ii = 1 : size(d,2)
%         pos = typecast((uint8(d(1:4,ii))),'int32');
%         anntype= typecast(d(5,ii),'uint8');
%         subtype = typecast(d(6,ii),'uint8');
%         isPrint = typecast(d(7,ii),'uint8');
%         isUpload = typecast(d(8,ii),'uint8');
%         AnnWarning.pos(nWarning) = pos;
%         AnnWarning.anntype(nWarning) = anntype;
%         AnnWarning.subtype(nWarning) = subtype;
%         AnnWarning.isPrint(nWarning) = isPrint;
%         
%         x = d(9:end,ii);
%         %         x = x(x~=0);
%         AnnWarning.descript{nWarning} = char(x)';
%         nWarning = nWarning +1;
%     end
%     fclose(fid);
% end
% 
% 
% fid = fopen([fname '.qrs']);
% if fid >=0
%     d = fread(fid,[40 inf],'uint8');
%     d = uint8(d);
%     AnnBeat=[];
%     nbeat = 1;
%     for ii = 1 : size(d,2)
%         pos = typecast((uint8(d(1:4,ii))),'int32');
%         anntype= typecast(d(5,ii),'uint8');
%         subtype = typecast(d(6,ii),'uint8');
%         AnnBeat.pos(nbeat) = pos;
%         AnnBeat.anntype(nbeat) = anntype;
%         AnnBeat.subtype(nbeat) = subtype;
%         AnnBeat.qrs(nbeat,:) = typecast(d(7:end,ii),'int16');
%         nbeat = nbeat+1;
%     end
%     
%     fclose(fid);
% end
% plot_ecg_beat_type(ecg,double(beat.pos),double(beat.anntype),1, 250*10000);
function AnnBeat = loadmgcann(fname)
if isempty(strfind(fname,'.'))
    fname = [fname '.ann'];
end;

typecode = 'NLRaVFJASEj/Q~ | sT*D\"=pB^t+u?!{}en xf()r';

fid = fopen([fname ]);
if fid < 0
    AnnBeat = [];
    return;
end;
if fid >=0
    d = fread(fid,[40 inf],'uint8');
    d = uint8(d);
    AnnBeat=[];
    AnnBeat.time = (zeros(size(d,2),1));
    AnnBeat.anntyp = char( zeros(size(d,2),1));
    AnnBeat.subtyp = char(zeros(size(d,2),1));
    nbeat = 1;
    for ii = 1 : size(d,2)
        pos = typecast((uint8(d(1:4,ii))),'int32');
        anntype= typecast(d(5,ii),'uint8');
        subtype = typecast(d(6,ii),'uint8');
        ann = typecast(d(7:10,ii),'int32');
        AnnBeat.time(nbeat) = pos';
        AnnBeat.anntyp(nbeat) = (anntype);
        AnnBeat.subtyp(nbeat) = (subtype);
        AnnBeat.ann(nbeat) = ann;
%         AnnBeat.qrs(nbeat,:) = typecast(d(7:end,ii),'int16');
        nbeat = nbeat+1;
    end
    
    fclose(fid);
end


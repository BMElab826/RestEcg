function [AnnBeat,af_label] = loadAnn_mgc(fname, format)

AnnBeat = [];
af_label = [];
if nargin < 2
    format = 'mgc';
    if ~isempty(strfind(fname,'atr'))
        format = 'mit';
    end
    if ~isempty(strfind(fname,'ate'))
        format = 'mit';
    end
end;
if strcmp(format,'mgc')
    typecode = 'NLRaVFJASEj/Q~ | sT*D\"=pB^t+u?!{}en xf()r';
    
    fid = fopen([fname ]);
    if fid < 0
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
            
            if anntype ~= 5 && subtype ==5
                anntype = 9 ;
            end;
            AnnBeat.time(nbeat) = pos';
            AnnBeat.anntyp(nbeat) = typecode(anntype);
            
            if subtype ~= 0
                AnnBeat.subtyp(nbeat) = typecode(subtype);
            end
            AnnBeat.qrs(nbeat,:) = typecast(d(7:end,ii),'int16');
            nbeat = nbeat+1;
        end
        
        fclose(fid);
    end
end
if strcmp(format,'mit')
    AnnBeat = [];
    try
        AnnBeat = readannot(fname);
        m = 1;
        af_label = [];
        for ii = 1:length(AnnBeat.time)-1
            if contains(AnnBeat.aux(ii,:),'(AFIB')  && ~contains(AnnBeat.aux(ii+1,:),'(AFIB')
                af_label(m,1) = AnnBeat.time(ii);
                af_label(m,2) = AnnBeat.time(ii+1)-AnnBeat.time(ii);;
                m = m+1;
            end
        end;
        if contains(AnnBeat.aux(end,:),'(AFIB')
            af_label(m,1) = 1;
            af_label(m,2) = -1;
            m = m+1;
        end
    catch
    end;
    %     AnnBeat.pos = AnnBeat.time;
end;
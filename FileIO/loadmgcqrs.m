function AnnBeat = loadmgcqrs(fname)

 if contains(fname,'.')
    fname = fname(1:end-4);
 end
 AnnBeat = matmgc('loadmgcqrs',fname);
 AnnBeat.qrs = AnnBeat.qrs';
 AnnBeat.time  =  double(AnnBeat.time);
 clear matmgc;

% if isempty(strfind(fname,'.'))
%     fname = [fname '.qrs'];
% end;
% 
% typecode = 'NLRaVFJASEj/Q~ | sT*D\"=pB^t+u?!{}en xf()r';
% 
% fid = fopen([fname ]);
% if fid < 0
%     AnnBeat = [];
%     return;
% end;
% if fid >=0
%     d = fread(fid,[40 inf],'uint8');
%     d = uint8(d);
%     AnnBeat=[];
%     AnnBeat.time = (zeros(size(d,2),1));
%     AnnBeat.anntyp = char( zeros(size(d,2),1));
%     AnnBeat.subtyp = char(zeros(size(d,2),1));
%     nbeat = 1;
%     for ii = 1 : size(d,2)
%         pos = typecast((uint8(d(1:4,ii))),'int32');
%         anntype= typecast(d(5,ii),'uint8');
%         subtype = typecast(d(6,ii),'uint8');
%         AnnBeat.time(nbeat) = pos';
%         AnnBeat.anntyp(nbeat) = typecode(anntype);
%         if subtype ~= 0
%             AnnBeat.subtyp(nbeat) = typecode(subtype);
%         end
%       
%         AnnBeat.qrs(nbeat,:) = typecast(d(7:end,ii),'int16');
%         nbeat = nbeat+1;
%     end
%     
%     fclose(fid);
% end


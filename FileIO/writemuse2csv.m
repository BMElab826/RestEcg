function writemuse2csv(fid, PatientInfo,Meas,diag,rpos,QRStype,DataID)

      list1 = fieldnames(PatientInfo);
    list2 = fieldnames(Meas);
 
    fprintf(fid,'%010d,',DataID);
    for ii = 1:length(list1)
        fprintf(fid,'%s,',getfield(PatientInfo,list1{ii}));
    end
    for ii = 1:length(list2)
        fprintf(fid,'%d,',getfield(Meas,list2{ii}));
    end
    for ii = 1:length(diag)
        str = diag{ii};
        str(str ==',') = ';';
        fprintf(fid,'%s;',str);
    end
    fprintf(fid,',');
    for ii = 1:length(rpos)
        fprintf(fid,'%d;',rpos(ii));
    end
    fprintf(fid,',');
    for ii = 1:length(QRStype)
        fprintf(fid,'%d;',QRStype(ii));
    end
  fprintf(fid,'\n');
  
  
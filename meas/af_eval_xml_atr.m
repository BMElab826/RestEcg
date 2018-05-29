function   [nTP,nTN,nFP,nFN] = af_eval_xml_atr(record)

   report = loadmgcxml(record);
    heasig=readheader([record '.hea']);
    nsec = heasig.nsamp/heasig.freq ;
    Event_AF_Test = report.Event_AF;
    label_test = zeros(1,nsec);
    label_ref= zeros(1,nsec);
    for jj = 1 : size(Event_AF_Test,1)
        st = Event_AF_Test(jj,1);
        if st==0
            st = 1;
        end
        iend = st + floor(Event_AF_Test(jj,2));
        label_test(st:iend) = 1;
    end
    [AnnBeat,Event_AF_Ref] =  loadmitqrs([record '.atr']);
    for jj = 1 : size(Event_AF_Ref,1)
        st = floor(Event_AF_Ref(jj,1)/250);
        if st < 1
            st = 1;
        end  
        if Event_AF_Ref(jj,2)==-1
            iend = nsec;         
        else
           iend = floor(Event_AF_Ref(jj,1)/250+Event_AF_Ref(jj,2)/250);
        end
          label_ref(st:iend) = 1;
    end
  [nTP,nTN,nFP,nFN] = afdb_eval_entry(label_ref,label_test);
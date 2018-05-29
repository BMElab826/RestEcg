function [AnnBeat,af_label] =  loadmitqrs(fname)

% fname = 'D:\MGCDB\mitdb250\222.atr'
AnnBeat = [];
af_label = [];
try
    AnnBeat = readannot(fname);
    m = 1;
    af_label = [];
    index = find(AnnBeat.anntyp=='+');
    
    aux = AnnBeat.aux(index,:);
    time = AnnBeat.time(index,:);
    for ii = 1:length(time)-1
        if (contains(aux(ii,:),'(AFIB') || contains(aux(ii,:),'(AFIB')) 
            af_label(m,1) = time(ii);
            af_label(m,2) = time(ii+1)-time(ii);;
            m = m+1;
        end
    end;
    if contains(aux(end,:),'(AFIB')||contains(aux(end,:),'(AFIB')  % AFL
        af_label(m,1) = time(end);;
        af_label(m,2) = -1;
        m = m+1;
    end
catch
end;
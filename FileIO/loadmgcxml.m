%%
function report = loadmgcxml(record)

if isempty(strfind(record,'.xml'))
    record = [record '.xml'];
end;
fid = fopen(record,'rb');
if fid < 0
    report = [];
    %     fclose(fid);
    %     report.ROIecg = [];
    %     report.AnnWarning.pos = [];
    %     report.AnnWarning.descript = [];
    %     report.hr = [];
    %     report.AFIndex = [];
    %     report.PVCIndex = [];
    return;
end;
fclose(fid);
xmlDoc = xmlread(record);


node = xmlDoc.getElementsByTagName('MeasureInfo');
child = node.item(0);
m = 1;
for ii = 1:2:child.getLength-1
    report.MeasureInfo{m} = [char(child.item(ii).getNodeName()) ' = '  char(child.item(ii).getTextContent())];
    m = m +1;
    %     sscanf(char(child.item(ii).getTextContent()),'%d')
end


% node = xmlDoc.getElementsByTagName('AF_Burden');
% child = node.item(0);
% report.RatioOfAF = sscanf(char(child.item(0).getTextContent()),'%d');
%
% node = xmlDoc.getElementsByTagName('VE_Isolated_Ratio');
% child = node.item(0);
% report.RatioOfPVC = sscanf(char(child.item(0).getTextContent()),'%d');
%
% node = xmlDoc.getElementsByTagName('Pause_nEps');
% child = node.item(0);
% report.EpisodesOfPause = sscanf(char(child.item(0).getTextContent()),'%d');

node = xmlDoc.getElementsByTagName('HeartRate');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'HR'))
        hr = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
report.hr = hr;
% figure;subplot(313);plot(hr);

node = xmlDoc.getElementsByTagName('AFIndex');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'Data'))
        AFEv = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
report.AFIndex = AFEv;
% ;subplot(311);plot(AFEv);


node = xmlDoc.getElementsByTagName('PVCIndex');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'Data'))
        PVCIndex = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
report.PVCIndex = PVCIndex;

node = xmlDoc.getElementsByTagName('PauseIndex');
PauseIndex = [];
try
    child = node.item(0);
    for ii = 1:child.getLength
        if(strcmp(char(child.item(ii).getNodeName),'Data'))
            PauseIndex = sscanf(char(child.item(ii).getTextContent()),'%2x');
            break;
        end
    end;
catch
end
report.PauseIndex = PauseIndex;
% ;subplot(312);plot(PVCIndex);
pos = [];
node = xmlDoc.getElementsByTagName('RegionOfInteresting');
child = node.item(0);
count = 1;
ecg = [];
for ii = 1:child.getLength-1
    if(strcmp(char(child.item(ii).getNodeName),'SegmentEcg'))
        c2 = child.item(ii).getChildNodes;
        for kk = 1: c2.getLength-1
            if(strcmp(char(c2.item(kk).getNodeName),'Time'))
                pos(count) = sscanf(char(c2.item(kk).getTextContent()),'%d');
            end
            if(strcmp(char(c2.item(kk).getNodeName),'Observation'))
                type{count} = char(c2.item(kk).getTextContent());
            end
            if(strcmp(char(c2.item(kk).getNodeName),'Data'))
                tmp = sscanf(char(c2.item(kk).getTextContent()),'%2x');
                
                ecg(:,count) = typecast(uint8(tmp),'int16');
                count = count+1;
            end
        end
    end
end;

% try

report.Event_AF  = [];
node = xmlDoc.getElementsByTagName('RhythmEvent');

child0 = node.item(0);
for jj = 1:child0.getLength-1
    if(strcmp(char(child0.item(jj).getNodeName),'BLOCK'))
        child = child0.item(jj);
        et = [];
        m = 1;
        for ii = 1:child.getLength-1
            if(strcmp(char(child.item(ii).getNodeName),'Type'))
                tp = char(child.item(ii).getTextContent());
            end
            if(strcmp(char(child.item(ii).getNodeName),'Abbreviate'))
                Abbr = char(child.item(ii).getTextContent());
            end
            if(strcmp(char(child.item(ii).getNodeName),'EVENT'))
                c2 = child.item(ii).getChildNodes;
                for kk = 1: c2.getLength-1
                    if(strcmp(char(c2.item(kk).getNodeName),'Time'))
                        pos(count) = sscanf(char(c2.item(kk).getTextContent()),'%d');
                    end
                    if(strcmp(char(c2.item(kk).getNodeName),'Duration'))
                        Duration= char(c2.item(kk).getTextContent());
                        dr = sscanf(char(c2.item(kk).getTextContent()),'%d')/10;
                    end
                end
                type{count} = [ tp Duration];
                et(m,1) = pos(count);
                et(m,2) = dr;
                m = m +1;
                count = count+1;
                
                
            end
        end
        if strcmp(Abbr,'AF')
            report.Event_AF = et;
        end
        
    end
end
% catch
% end
report.AnnWarning = [];
if ~isempty(pos)
report.ROIecg = ecg;
report.AnnWarning.pos = (pos)*250;
report.AnnWarning.descript = type;
end
%%
% figure;
% for ii = 1:count-1
% subplot(count,1,ii);plot(ecg(:,ii)); title(pos(ii));
% end;
% subplot(count,1,count) ; plot(data((pos(1))*250:(pos(1)+30)*250));
%
% disp([char(phone.item(1).getNodeName()) ':' char(phone.item(1).getTextContent())]);
% disp([char(phone.item(3).getNodeName()) ':' char(phone.item(3).getTextContent())]);
% disp([char(phone.item(5).getNodeName()) ':' char(phone.item(5).getTextContent())]);
% %%
% hr = sscanf(char(phone.item(5).getTextContent()),'%2x');
% figure;plot(hr);
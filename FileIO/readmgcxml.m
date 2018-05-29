%%

record = 'D:\\MGCDB\\mitdb250\\100';
matmgc('creat_xml',record);
matmgc('creat_xml',record);
matmgc('creat_xml',record);
xmlDoc = xmlread(['D:\\MGCDB\\mitdb250\\100' '.xml']);
[heasig,data]  = loadmagicdata(record);
clc

node = xmlDoc.getElementsByTagName('HeartRate');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'HR'))
        hr = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
figure;subplot(313);plot(hr);

node = xmlDoc.getElementsByTagName('AFIndex');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'Data'))
        AFEv = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
;subplot(311);plot(AFEv);


node = xmlDoc.getElementsByTagName('PVCIndex');
child = node.item(0);
for ii = 1:child.getLength
    if(strcmp(char(child.item(ii).getNodeName),'Data'))
        PVCIndex = sscanf(char(child.item(ii).getTextContent()),'%2x');
        break;
    end
end;
;subplot(312);plot(PVCIndex);

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
              if(strcmp(char(c2.item(kk).getNodeName),'Data'))
                    tmp = sscanf(char(c2.item(kk).getTextContent()),'%2x');
                    
                     ecg(:,count) = typecast(uint8(tmp),'int16');
                    count = count+1;
              end
         end        
     end
end;
%%
figure;
for ii = 1:count-1
subplot(count,1,ii);plot(ecg(:,ii)); title(pos(ii));
end;
subplot(count,1,count) ; plot(data((pos(1))*250:(pos(1)+30)*250));
% 
% disp([char(phone.item(1).getNodeName()) ':' char(phone.item(1).getTextContent())]);
% disp([char(phone.item(3).getNodeName()) ':' char(phone.item(3).getTextContent())]);
% disp([char(phone.item(5).getNodeName()) ':' char(phone.item(5).getTextContent())]);
% %%
% hr = sscanf(char(phone.item(5).getTextContent()),'%2x');
% figure;plot(hr);
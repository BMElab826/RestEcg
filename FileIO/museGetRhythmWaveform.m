


function [wave,adu,name,sr,ii]= museGetRhythmWaveform(str,idx0,idx1,istart)

ss = 0;
kk = 1;
for ii = istart:length(idx0)
    x = str(idx0(ii)+1:idx1(ii)-1);
    switch ss
        case 0
            if strcmp('WaveformType',x) && strcmp('Rhythm',str(idx1(ii)+1:idx0(ii+1)-1))
                ss = 1;
            end
        case 1
            if strcmp('SampleBase',x)
                sr = str2double((str(idx1(ii)+1:idx0(ii+1)-1)));
                ss = 2;
            end
        case 2
            if strcmp('/Waveform',x)
                break;
            end
            if strcmp('LeadData',x)               
                ss = 3;
            end
        case 3
            if strcmp('LeadAmplitudeUnitsPerBit',x)
                adu(kk) = str2double((str(idx1(ii)+1:idx0(ii+1)-1)));
                ss =4;
            end
        case 4
            if strcmp('LeadID',x)
                name{kk}  = (str(idx1(ii)+1:idx0(ii+1)-1));
                ss =5;
            end
        case 5            
            if strcmp('WaveFormData',x)
                x1 = (str(idx1(ii)+1:idx0(ii+1)-1));
                input = uint8(x1);
                wave(:,kk) = typecast(org.apache.commons.codec.binary.Base64.decodeBase64(input), 'int16')';
                kk = kk+1;
                ss = 2;
            end
            
            
    end

end


% 
% ss = 0;
% kk = 1;
% for ii = istart:length(idx0)
%     x = str(idx0(ii)+1:idx1(ii)-1);
%     switch ss
%         case 0
%             if strcmp('WaveformType',x) && strcmp('Rhythm',str(idx1(ii)+1:idx0(ii+1)-1))
%                 ss = 1;
%             end
%         case 1
%             if strcmp('/Waveform',x)
%                 break;
%             end
%             if strcmp('LeadData',x)
%                 ss = 2;
%             end
%         case 2
%             if strcmp('LeadID',x)
%                     name{kk}  = (str(idx1(ii)+1:idx0(ii+1)-1));
% %                 disp((str(idx1(ii)+1:idx0(ii+1)-1)));
%                 ss =3;
%             end
%         case 3
% 
%             if strcmp('WaveFormData',x)
%                 x1 = (str(idx1(ii)+1:idx0(ii+1)-1));
%                 input = uint8(x1);
%                 wave(:,kk) = typecast(org.apache.commons.codec.binary.Base64.decodeBase64(input), 'int16')';
%                 kk = kk+1;
%                 ss = 1;
%             end               
%     end  
% end
% 

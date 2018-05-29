% 查找有关与心肌梗死的描述，并记录
% 下一步，最好是能够统计每类各有多少例
clc;
clear all;
close all;

load('C:\Users\fanliang\Desktop\MuseDB_500Hz.mat')

fid = fopen('ST-T波异常.txt','w+');
fprintf(fid, 'ID :   diag        /// diag_orig\r\n');

num = 0;num_T=0; num_ST =0; num_STT = 0;
for ii = 1:length(DATA)
    diag = DATA(ii).diag;
    k = 1; diag_out={};
    for kk = 1:length(diag)
        if ~isempty(strfind(char(diag(kk)),'T')) || ~isempty(strfind(char(diag(kk)),'ST'))
            diag_out{k} = char(diag(kk));
            k = k+1;
        end
    end
    
    diag_orig = DATA(ii).diag_orig;
    m = 1; diag_orig_out = {};
    for mm = 1:length(diag_orig)
        if ~isempty(strfind(char(diag_orig(mm)), 'T')) && ~isempty(strfind(char(diag_orig(mm)), 'ST'))
            diag_orig_out{m} = char(diag_orig(mm));
            m = m+1;
        end
    end
    
    if ~isempty(diag_out) || ~isempty(diag_orig_out)
        num = num + 1;
        fprintf(fid, '%s : ', num2str(ii));
        if ~isempty(diag_out)
            for pp = 1:(k-1)
                fprintf(fid, '%s , ', char(diag_out(pp)));
                if strcmp(char(diag_out(pp)),'心电图不正常T')
                    num_T = num_T + 1;
                elseif strcmp(char(diag_out(pp)),'心电图不正常ST')
                    num_ST  = num_ST + 1;
                elseif strcmp(char(diag_out(pp)), '心电图不正常ST-T')
                    num_STT = num_STT +1;
                end
            end
        else
            fprintf(fid,'                 ');
        end
        if ~isempty(diag_orig_out)
            fprintf(fid, '/// ');
            for qq = 1:(m-1)
                fprintf(fid, '%s , ', char(diag_orig_out(qq)));
            end
            fprintf(fid,'\r\n');
        else
            fprintf(fid,'\r\n');
        end
    end
    
end
disp(num)
fclose(fid);

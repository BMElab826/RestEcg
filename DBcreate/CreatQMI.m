%%
% 2018.05.08
% 1.diag描述中筛选Q波异常
% 2.在以上条件下，在diag_orig中筛选心肌梗死
% 3、重写标签（格式:Q波异常，前/侧/下心肌梗死）

%%
clc
clear
data_path = 'E:\DataBase\180413ecg\data\Classify_f';
outpth = 'E:\DataBase\Q_MI0508';

typeQ = {'异常Q波'};
type = {'前壁心肌梗死','侧壁心肌梗死','前侧壁心肌梗死','前间隔心肌梗死','间壁心肌梗死','下壁心肌梗死','下后壁心肌梗死','急性心肌梗死'};
fid1 = fopen('diag异常Q波_diag_orig梗死单标签.csv','w+');
%%
sub_path = dir(data_path);
Q_path = {}; m=0;
for ii = 1:length(sub_path)
    if( isequal( sub_path(ii).name, '.' )||...
        isequal( sub_path(ii).name, '..')||...
        ~sub_path(ii).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile( data_path, sub_path(ii).name, '*.xml' );
    xml_file = dir( subdirpath ); 
    for jj = 1:length(xml_file)
        class_path = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
        [diag,diag_orig] = musereaddiag(class_path);
        % diag中出现异常Q波数据
        diag_str = [];
        for kk = 1:length(diag)
            diag_str = [diag_str  diag{kk}];
        end  
        diag_orig_str = [];
        for nn = 1:length(diag_orig)
            diag_orig_str = [diag_orig_str  diag_orig{nn}];
        end
        flag = 0;
        for hh = 1:length(type)
            if ~isempty(strfind(diag_str,'异常Q波')) && ~isempty(strfind(diag_orig_str,type{hh}))
                flag = flag+1;
                target = type{hh};
            end
        end
        if flag == 1
            fprintf(fid1,'%s,',class_path);
            fprintf(fid1,'%s,',target);
            fprintf(fid1,'\r\n');
            if ~exist(fullfile(outpth,target),'dir')
                mkdir(fullfile(outpth,target));
            end
            copyfile(class_path, fullfile(outpth,target));
            m = m+1;
            disp(m)
        end
    end        
end    
fclose(fid1);
Q_path = Q_path';
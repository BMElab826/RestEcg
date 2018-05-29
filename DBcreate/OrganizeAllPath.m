function classes_path = OrganizeAllPath(data_path)
% ��180413ecg/data/Classify_f�����е�xml·����������
    sub_path = dir(data_path);
    classes_path = {}; m=1;
    for ii = 1:length(sub_path)
        if( isequal( sub_path(ii).name, '.' )||...
            isequal( sub_path(ii).name, '..')||...
            ~sub_path(ii).isdir)               % �������Ŀ¼������
            continue;
        end
        subdirpath = fullfile( data_path, sub_path(ii).name, '*.xml' );
        xml_file = dir( subdirpath ); 
        for jj = 1:length(xml_file)
            class_path = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
            classes_path{m} = fullfile(data_path, sub_path(ii).name, xml_file(jj).name);
            [diag,diag_orig] = musereaddiag(class_path);
            diag_str = [];
            for kk = 1:length(diag)
                diag_str = [diag_str  diag{kk}];
            end  
            diag_orig_str = [];
            for nn = 1:length(diag_orig)
                diag_orig_str = [diag_orig_str  diag_orig{nn}];
            end
            if ~isempty(strfind(diag_str,type{jj}))
                
                
                
            m = m+1;
        end    
    end
    classes_path = classes_path';
end
function organizeQMI(path,outpth,type,classes_list)

if ~exist(outpth,'dir')
    mkdir(outpth);
end

for jj = 1: length(type)
    MI_path = [path '\' type{jj}];
    list = dir(fullfile(MI_path,'*.xml'));
    if ~exist(fullfile(outpth,classes_list{jj}),'dir')
        mkdir(fullfile(outpth,classes_list{jj}));
    end
    m = 0;
    for ii = 1: length(list)
        fname = fullfile(MI_path,list(ii).name);
        [diag,~] = musereaddiag(fname);
        diag_str = [];
        for kk = 1:length(diag)
            diag_str = [diag_str  diag{kk}];
        end  
        if ~isempty(strfind(diag_str,type{jj}))
            m=m+1;
        end
    end
    disp([MI_path '  ' num2str(m)])

end





function findxmltype(path,outpth,type)

if ~exist(outpth,'dir')
    mkdir(outpth);
end
list = dir(fullfile(path,'*.xml'));

for ii = 1: length(list)
    fname = fullfile(path,list(ii).name);
%     [diag,diag_orig] = musereaddiag(fname);
    [diag,~] = musereaddiag(fname);
    diag_str = [];
    for kk = 1:length(diag)
        diag_str = [diag_str  diag{kk}];
    end
%     for mm = 1:length(diag_orig)
%         diag_str = [diag_str diag_orig{mm}];
%     end
    
    for jj = 1: length(type)
        
        if ~exist(fullfile(outpth,type{jj}),'dir')
            mkdir(fullfile(outpth,type{jj}));
        end
        if ~isempty(strfind(diag_str,type(jj)))
            disp(type{jj});
            copyfile(fname,fullfile(outpth,type{jj}));
        end
%         if (~isempty(strfind(diag_str,key{jj,1}))) &&   (~isempty(strfind(diag_str,key{jj,2})))
%             disp(type{jj});
%             copyfile(fname,fullfile(outpth,type{jj}));
%         end
    end
    
end
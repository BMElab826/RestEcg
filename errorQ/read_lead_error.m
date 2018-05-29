%%
% date: 2018.05.17
% author: huangjiao 
% 功能：从异常Q波中解析出异常的导联情况
%       （1）从异常Q波中解析出异常的导联情况，并写入变量1，否者写入0
%       （2）diag中没有“异常Q波”的描述时，返回为空
%%
function leads_vector = read_lead_error(diag)
        leads_vector = zeros(1,12);
        leads = {'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'I',  'avL', 'II', 'avF', 'III','avR'};
        sQ = [];
        for kk = 1:length(diag)
            if ~isempty(strfind(diag{kk},'异常Q波')) || ~isempty(strfind(diag{kk},'异常q波')) || ~isempty(strfind(diag{kk},'QS'))
                sQ = [sQ diag{kk}];
            end   
        end
        
        if ~isempty(sQ)
            pattern = '\w{2,3}\-\w{2,3}'; % 匹配有“-”出现的导联描述
            match_str = regexpi(sQ, pattern, 'match');
            find_idx = [];
            for ii = 1:length(leads)
                if strcmp(leads{ii},'I') || strcmp(leads{ii},'II') || strcmp(leads{ii},'III')
                    tmp = ['[^I]' leads{ii} '[^I]'];
                else
                    tmp = leads{ii};
                end
                match_lead = regexpi(sQ, tmp, 'match');
        %         disp(match_lead)
                if ~isempty(match_lead)
                    leads_vector(ii) = 1;
        %             disp(leads_vector)
                end
                if ~isempty(match_str)
                    match_lead1 = regexpi(match_str{1}, tmp, 'match');
                    if ~isempty(match_lead1)
                        find_idx = [find_idx, ii];
                    end
                end
            end
            if ~isempty(find_idx) && length(find_idx)==2
                leads_vector(find_idx(1):find_idx(2)) = 1;
            end
%             disp(leads_vector)
        else
            sQ = '正常Q波';
            leads_vector = [];
        end
         
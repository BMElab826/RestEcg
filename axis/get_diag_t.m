function diag_t = get_diag_t(diag_Meas, diag_orig)
% input：
%      diag_Meas: muse DATA 中的diag
%      diag_orig: muse DATA 中的diag_orig
% output:
%      diag 和 diag_orig中，相关电轴的描述/诊断
    diag_t = '电轴正常';
    for kk = 1:length(diag_Meas)
        if strfind(char(diag_Meas(kk)),'电轴')
            diag_t = char(diag_Meas(kk));
%         elseif  ~isempty(strfind(char(diag_Meas(kk)),'右心室高电压'))...
%                 || ~isempty(strfind(char(diag_Meas(kk)),'右心室肥大')) ...
%                 || (~isempty(strfind(char(diag_Meas(kk)),'右')) && ~isempty(strfind(char(diag_Meas(kk)),'阻滞')))
%             diag_t = char(diag_Meas(kk));
%         elseif  ~isempty(strfind(char(diag_Meas(kk)),'左心室高电压'))...
%                 || ~isempty(strfind(char(diag_Meas(kk)),'左心室肥大')) ...
%                 || (~isempty(strfind(char(diag_Meas(kk)),'左')) && ~isempty(strfind(char(diag_Meas(kk)),'阻滞')))
%             diag_t = char(diag_Meas(kk));
        end
    end
    if strcmp(diag_t,'电轴正常')
        for jj = 1:length(diag_orig)
            if strfind(char(diag_orig(jj)),'电轴')
                diag_t = char(diag_orig(jj));
%             elseif  ~isempty(strfind(char(diag_orig(jj)),'右心室高电压'))...
%                     || ~isempty(strfind(char(diag_orig(jj)),'右心室肥大')) ...
%                     || (~isempty(strfind(char(diag_orig(jj)),'右')) && ~isempty(strfind(char(diag_orig(jj)),'阻滞')))
%                 diag_t = char(diag_orig(jj));
%             elseif  ~isempty(strfind(char(diag_orig(jj)),'左心室高电压'))...
%                     || ~isempty(strfind(char(diag_orig(jj)),'左心室肥大')) ...
%                     || (~isempty(strfind(char(diag_orig(jj)),'左')) && ~isempty(strfind(char(diag_orig(jj)),'阻滞')))
%                 diag_t = char(diag_orig(jj));
            end
        end
    end
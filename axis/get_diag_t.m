function diag_t = get_diag_t(diag_Meas, diag_orig)
% input��
%      diag_Meas: muse DATA �е�diag
%      diag_orig: muse DATA �е�diag_orig
% output:
%      diag �� diag_orig�У���ص��������/���
    diag_t = '��������';
    for kk = 1:length(diag_Meas)
        if strfind(char(diag_Meas(kk)),'����')
            diag_t = char(diag_Meas(kk));
%         elseif  ~isempty(strfind(char(diag_Meas(kk)),'�����Ҹߵ�ѹ'))...
%                 || ~isempty(strfind(char(diag_Meas(kk)),'�����ҷʴ�')) ...
%                 || (~isempty(strfind(char(diag_Meas(kk)),'��')) && ~isempty(strfind(char(diag_Meas(kk)),'����')))
%             diag_t = char(diag_Meas(kk));
%         elseif  ~isempty(strfind(char(diag_Meas(kk)),'�����Ҹߵ�ѹ'))...
%                 || ~isempty(strfind(char(diag_Meas(kk)),'�����ҷʴ�')) ...
%                 || (~isempty(strfind(char(diag_Meas(kk)),'��')) && ~isempty(strfind(char(diag_Meas(kk)),'����')))
%             diag_t = char(diag_Meas(kk));
        end
    end
    if strcmp(diag_t,'��������')
        for jj = 1:length(diag_orig)
            if strfind(char(diag_orig(jj)),'����')
                diag_t = char(diag_orig(jj));
%             elseif  ~isempty(strfind(char(diag_orig(jj)),'�����Ҹߵ�ѹ'))...
%                     || ~isempty(strfind(char(diag_orig(jj)),'�����ҷʴ�')) ...
%                     || (~isempty(strfind(char(diag_orig(jj)),'��')) && ~isempty(strfind(char(diag_orig(jj)),'����')))
%                 diag_t = char(diag_orig(jj));
%             elseif  ~isempty(strfind(char(diag_orig(jj)),'�����Ҹߵ�ѹ'))...
%                     || ~isempty(strfind(char(diag_orig(jj)),'�����ҷʴ�')) ...
%                     || (~isempty(strfind(char(diag_orig(jj)),'��')) && ~isempty(strfind(char(diag_orig(jj)),'����')))
%                 diag_t = char(diag_orig(jj));
            end
        end
    end
%%
% date: 2018.05.25
% author: huangjiao 
% ���ܣ�Ԥ�������Q�����쳣���
%       input: 12������QA��QD��RA
%       output: �������������쳣����������� 1���쳣�� 0������
function pre_leads_vector = predict_Q(QA, QD, RA)
pre_leads_vector = [];
flag = 1;
for ii = 1:length(QA)
    %% ����һ
    if RA(ii) == 0
        pre_leads_vector(ii) = 1;
    elseif QD(ii)>=30 && QA(ii)>=RA(ii)/4
        pre_leads_vector(ii) = 1;
    else
        pre_leads_vector(ii) = 0;
    end
    %% �����������������ж�
    while ii==11
        if QD(ii)>=40 && QA(ii)>=RA(ii)/4
            pre_leads_vector(ii) = 1;
        else
            pre_leads_vector(ii) = 0;
        end
        break
    end
    
    while ii==12 
        if QD(ii)>=60 && QA(ii)==0
            pre_leads_vector(ii) = 1; 
        else
            pre_leads_vector(ii) = 0;
        end
        break
    end
end
%% ������
% for ii = 1:length(QA)
%     switch flag
%         case ii == 1
%     end
% end
    

%%
%     if ii<=6 
%         if QD(ii)>=30 && QA(ii)>=RA(ii)/5
%             pre_leads_vector(ii) = 1;
%         else
%             pre_leads_vector(ii) = 0;
%         end
%     end
%     if ii>6 
%         if ii~=12 && QD(ii)>=30 && QA(ii)>=RA(ii)/5
%             pre_leads_vector(ii) = 1;
%         elseif ii==12 && QD(ii)>=60
%             pre_leads_vector(ii) = 1;
%         else
%             pre_leads_vector(ii) = 0;      
%         end
%     end
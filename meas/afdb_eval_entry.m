% ����̽���׼ȷ�����ۺ���
% ���룺 Label_ref  �ο��� 1 Ϊ������ 0Ϊ�Ƿ����� ��ÿ��Beat���б��
%        Label      ������Label��
% ���:
%        nTP     number of true positive
%        nTN     number of true  negtive
%        nFP     number of false positive
%        nFN     number of false negtive
% Historty
%        2017/11/15 add comment
% Author��  guangyubin@bjut.edu.cn
function [nTP,nTN,nFP,nFN ] = afdb_eval_entry(label_ref,label)

nTP = length(find(label_ref==1 & label==1));
nTN = length(find(label_ref==0 & label==0));
nFP = length(find(label_ref==0 & label==1));
nFN = length(find(label_ref==1 & label==0));


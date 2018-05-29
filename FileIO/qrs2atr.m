function qrs2atr(fout,qrs)
% 把qrs格式转化为mit ate格式


% record = 'D:\MGCDB\mitdb250\100';
% qrs = loadmgcqrs(fin);
% qrs = updataqrs(qrs);

% ann1 = matmgc('read_mit_annot',[record '.atr']);
n = length(qrs.time);
ann.time = double(qrs.time);
ann.anntyp = qrs.anntyp;
ann.subtyp = qrs.subtyp;
ann.chan = char(zeros(n,1));
ann.num = char(zeros(n,1));
ann.aux = char(zeros(n,2));
% writeannot([record '.ate1'],ann);
matmgc('write_mit_annot',fout,ann);
%  matmgc('mit_bxb','D:\MGCDB\mitdb250\','100','atr','ate','5:0')
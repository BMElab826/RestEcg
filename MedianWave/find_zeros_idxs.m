% 根据MUSE中的median wave中前后0值，分别从前往后、从后往前找到第一个不是0的索引

function [ileft,iright ]= find_zeros_idxs(x)
   ii = 1; 
   while x(ii) ==0
       ii = ii +1;
   end;
   ileft = ii;
   ii = length(x);
   while x(ii) ==0
       ii = ii - 1;
   end;
   iright = ii;
  
   
%        num = size(standard_median_wave,1);
%     nzero_idxs = find(standard_median_wave);
%     min_nzero_idxs = min(nzero_idxs);
%     max_nzero_idxs = max(nzero_idxs);
%     if min_nzero_idxs ~= 1
%         fidx = 1:min_nzero_idxs-1;
%     else
%         fidx = [];
%     end
%     if max_nzero_idxs ~= num
%         lidx = max_nzero_idxs+1:num ;
%     else lidx = [];
%     end
%         
%     idxs = [fidx, lidx];
%     
% end
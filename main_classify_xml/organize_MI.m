function organize_MI(path,outpth,type,classes_list)

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
%             disp(type{jj});
%             [wave,rpos,QRStype,wave_median,fs,label,Meas,Meas_Orig,diag,diag_orig,Meas_Matrix,adu]=musexmlread(fname);
%             if  Meas.ECGSampleBase==500&&...
%                     isfield(Meas,'PRInterval')&&isfield(Meas,'QTInterval')...
%                     &&isfield(Meas,'POffset')&&isfield(Meas,'POnset')
%                 a1 = Meas.PRInterval-2*( Meas.QOnset - Meas.POnset);
%                 a2 = Meas.QTInterval - 2*(  Meas.TOffset-Meas.QOnset);
%                 a3 =  Meas.QRSDuration - 2*(  Meas.QOffset-Meas.QOnset);
%                 if a1==0 && a2==0 && a3 == 0
%                     if fs==500
%                     m = m+1;
%                     name = [num2str((jj-1)) '_' num2str(fs) '_' num2str(m)];
%                     disp(fullfile(outpth, classes_list{jj}, name));
%                     save(fullfile(outpth, classes_list{jj}, name), 'wave_median')
%                     end
%                 end
%             end
%             copyfile(fname,fullfile(outpth,type{jj}));
        end
    end
    disp([MI_path '  ' num2str(m)])

end





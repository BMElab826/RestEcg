function varargout = ecgholterview(varargin)
% ECGHOLTERVIEW MATLAB code for ecgholterview.fig
%      ECGHOLTERVIEW, by itself, creates a new ECGHOLTERVIEW or raises the existing
%      singleton*.
%
%      H = ECGHOLTERVIEW returns the handle to a new ECGHOLTERVIEW or the handle to
%      the existing singleton*.
%
%      ECGHOLTERVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECGHOLTERVIEW.M with the given input arguments.
%
%      ECGHOLTERVIEW('Property','Value',...) creates a new ECGHOLTERVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ecgholterview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ecgholterview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ecgholterview

% Last Modified by GUIDE v2.5 23-Jan-2018 20:58:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ecgholterview_OpeningFcn, ...
    'gui_OutputFcn',  @ecgholterview_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% End initialization code - DO NOT EDIT


% --- Executes just before ecgholterview is made visible.
function ecgholterview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ecgholterview (see VARARGIN)

% Choose default command line output for ecgholterview
clc
handles.output = hObject;
axes(handles.axes1);
grid on
grid minor
set(gca,'GridColor',[1 0 0 ],'MinorGridColor',[0.8 0 0],'GridAlpha',0.8,'MinorGridAlpha',0.6);

drt = {'D:\MGCDB\MITAFDB','D:\MGCDB\mitdb250\','D:\MGCDB\flk'};
m = length(drt);
list = dir('D:\MGCDB\CAREB0');
for ii = 1:length(list)
    if list(ii).isdir==1 && isempty(strfind(list(ii).name,'.'))
        m = m +1;
        drt{m} = fullfile('D:\MGCDB\CAREB0',list(ii).name);
    end
end
 drt{m+1} = fullfile('E:\MagicSVN\binguangyu\trunk\testdata');

set(handles.listbox_database,'string', drt);
contents = cellstr(get(handles.listbox_database,'String'));
handles.filepath = contents{1};

set(handles.FileListBox,'string', listname(handles.filepath));

axes(handles.axes2);
[handles.line1] = plot(0,0);
handles.line2 = plot(0,0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ecgholterview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ecgholterview_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if isfield(handles,'EEG')
varargout{1} = handles.output;
varargout{2} = handles.ECG;
end


% --- Executes on selection change in AnnListBox.
function AnnListBox_Callback(hObject, eventdata, handles)
% hObject    handle to AnnListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns AnnListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AnnListBox
index = get(hObject,'Value');
if isfield(handles, 'ECG')
if ~isempty(handles.ECG.AnnWarning)
    if index <=length(handles.ECG.AnnWarning.pos)
        pos = floor(handles.ECG.AnnWarning.pos(index)/250)-5;
        Show_ECG_In_Pos(handles,double(pos),0);
    end
end
end
% --- Executes during object creation, after setting all properties.
function AnnListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnnListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% plot(handles.axes2,handles.AnnBeat.qrs(11,:));axis tight
% axes(handles.axes1);
if isfield(handles,'duration')
    pos = floor(get(hObject,'value'));
    Show_ECG_In_Pos(handles,pos,0);
end
% plot_ecg_chan1(handles.ecg1,handles.heasig.freq,handles.AnnBeat.pos,handles.AnnBeat.qrs(:,1),pos,10);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over FileListBox.
function FileListBox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fname = get(handles.FileListBox,'string');
fname = fullfile(handles.filepath,fname{get(hObject,'Value')});
if strfind(fname,'dat');
    fname = fname(1:end-4);
end;


choice = questdlg('重新进行QRS识别？', ...
	'计算', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
%         matmgc('file_analysis',fname,[fname '.qrs'],'mgc');
clear matmgc
        matmgc('creat_qrs',fname);
        matmgc('creat_xml',fname);
%         handles.ECG.AnnBeat = updata_qrs(fname);
        clear matmgc
        fname = get(handles.FileListBox,'string');
        Open_mgcFile(handles,fullfile(handles.filepath,fname{get(hObject,'Value')}));
%         disp('Yes');
    case 'No'
%         disp('No');
end


% disp('hello');
% --- Executes on selection change in FileListBox.
function FileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FileListBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FileListBox
fname = get(handles.FileListBox,'string');
Open_mgcFile(handles,fullfile(handles.filepath,fname{get(hObject,'Value')}));
% [handles.heasig,handles.ecg1,handles.AnnBeat,handles.AnnWarning] = loadmagicdata(fullfile(handles.filepath,fname{get(hObject,'Value')}));
% len =  floor(length(handles.ecg1)/handles.heasig.freq);
% handles.duration = len;
% set(handles.slider1,'min',0)
% set(handles.slider1,'max',len-1)
% set(handles.slider1,'value',floor(len/2))
% set(handles.slider1,'sliderstep',[1/len 10/len]);
% set(handles.AnnListBox,'string',' ');
% if ~isempty(handles.AnnWarning)
%     set(handles.AnnListBox,'string',handles.AnnWarning.descript);
% end
%  pos = floor(get(handles.slider1,'value'));
%  plot_ecg_chan1(handles.ecg1,handles.heasig.freq,handles.AnnBeat.pos,handles.AnnBeat.qrs(:,1),pos,10);
% guidata(handles.output,handles);

% --- Executes during object creation, after setting all properties.
function FileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [FileName,PathName] = uigetfile('*.dat','Select the ECG data file');
% [handles.heasig,handles.ecg1,handles.AnnBeat,handles.AnnWarning] = loadmagicdata(fullfile(PathName,FileName));
handles.filepath = uigetdir(handles.filepath);
set(handles.FileListBox,'string', listname(handles.filepath));
fname = get(handles.FileListBox,'string');
guidata(handles.output,handles);
fullfile(handles.filepath,fname{1})
Open_mgcFile(handles,fullfile(handles.filepath,fname{1}));
% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------

function name = listname(path)
list = dir([path '\*.dat']);
for ii = 1:length(list)
    name{ii} = list(ii).name;
end;

function Show_ECG_In_Pos(handles,pos,init)
if pos > handles.duration-1
    pos = handles.duration-1;
end;
if pos < 1
    pos = 1;
end;
set(handles.slider1,'value',pos );
axes(handles.axes1);
get(handles.axes1,'position');

rpos = handles.ECG.AnnBeat.time;

qpos =  repmat(double(handles.ECG.AnnBeat.time),[1 5])  +  double(handles.ECG.AnnBeat.qrs(:,[4 5 6 7 14]));
plot_ecg_chan1(handles.ECG.ecg1,handles.ECG.heasig.freq,handles.ECG.AnnBeat.time,handles.ECG.AnnBeat.anntyp,pos,15,0.95,'*r');hold on ; 



plot_ecg_chan1(handles.ECG.ecg1,handles.ECG.heasig.freq,handles.ECG.AnnBeat.time,handles.ECG.AnnBeat.subtyp,pos,15,0.75,'*r',qpos ,1);hold on ; 

morphType = handles.ECG.AnnBeat.qrs(:,[1]);
plot_ecg_chan1(handles.ECG.ecg1,handles.ECG.heasig.freq,handles.ECG.AnnBeat.time,morphType,pos,15,-0.9,'*r');hold on ; 
rythm =handles.ECG.AnnBeat.qrs(:,[3]);
plot_ecg_chan1(handles.ECG.ecg1,handles.ECG.heasig.freq,handles.ECG.AnnBeat.time,rythm,pos,15,-0.8,'*r');hold on ; 

if ~isempty(handles.ECG.AnnBeat2)
    plot_ecg_chan1(handles.ECG.ecg1,handles.ECG.heasig.freq,handles.ECG.AnnBeat2.time,handles.ECG.AnnBeat2.anntyp,pos,15,0.85,'ok');
end
hold off;


axes(handles.axes2);
%     if init ==1
% [handles.line1] = plot_heartrate(handles.ECG.hr);
np = length(handles.ECG.Report.hr);
t = (0:np-1)*10-10;
[handles.line1] = plot(t, handles.ECG.Report.hr);
hold on;

handles.line2 = plot(pos,handles.ECG.hr(min(pos,length(handles.ECG.hr))),'.r');
hold on;handles.line3 = plot(t, handles.ECG.Report.AFIndex);
handles.line4 = plot(t, handles.ECG.Report.PVCIndex,'.r');
if length(handles.ECG.Report.PauseIndex) > 1
     handles.line5 = plot(t, handles.ECG.Report.PauseIndex,'k');
end
legend('hr','AFIndex','PVCIndex','PauseIndex');
hold off;
%     end
set(handles.line2,'XData',[pos pos]);
set(handles.line2,'YData',[-10 200]);
set(handles.line2,'Color','r','LineStyle','-');
set(handles.axes2,'ButtonDownFcn',{@ButttonDownFcn,handles});
guidata(handles.output,handles);

axes(handles.axes6);
t = handles.ECG.AnnBeat.time / 250;
x = double(handles.ECG.AnnBeat.qrs(:,3));
x(handles.ECG.AnnBeat.qrs(:,3)==0) = Inf;
 plot(t, x,'.');;hold on;
handles.line62 = plot(pos,handles.ECG.hr(min(pos,length(handles.ECG.hr))),'.r');
set(handles.line62,'XData',[pos pos]);
set(handles.line62,'YData',[0 10]);
set(handles.line62,'Color','r','LineStyle','-');
set(handles.axes6,'ButtonDownFcn',{@ButttonDownFcn6,handles});
hold off;
guidata(handles.output,handles);



% 打开一个MGC文件
function Open_mgcFile(handles,fname)

[handles.ECG.heasig,handles.ECG.ecg1] = loadmgcdata(fname);
handles.ECG.AnnBeat = loadmgcqrs([fname(1:length(fname)-4) '.qrs']);

% handles.ECG.AnnBeat = qrs_reprocess(handles.ECG.AnnBeat);
handles.ECG.AnnBeat2 = loadAnn_mgc([fname(1:length(fname)-4) '.atr'],'mit');

handles.ECG.Report = loadmgcxml(fname(1:length(fname)-4));
if isempty(handles.ECG.Report)
    matmgc('creat_xml',fname(1:length(fname)-4));
    handles.ECG.Report = loadmgcxml(fname(1:length(fname)-4));
end;

% str = sprintf('RatioOfAF = %.4f%% \r\nRatioOfPVC = %.4f%%  \r\nEpisodesOfPause = %d ' ,  handles.ECG.Report.RatioOfAF , handles.ECG.Report.RatioOfPVC ,  handles.ECG.Report.EpisodesOfPause);
   set(handles.text3,'string',handles.ECG.Report.MeasureInfo);

handles.ECG.AnnWarning = handles.ECG.Report.AnnWarning;
len = length(handles.ECG.AnnWarning.pos);
m = 1;
if ~isempty(handles.ECG.AnnBeat2)
    for ii = 1:length(handles.ECG.AnnBeat2.time)
        if handles.ECG.AnnBeat2.anntyp(ii) == '+'
            handles.ECG.AnnWarning.pos(len+m) = handles.ECG.AnnBeat2.time(ii);
            handles.ECG.AnnWarning.descript{len+m} = handles.ECG.AnnBeat2.aux(ii,:);
            m = m +1;
        end
    end
end
    
if ~isempty(handles.ECG.heasig)
    len =  floor(length(handles.ECG.ecg1)/handles.ECG.heasig.freq);
    handles.duration = len;
    set(handles.slider1,'min',0)
    set(handles.slider1,'max',len-1)
    set(handles.slider1,'value',floor(len/2))
    set(handles.slider1,'sliderstep',[1/len 10/len]);
    set(handles.AnnListBox,'string','Listbox');
    set(handles.AnnListBox,'value',1);
    if~isempty(handles.ECG.AnnWarning)
        for ii = 1: length(handles.ECG.AnnWarning.descript)
            f{ii} = sprintf('%s' ,handles.ECG.AnnWarning.descript{ii} );   
        end
        set(handles.AnnListBox,'string',f);
    end
    

    pos = floor(get(handles.slider1,'value'));
    handles.ECG.hr = rpos2hr(handles.ECG.AnnBeat.time,handles.ECG.heasig.freq,1,10); 
%     handles.ECG.AFEv =  CoordTranRpos2sec(handles.ECG.AnnBeat.time,...
%         double(handles.ECG.AnnBeat.qrs(:,2)),handles.ECG.heasig.freq,1,10);
    
     handles.ECG.AFEv  =  handles.ECG.hr;
    Show_ECG_In_Pos(handles,pos,1);
  assignin('base','ECG',handles.ECG);% 
   assignin('base','record',fname);% 
    guidata(handles.output,handles);
    %     plot_ecg_chan1(handles.ecg1,handles.heasig.freq,handles.AnnBeat.time,handles.AnnBeat.qrs(:,1),pos,10);
end
guidata(handles.output,handles);


% 回调函数
function ButttonDownFcn(hObject, eventdata, handles)
pt = get(gca,'CurrentPoint');
pos = floor(pt(1,1));


Show_ECG_In_Pos(handles,pos,0);

function ButttonDownFcn6(hObject, eventdata, handles)
pt = get(gca,'CurrentPoint');
pos = floor(pt(1,1));

Show_ECG_In_Pos(handles,pos,0);

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% h = gcbo
% F=@slider1_Callback; %获取按钮2回调函数的句柄
% feval(F,handles.slider1, eventdata, handles);%执行按钮2的回调函数,参数为Hbt1, eventdata, handles
slider1_Callback(handles.slider1, eventdata, handles);
guidata(hObject,handles)
switch eventdata.Key
    case 'rightarrow'
        slider1_KeyPressFcn(handles.slider1, eventdata, handles)
    case 'leftarrow'
        slider1_KeyPressFcn(handles.slider1, eventdata, handles)
end




% --- Executes on key press with focus on slider1 and none of its controls.
function slider1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
switch eventdata.Key
    case 'rightarrow'
        pos = get(handles.slider1,'value' );
        pos = pos+1;
        if pos > get(handles.slider1,'Max' );
            pos = get(handles.slider1,'Max' );
        end
        set(handles.slider1,'value',pos );
        
    case 'leftarrow'
        pos = get(handles.slider1,'value' );
        pos = pos-1;
        if pos < get(handles.slider1,'Min' );
            pos = get(handles.slider1,'Min' );
        end
        set(handles.slider1,'value',pos );
        
        
end


% --- Executes on selection change in listbox_database.
function listbox_database_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_database contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_database
contents = cellstr(get(hObject,'String'));
handles.filepath = contents{get(hObject,'Value')};
set(handles.FileListBox,'string', listname(handles.filepath));
set(handles.FileListBox,'value',1);
fname = get(handles.FileListBox,'string');
guidata(handles.output,handles);
fullfile(handles.filepath,fname{1})
Open_mgcFile(handles,fullfile(handles.filepath,fname{1}));
guidata(handles.output,handles);

% --- Executes during object creation, after setting all properties.
function listbox_database_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_database (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)
slider1_Callback(handles.slider1, eventdata, handles);
guidata(hObject,handles)
pos = get(handles.slider1,'value' );
pos = pos+eventdata.VerticalScrollCount;
if pos > get(handles.slider1,'Max' );
    pos = get(handles.slider1,'Max' );
end
if pos < get(handles.slider1,'Min' );
    pos = get(handles.slider1,'Min' );
end
set(handles.slider1,'value',pos );


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

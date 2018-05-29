function varargout = restECG(varargin)
% RESTECG MATLAB code for restECG.fig
%      RESTECG, by itself, creates a new RESTECG or raises the existing
%      singleton*.
%
%      H = RESTECG returns the handle to a new RESTECG or the handle to
%      the existing singleton*.
%
%      RESTECG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESTECG.M with the given input arguments.
%
%      RESTECG('Property','Value',...) creates a new RESTECG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before restECG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to restECG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help restECG

% Last Modified by GUIDE v2.5 12-Mar-2018 15:03:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @restECG_OpeningFcn, ...
                   'gui_OutputFcn',  @restECG_OutputFcn, ...
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


% --- Executes just before restECG is made visible.
function restECG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to restECG (see VARARGIN)

% Choose default command line output for restECG
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes restECG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = restECG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

handles.datafromxml = 1;
if handles.datafromxml ==1
    
    handles.path = 'E:\DataBase\MUSE';
    set(handles.listbox1,'string', listname(handles.path ));
else
    a = load('E:\DataBase\museDB_500Hz.mat');
    handles.DATA = a.DATA;
    name = [];
    for ii = 1:length(handles.DATA)
        aa(ii) = sum(handles.DATA(ii).QRStype);
    end
    [a, index] = sort(aa);
    for ii = 1:length(index)
        name{ii} = num2str(index(ii));
        aa(ii) = sum(handles.DATA(ii).QRStype);
    end
    
    handles.DATA  = handles.DATA (index);
    set(handles.listbox1,'string', name);
    handles.index = 1;
end
guidata(hObject, handles);


function show_ecg(handles)

if handles.datafromxml ==1
   DATA = handles.Data;
    assignin('base','DATA',DATA);%
%      assignin('base','index',handles.index);%
else    
    DATA = handles.DATA(handles.index) ;
    assignin('base','DATA',DATA);%
    assignin('base','index',handles.index);%
end

ecg = DATA.wave_median*DATA.adu/1000;
fs = DATA.fs;
pqrst = [DATA.Meas.QOnset,DATA.Meas.QOffset,...
    DATA.Meas.POnset,DATA.Meas.POffset,DATA.Meas.TOffset] * DATA.fs/500;


% [data, qrs, qrs2, meanwave, pqrst2] = ProcRestEcg(DATA.wave,fs);
  [data, qrs, meanwave, pqrst2] = ProcRestEcg(DATA.wave,fs);

axes(handles.axes1);
get(handles.axes1,'position');

plot_restEcg(DATA.wave,DATA.fs,DATA.rpos,DATA.QRStype, -1  )

% hold on;plot_restEcg(data,250,qrs.time,qrs.anntyp,-2); 
hold on;plot_restEcg(data,250,qrs.time,qrs.qrs(1,:),-3); 
% hold on;plot_restEcg(data,250,qrs2.time,qrs2.anntyp,-4);
hold off;


% plot_restEcg(DATA.wave,DATA.fs,DATA.rpos*250/DATA.fs,DATA.QRStype, -1  )

axes(handles.axes3);
get(handles.axes3,'position');
plot_restMedianWave(ecg,fs, pqrst , 'k' );

axes(handles.axes4);
get(handles.axes4,'position');
% hold on;
plot_restMedianWave(meanwave,fs/2, pqrst2 , 'r' );


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

if handles.datafromxml ==1
    fname = get(handles.listbox1,'string');
    fname = fullfile(handles.path,fname{get(hObject,'Value')});
    [handles.Data.wave,handles.Data.rpos,handles.Data.QRStype,handles.Data.wave_median,handles.Data.fs,handles.Data.label,...
        handles.Data.Meas,...
        handles.Data.Meas_Orig,handles.Data.diag,handles.Data.diag_orig,handles.Data.Meas_Matrix,handles.Data.adu,handles.Data.PatientID]...
        = musexmlread(fname);
    
    handles.Data.wave = handles.Data.wave*handles.Data.adu/1000;
%     if handles.Data.fs== 250
        handles.Data.rpos = handles.Data.rpos*250/handles.Data.fs;
%     else
%          handles.Data.rpos = handles.Data.rpos/2;
%     end;
        
else
    handles.index = get(hObject,'Value');
end
show_ecg(handles)
guidata(hObject, handles);


%     assignin('base','DATA',handles.Data);%
%     assignin('base','fname',fname);%

function name = listname(path)
list = dir([path '\*.xml']);
for ii = 1:length(list)
    name{ii} = list(ii).name;
end;

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

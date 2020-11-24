function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 23-Nov-2020 09:05:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ImgRead.
%读入图片按钮
function ImgRead_Callback(hObject, eventdata, handles)
% hObject    handle to ImgRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Img;%定义全局变量Img作待处理的图片
%读入图片
[filename,pathname] = uigetfile('*.bmp','读取图片');
if isequal(filename,0)
    msgbox('没有图片')
else
    cla;
    pathfile=fullfile(pathname,filename);
    Img=imread(pathfile);%读入图片到全局变量
    
    %使用句柄将Img显示在axes1上，并设置图片的点击回调函数，将识别图片按钮变为可点击
    axes(handles.axes1);
    showImg=imshow(Img,[]);
    %set(showImg,'buttondownFcn',{@ImageClickCallBack,handles});
    set(handles.pushbutton4,'enable','on');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%set(imageHandle,'ButtonDowmFcn',@ImageClickCallBack);

%图片点击回调函数
function ImageClickCallBack(hObject,eventData,handles)
global faces;
global face_local;
point=get(gca,'CurrentPoint');%获取鼠标点击的坐标
hold on
index=mostClose(point,face_local);
axes(handles.axes4);
imshow(faces{index});
predictImg=rgb2gray(faces{index});
predictedLabel=predict(predictImg,index);
name=result(predictedLabel);
set(handles.Name,'string',name);

% --- Executes on button press in pushbutton4.
%识别图片按钮回调函数
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Img;
global faces;
global face_local;
axes(handles.axes1);
[img,result]=facedetetion(Img);
axes(handles.axes3);
cla;
[showImg,position]=show_newImage(img,result);
showImg=imshow(showImg);
for i=1:size(position,1)
    m1=position(i,1);
    m2=position(i,2);
    m3=position(i,3);
    m4=position(i,4);
    rectangle('Position',[m1,m2,m3,m4],'EdgeColor','r');
end
set(showImg,'buttondownFcn',{@ImageClickCallBack,handles});
[faces,face_local]=toRecognition(img,result);

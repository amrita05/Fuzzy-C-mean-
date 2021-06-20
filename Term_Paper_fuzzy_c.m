function varargout = Term_Paper_fuzzy_c(varargin)
% Term_Paper_fuzzy_c MATLAB code for Term_Paper_fuzzy_c.fig
%      Term_Paper_fuzzy_c, by itself, creates a new Term_Paper_fuzzy_c or raises the existing
%      singleton*.
%
%      H = Term_Paper_fuzzy_c returns the handle to a new Term_Paper_fuzzy_c or the handle to
%      the existing singleton*.
%
%      Term_Paper_fuzzy_c('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Term_Paper_fuzzy_c.M with the given input arguments.
%
%      Term_Paper_fuzzy_c('Property','Value',...) creates a new Term_Paper_fuzzy_c or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Term_Paper_fuzzy_c_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Term_Paper_fuzzy_c_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Term_Paper_fuzzy_c

% Last Modified by GUIDE v2.5 25-Apr-2021 16:28:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Term_Paper_fuzzy_c_OpeningFcn, ...
                   'gui_OutputFcn',  @Term_Paper_fuzzy_c_OutputFcn, ...
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


% --- Executes just before Term_Paper_fuzzy_c is made visible.
function Term_Paper_fuzzy_c_OpeningFcn(hObject, eventdata, handles, varargin)
clc;
cla reset;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Term_Paper_fuzzy_c (see VARARGIN)

% Choose default command line output for Term_Paper_fuzzy_c
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Term_Paper_fuzzy_c wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Term_Paper_fuzzy_c_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in upload_image.
function upload_image_Callback(hObject, eventdata, handles)
% hObject    handle to upload_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global imback
global path
[path,cancel]=imgetfile();
if cancel
    msgbox(sprintf('Error'),'Error')
    return
end
im=imread(path);
imback=imread(path);
%im=im2double(im);
axes(handles.axes1)
imshow(im)


% --- Executes on button press in fuzzy_c_mean.
function fuzzy_c_mean_Callback(hObject, eventdata, handles)
% hObject    handle to fuzzy_c_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

numclass = str2double(get(handles.edit1,'String'));

%function DemoFCM
% Segment a sample 2D image into 3 classes using fuzzy c-means algorithm. 
% Note that similar syntax would be used for c-means based segmentation,
% except there would be no fuzzy membership maps (denoted by variable U 
% below).
im = rgb2gray(im)
%im=imread('at3_1m4_01.tif'); % sample image
%numclass = 2
[C,U,LUT,H]=FastFCMeans(im,numclass); % perform segmentation
 
% Visualize the fuzzy membership functions
%figure('color','w')
%subplot(2,1,1)
I=double(min(im(:)):max(im(:)));
c={'-r' '-g' '-b'};
%for i=1:3
 %   plot(I(:),U(:,i),c{i},'LineWidth',2)
  %  if i==1, hold on; end
   % plot(C(i)*ones(1,2),[0 1],'--k')
%end
%xlabel('Intensity Value','FontSize',30)
%ylabel('Class Memberships','FontSize',30)
%set(gca,'XLim',[0 260],'FontSize',20)
 
%subplot(2,1,2)
%plot(I(:),LUT(:),'-k','LineWidth',2)
%xlabel('Intensity Value','FontSize',30)
%ylabel('Class Assignment','FontSize',30)
%set(gca,'XLim',[0 260],'Ylim',[0 3.1],'YTick',1:3,'FontSize',20)

% Visualize the segmentation
%figure('color','w')  
%subplot(1,2,1), imshow(im)
%set(get(gca,'Title'),'String','ORIGINAL')
 
L=LUT2label(im,LUT);
Lrgb=zeros([numel(L) 3],'uint8');
for i=1:3
    Lrgb(L(:)==i,i)=255;
end
Lrgb=reshape(Lrgb,[size(im) 3]);

%subplot(1,2,2), 
axes(handles.axes1);
%imshow(clusteredImage);
imshow(Lrgb,[])
set(get(gca,'Title'),'String','FUZZY C-MEANS')

% If necessary, you can also unpack the membership functions to produce 
% membership maps
%Umap=FM2map(im,U,H);
%figure('color','w')
%for i=1:3
 %   subplot(1,3,i), imshow(Umap(:,:,i))
  %  ttl=sprintf('Class %d membership map',i);
  %  set(get(gca,'Title'),'String',ttl)






function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Exit_button.
msgbox('Exiting completed')
pause(1)
close();
close();


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
imshow(im);
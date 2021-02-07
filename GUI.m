                        %---------------Auto Generated Code Starts here
function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 18-Aug-2017 18:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

                %----------------Auto Generated Code Ends here
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)  %
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
faceDetector = vision.CascadeObjectDetector();  %Create facedetector object

% Read a video frame and run the detector.
videoFileReader = imaq.VideoDevice('winvideo', 1);
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame);


% Draw the returned bounding box around the detected face.
videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
release(videoFileReader);
%crop thepart of image in bounding box
L=imcrop(videoOut,bbox);
%resize the image to 181-by-121 (obtained by trial and error) to maintain
%equality between all the images in the dataset
J=imresize(L,[181 121]);  
%transfer the handle to axes1
axes(handles.axes1)
%display the image in axes1
imshow(J);
%change directory to Traindatabase
TD=cd('./TrainDatabase');
TDP=strcat(TD,'/','TrainDatabase');
TF=dir(TDP);                %Creates a structure for the traindatabase directory
 i=(size(TF,1)-2)           %As the images are stored with the name as number.jpg, here we 
 %Get the number of last image added to the traindatabase folder
    imwrite(J,strcat(TDP,'/',int2str(i),'.jpg'));
    %change direcotry to the project folder
cd('E:\MPHIL_Redifined\All_new_gui_with Matlab_detector');   %Edit this path 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
faceDetector = vision.CascadeObjectDetector();

% Read a video frame and run the detector.
videoFileReader = imaq.VideoDevice('winvideo', 1);
videoFrame      = step(videoFileReader);
bbox            = step(faceDetector, videoFrame);


% Draw the returned bounding box around the detected face.
videoOut = insertObjectAnnotation(videoFrame,'rectangle',bbox,'Face');
release(videoFileReader);

M=imcrop(videoOut,bbox);
K=imresize(M,[181 121]);
axes(handles.axes2)
imshow(K);
imwrite(K,'test.jpg');
TrainDatabasePath = ('E:\MPHIL_Redifined\All_new_gui_with Matlab_detector\TrainDatabase');
TestDatabasePath = ('E:\MPHIL_Redifined\All_new_gui_with Matlab_detector');

%prompt = {'Enter test image name (a number between 1 to 10):'};
%dlg_title = 'Input of PCA-Based Face Recognition System';
%num_lines= 1;
%def = {'1'};

%TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(TestDatabasePath,'\','test.jpg')
im = imread(TestImage);


T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

%imshow(im)
%title('Test Image');
axes(handles.axes3)
imshow(SelectedImage);
%title('Equivalent Image');

str = strcat('Matched image is :  ',OutputName);
disp(str)

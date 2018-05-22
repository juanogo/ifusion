function varargout = Ifusion_Warning1_box(varargin)
% IFUSION_WARNING1_BOX M-file for Ifusion_Warning1_box.fig
%      IFUSION_WARNING1_BOX, by itself, creates a new IFUSION_WARNING1_BOX or raises the existing
%      singleton*.
%
%      H = IFUSION_WARNING1_BOX returns the handle to a new IFUSION_WARNING1_BOX or the handle to
%      the existing singleton*.
%
%      IFUSION_WARNING1_BOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IFUSION_WARNING1_BOX.M with the given input arguments.
%
%      IFUSION_WARNING1_BOX('Property','Value',...) creates a new IFUSION_WARNING1_BOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ifusion_Warning1_box_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ifusion_Warning1_box_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ifusion_Warning1_box

% Last Modified by GUIDE v2.5 20-Sep-2009 21:05:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ifusion_Warning1_box_OpeningFcn, ...
                   'gui_OutputFcn',  @Ifusion_Warning1_box_OutputFcn, ...
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


% --- Executes just before Ifusion_Warning1_box is made visible.
function Ifusion_Warning1_box_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ifusion_Warning1_box (see VARARGIN)

% Choose default command line output for Ifusion_Warning1_box
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ifusion_Warning1_box wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ifusion_Warning1_box_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1)



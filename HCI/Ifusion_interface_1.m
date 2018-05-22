% IFUSION MATLAB IMPLEMENTATION
% by Juan Diego Gomez PhD(Std)and Carlo Gatta PhD
% Medical Imaging Group
% Computer Vision Center CVC.
% Barcelona, Spain
% 2009
function varargout = Ifusion_interface_1(varargin)
% IFUSION_INTERFACE_1 M-file for Ifusion_interface_1.fig
%      IFUSION_INTERFACE_1, by itself, creates a new IFUSION_INTERFACE_1 or raises the existing
%      singleton*.
%
%      H = IFUSION_INTERFACE_1 returns the handle to a new IFUSION_INTERFACE_1 or the handle to
%      the existing singleton*.
%
%      IFUSION_INTERFACE_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IFUSION_INTERFACE_1.M with the given input arguments.
%
%      IFUSION_INTERFACE_1('Property','Value',...) creates a new IFUSION_INTERFACE_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ifusion_interface_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ifusion_interface_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ifusion_interface_1

% Last Modified by GUIDE v2.5 04-Dec-2009 10:17:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Ifusion_interface_1_OpeningFcn, ...
    'gui_OutputFcn',  @Ifusion_interface_1_OutputFcn, ...
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


% --- Executes just before Ifusion_interface_1 is made visible.
function Ifusion_interface_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ifusion_interface_1 (see VARARGIN)

% Choose default command line output for Ifusion_interface_1
Ifusion_Global

Focus_distance=740;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes Ifusion_CF_box wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ifusion_interface_1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ifusion_Global

%get the path and name of sequence BPB Lef
[FileName,PathName] = uigetfile('*.*','Select the sequence');
current_path=PathName;

if FileName==0
    %the user canceled the selection (continue without events)
else
    %request the CF distance by calling ifusion_CF_box
    info=dicominfo([PathName FileName]);
%     try
%         % C(1,1) = info.XrayTubeCurrent;
%         temp = info.XrayTubeCurrent;
%     catch
        temp=ifusion_CF_box;
%   end
    
    if size(temp,1)==0
        %the user canceled the selection (continue without events)
    else
        % read and save BPB_L and its CF
        f=waitbar(0.5,'Loading...');
        %BPB_L=dicomread([PathName FileName], 'frames', 1:10);
        BPB_L=dicomread([PathName FileName]);
        info=dicominfo([PathName FileName]);
        path1=info.Filename;
        R_points = extractEndDiastole(info);
        BPB_L=BPB_L(:,:,:,R_points);
        
        %
        % Contrast enhancment of all frames base on imadjust
        %
        for f_n=1:size(BPB_L,4)
            BPB_L(:,:,1,f_n) = imadjust(squeeze(BPB_L(:,:,1,f_n)));
        end
        
        [ll kk cc] = angles2refsys(-deg2rad(info.PositionerPrimaryAngle),deg2rad(info.PositionerSecondaryAngle));
        l(1,:)=ll;k(1,:)=kk;c(1,:)=cc;
        C(1,1)=temp-Focus_distance;
        F(1,1)=Focus_distance;
        CF_1=200;
        waitbar(1)
        close(f)
        %show one frame of the selected sequence
        axes(handles.axes1)
        imshow(BPB_L(:,:,1,1))
    end
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ifusion_Global

%get the path and name of sequence BPB Right
[FileName,PathName] = uigetfile([current_path '*.*'],'Select the sequence');
current_path=PathName;

if FileName==0
    %the user canceled the selection (continue without events)
else
    
    %temp=ifusion_CF_box;
        info=dicominfo([PathName FileName]);
%         try
%         % C(1,1) = info.XrayTubeCurrent;
%         temp = info.XrayTubeCurrent;
%     catch
        %request the CF distance by calling ifusion_CF_box
        temp=ifusion_CF_box;
%    end
    
    if size(temp,1)==0
        %the user canceled the selection (continue without events)
    else
        % read and save BPB_L and its CF
        f=waitbar(0.5,'Loading...');
        %APB_R=dicomread([PathName FileName], 'frames', 1:10);
        BPB_R=dicomread([PathName FileName]);
        info=dicominfo([PathName FileName]);
        path3=info.Filename;
        R_points = extractEndDiastole(info);
        BPB_R=BPB_R(:,:,:,R_points);
        
        for f_n=1:size(BPB_R,4)
            BPB_R(:,:,1,f_n) = imadjust(squeeze(BPB_R(:,:,1,f_n)));
        end
        
        [ll kk cc] = angles2refsys(-deg2rad(info.PositionerPrimaryAngle),deg2rad(info.PositionerSecondaryAngle));
        l(2,:)=ll;k(2,:)=kk;c(2,:)=cc;
        
        C(1,2)=temp-Focus_distance;
        F(1,2)=Focus_distance;
        CF_3=200;
        waitbar(1)
        close(f)
        %show one frame of the selected sequence
        axes(handles.axes2)
        imshow(BPB_R(:,:,1,1))
    end
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ifusion_Global

%get the path and name of sequence BPB Right
[FileName,PathName] = uigetfile([current_path '*.*'],'Select the sequence');
current_path=PathName;

if FileName==0
    %the user canceled the selection (continue without events)
else
    %request the CF distance by calling ifusion_CF_box

        % read and save BPB_L and its CF
        f=waitbar(0.5,'Loading...');
        %BPB_R=dicomread([PathName FileName], 'frames', 1:10);
        APB_R=dicomread([PathName FileName]);
        info=dicominfo([PathName FileName]);
        path2=info.Filename;
        R_points = extractEndDiastole(info);
        APB_R=APB_R(:,:,:,R_points);
        
        for f_n=1:size(APB_R,4)
            APB_R(:,:,1,f_n) = imadjust(squeeze(APB_R(:,:,1,f_n)));
        end
        
        CF_2=200;
        waitbar(1)
        close(f)
        %show one frame of the selected sequence
        axes(handles.axes3)
        imshow(APB_R(:,:,1,1))
  
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ifusion_Global

%get the path and name of sequence APB Right
[FileName,PathName] = uigetfile([current_path '*.*'],'Select the sequence');
current_path=PathName;

if FileName==0
    %the user canceled the selection (continue without events)
else
    %request the CF distance by calling ifusion_CF_box

        % read and save BPB_L and its CF
        f=waitbar(0.5,'Loading...');
        %APB_L=dicomread([PathName FileName], 'frames', 1:10);
        APB_L=dicomread([PathName FileName]);
        info=dicominfo([PathName FileName]);
        path4=info.Filename;
        R_points = extractEndDiastole(info);
        APB_L=APB_L(:,:,:,R_points);
        
        for f_n=1:size(APB_L,4)
            APB_L(:,:,1,f_n) = imadjust(squeeze(APB_L(:,:,1,f_n)));
        end
        
        CF_4=200;
        waitbar(1)
        close(f)
        %show one frame of the selected sequence
        axes(handles.axes4)
        imshow(APB_L(:,:,1,1))
   
end



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ifusion_Global

%get the path and name of sequence APB Right
[FileName,PathName] = uigetfile([current_path '*.*'],'Select the sequence');
current_path=PathName;

if FileName==0
    %the user canceled the selection (continue without events)
else
    %request the CF distance by calling ifusion_CF_box
    temp=ifusion_CF_box;
    %   end
    
    if size(temp,1)==0
        %the user canceled the selection (continue without events)
    else
        % read and save BPB_L and its CF
        f=waitbar(0.5,'Loading...');
        %APB_L=dicomread([PathName FileName], 'frames', 1:10);
        CORO=dicomread([PathName FileName]);
        info=dicominfo([PathName FileName]);
        path5=info.Filename;
%         R_points = extractEndDiastole(info);
%         CORO=CORO(:,:,:,R_points);
        
        for f_n=1:size(CORO,4)
            CORO(:,:,1,f_n) = imadjust(squeeze(CORO(:,:,1,f_n)));
        end
        
        [ll kk cc] = angles2refsys(-deg2rad(info.PositionerPrimaryAngle),deg2rad(info.PositionerSecondaryAngle));
        l(3,:)=ll;k(3,:)=kk;c(3,:)=cc;
        
        C(1,3)=temp-Focus_distance;
        F(1,3)=Focus_distance;
        
        waitbar(1)
        close(f)
        %show one frame of the selected sequence
        axes(handles.axes5)
        imshow(CORO(:,:,1,1))
    end
    
end


% --- Executes on button press in pushbutton6. (oK button)
function pushbutton6_Callback(hObject, eventdata, handles)
Ifusion_Global
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (size(CF_1,1)==0 ||size(CF_2,1)==0 ||size(CF_3,1)==0 ||size(CF_4,1)==0)
    %Some sequences are missing to continue
    Ifusion_Warning1_box
else
    try
        CORO(1,1,1,1)
    catch
        CORO=BPB_L;
        l(3,:)=l(1,:);k(3,:)=k(1,:);c(3,:)=c(1,:);
        C(1,3)=C(1,1);
        F(1,3)=F(1,1);
        path5=path1;
        
    end
    %Is the user sure to continue?
    temp=Ifusion_Continue_box;
    if temp(1)=='N'
        %No sure. Stay
    else
        handles.output = 'closed';

        % Update handles structure
        guidata(hObject, handles);

        % Use UIRESUME instead of delete because the OutputFcn needs
        % to get the updated handles structure.
        uiresume(handles.figure1);

    end
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
Ifusion_Global
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Patient_case,PathName] = uigetfile('*.mat*','Select the case');
current_path=PathName;
Patient_case=[current_path Patient_case];
load(Patient_case)

info=dicominfo(path1);
R_points = extractEndDiastole(info);
BPB_L=dicomread(path1,'frames',R_points);
for f_n=1:size(BPB_L,4)
    BPB_L(:,:,1,f_n) = imadjust(squeeze(BPB_L(:,:,1,f_n)));
end
        
info=dicominfo(path2);
R_points = extractEndDiastole(info);
BPB_R=dicomread(path2,'frames',R_points);
for f_n=1:size(BPB_R,4)
    BPB_R(:,:,1,f_n) = imadjust(squeeze(BPB_R(:,:,1,f_n)));
end

info=dicominfo(path3);
R_points = extractEndDiastole(info);
APB_R=dicomread(path3,'frames',R_points);
for f_n=1:size(APB_R,4)
    APB_R(:,:,1,f_n) = imadjust(squeeze(APB_R(:,:,1,f_n)));
end

info=dicominfo(path4);
R_points = extractEndDiastole(info);
APB_L=dicomread(path4,'frames',R_points);
for f_n=1:size(APB_L,4)
    APB_L(:,:,1,f_n) = imadjust(squeeze(APB_L(:,:,1,f_n)));
end

try
    info=dicominfo(path5);
    R_points = extractEndDiastole(info);
    CORO=dicomread(path4,'frames',R_points);
    for f_n=1:size(APB_L,4)
        CORO(:,:,1,f_n) = imadjust(squeeze(CORO(:,:,1,f_n)));
    end
catch
    CORO=BPB_L;
    l(3,:)=l(1,:);k(3,:)=k(1,:);c(3,:)=c(1,:);
    C(1,3)=C(1,1);
    F(1,3)=F(1,1);
    path5=path1;
end

Curves{1}.coor=Coor1;
Curves{1}.pointer=[];
Curves{1}.control_pts={};
Curves{2}.coor=Coor2;
Curves{2}.pointer=[];
Curves{2}.control_pts={};

handles.output = 'closed';

        % Update handles structure
        guidata(hObject, handles);

        % Use UIRESUME instead of delete because the OutputFcn needs
        % to get the updated handles structure.
        uiresume(handles.figure1);




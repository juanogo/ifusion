% IFUSION MATLAB IMPLEMENTATION
% by Juan Diego Gomez PhD(Std)and Carlo Gatta PhD
% Medical Imaging Group
% Computer Vision Center CVC.
% Barcelona, Spain
% 2009
function varargout = Ifusion_interface_2(varargin)
% IFUSION_INTERFACE_2 M-file for Ifusion_interface_2.fig
%      IFUSION_INTERFACE_2, by itself, creates a new IFUSION_INTERFACE_2 or raises the existing
%      singleton*.
%
%      H = IFUSION_INTERFACE_2 returns the handle to a new IFUSION_INTERFACE_2 or the handle to
%      the existing singleton*.
%
%      IFUSION_INTERFACE_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IFUSION_INTERFACE_2.M with the given input arguments.
%
%      IFUSION_INTERFACE_2('Property','Value',...) creates a new IFUSION_INTERFACE_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ifusion_interface_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ifusion_interface_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ifusion_interface_2

% Last Modified by GUIDE v2.5 04-Dec-2009 10:21:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Ifusion_interface_2_OpeningFcn, ...
    'gui_OutputFcn',  @Ifusion_interface_2_OutputFcn, ...
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


% --- Executes just before Ifusion_interface_2 is made visible.
function Ifusion_interface_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ifusion_interface_2 (see VARARGIN)

% % % %
% % % % Initialize all the necessary variables.
% % % %

Ifusion_Global

set(handles.axes1,'NextPlot','add')
set(handles.axes2,'NextPlot','add')
set(handles.axes1,'ButtonDownFcn',{@click_on_axes,handles,1} )
set(handles.axes2,'ButtonDownFcn',{@click_on_axes,handles,2} )

set(handles.radiobutton1,'Value',1)
set(handles.radiobutton2,'Value',1)
set(handles.pushbutton4,'Enable','off');
try
    Curves{1}.coor(1,1); % check if there is an old case uploaded
    set(handles.pushbutton16,'Enable','on');
catch
end

TipSlide_R=[];
TipSlide_L=[];

Curves{1}.coor=[];
Curves{2}.coor=[];

ExtCandRight=[];
ExtCandLeft=[];

TipCandRight=[];
TipCandLeft=[];

Curves{1}.pointer=[];
Curves{2}.pointer=[];

Curves{1}.control_pts={};

Epi=[];

% Choose default command line output for Ifusion_interface_2

% Update handles structure
guidata(hObject, handles);

% Turn all the axes on BPB mode as initial visualization
pushbutton5_Callback(hObject, eventdata, handles)

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes Ifusion_CF_box wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ifusion_interface_2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Manage the 'left' slider and the visualization of the relevant
% % % % data.
% % % %

Ifusion_Global

set(handles.radiobutton1,'Value',0)
set(handles.text3,'String', ['Slide: ' num2str(round(get(hObject,'Value')))])
axes(handles.axes1)
try
    posExt=Ext_L.getPosition();delete(Ext_L)
catch
end
try
    posTip=Tip_L.getPosition();delete(Tip_L)
catch
end
hold on
im_s=imshow(uint8(handles.LEFT(:,:,round(get(hObject,'Value')))));
set(im_s,'HitTest','off')
Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);
try
    Ext_L=impoint(handles.axes1,posExt);
catch
end

try
    Tip_L=impoint(handles.axes1,posTip);
catch
end

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Manage the radio button that activate/deactivate the
% % % % 'minimum of all frames' functionality.
% % % %

Ifusion_Global

status=get(hObject,'Value');

%
% Try to read 'left' extrema
%
try
    posExt = Ext_L.getPosition();delete(Ext_L)
catch
end

%
% Try to read 'left' tip
%
try
    posTip = Tip_L.getPosition();delete(Tip_L)
catch
end

if status
    axes(handles.axes1)
    hold on
    
    %
    % Compute the minimum over all the frames in the left image.
    %
    im_s = imshow(uint8(min(handles.LEFT,[],3)));
    set(im_s,'HitTest','off')
    
    %
    % Update the visualization
    %
    Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);
else
    %
    % Refresh the slider bar and show the current image
    %
    set(handles.text3,'String', ['Slide: ' num2str(round(get(handles.slider1,'Value')))])
    
    axes(handles.axes1)
    hold on
    
    im_s = imshow(uint8(handles.LEFT(:,:,round(get(handles.slider1,'Value')))));
    set(im_s,'HitTest','off')
    
    %
    % Update the visualization
    %
    Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);
end

%
% Try to set 'left' extrema
%
try
    Ext_L = impoint(handles.axes1,posExt);
catch
end

%
% Try to set 'left' tip
%
try
    Tip_L = impoint(handles.axes1,posTip);
catch
end

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Manage the 'right' slider and the visualization of relevant
% % % % data.
% % % %

Ifusion_Global

set(handles.radiobutton2,'Value',0)
set(handles.text4,'String', ['Slide: ' num2str(round(get(hObject,'Value')))])
axes(handles.axes2)

try
    posExt=Ext_R.getPosition();delete(Ext_R)
catch
end

try
    posTip=Tip_R.getPosition();delete(Tip_R)
catch
end

hold on
im_s = imshow(uint8(handles.RIGHT(:,:,round(get(hObject,'Value')))));
set(im_s,'HitTest','off')

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes2);

try
    Tip_R = impoint(handles.axes2,posTip);
catch
end

try
    Ext_R = impoint(handles.axes2,posExt);
catch
end

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Manage the radio button that activate/deactivate the
% % % % 'minimum of all frames' functionality.
% % % %

Ifusion_Global

status = get(hObject,'Value');

try
    posExt=Ext_R.getPosition();delete(Ext_R)
catch
end

try
    posTip=Tip_R.getPosition();delete(Tip_R)
catch
end

if status
    axes(handles.axes2)
    hold on

    im_s = imshow(uint8(min(handles.RIGHT,[],3)));
    
    set(im_s,'HitTest','off')
    Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes2);
else
    %
    % Refresh the slider bar and show the current image
    %
    set(handles.text4,'String', ['Slide: ' num2str(round(get(handles.slider2,'Value')))])
    axes(handles.axes2)
    hold on
    
    im_s = imshow(uint8(handles.RIGHT(:,:,round(get(handles.slider2,'Value')))));
    
    set(im_s,'HitTest','off')
    Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes2);
end

try
    Tip_R = impoint(handles.axes2,posTip);
catch
end

try
    Ext_R = impoint(handles.axes2,posExt);
catch
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % When the user press the button 'Trace Path', this function 
% % % % prepares the data, and call the function 'catetherPathFast.m'.
% % % %

Ifusion_Global

%
% Check if all the 'tip' and 'extrema' points are defined.
%

ready = 1;

try
    Tip_R.getPosition();
    Tip_L.getPosition();
    Ext_R.getPosition();
    Ext_L.getPosition();
catch
    ready = 0;
end

if ready
    %
    % If the 'tip' and 'extrema' points are defined.
    %
    
    %
    % Read all the points 2D position.
    %
    tipR = Tip_R.getPosition();
    tipL = Tip_L.getPosition();

    extR = Ext_R.getPosition();
    extL = Ext_L.getPosition();
    
    delete(Tip_R);
    delete(Tip_L);
    
    delete(Ext_R);
    delete(Ext_L);
    
    Ifusion_Trace_Curves (handles.axes1, handles.axes2,handles.axes1, 1, 2, tipL(1),tipL(2));
    Ifusion_Trace_Curves (handles.axes1, handles.axes2,handles.axes2, 2, 2, tipR(1),tipR(2));
    Ifusion_Trace_Curves (handles.axes1, handles.axes2,handles.axes1, 1, 1, extL(1),extL(2));
    Ifusion_Trace_Curves (handles.axes1, handles.axes2,handles.axes2, 2, 1, extR(1),extR(2));
    
    Curves{1}.coor = round(Curves{1}.coor);

    im = im2double( squeeze(BPB_L(:,:,1,TipSlide_L)) );

    %
    % Call the function that finds the path from the 'tip' to the 'extrema'
    %
    [x y] = catetherPathFast(im,[Curves{1}.coor(1,1)  Curves{1}.coor(2,1)],[Curves{1}.coor(1,2) Curves{1}.coor(2,2)]);
    
    %
    % Save the resulting path in the Curves cell structure
    %
    Curves{1}.coor      = [];
    Curves{1}.coor(:,1) = x;
    Curves{1}.coor(:,2) = y;
    
    %
    % Do the same as before for the 'right' image
    %
    Curves{2}.coor = round(Curves{2}.coor);
    
    im = im2double( squeeze(BPB_R(:,:,1,TipSlide_R)) );
    
    [x y] = catetherPathFast(im,[Curves{2}.coor(1,1)  Curves{2}.coor(2,1)],[Curves{2}.coor(1,2) Curves{2}.coor(2,2)]);
    
    Curves{2}.coor      = [];
    Curves{2}.coor(:,1) = x;
    Curves{2}.coor(:,2) = y;
    
    %
    % Update the visualization
    %
    axes(handles.axes1)
    hold on
    
    im_s = imshow(im2double( squeeze(BPB_L(:,:,1,TipSlide_L)) ));
    
    set(handles.slider1,'Value',TipSlide_L);
    set(handles.text3,'String', ['Slide: ' num2str(TipSlide_L)]);
    set(im_s,'HitTest','off')
    
    axes(handles.axes2)
    hold on
    
    im_s = imshow(im2double( squeeze(BPB_R(:,:,1,TipSlide_R)) ));
    
    set(handles.slider2,'Value',TipSlide_R)
    set(handles.text4,'String', ['Slide: ' num2str(TipSlide_R)])
    set(im_s,'HitTest','off')
    
    set(handles.pushbutton7,'Enable','off')
    set(handles.pushbutton8,'Enable','off')
    set(handles.pushbutton11,'Enable','off')
    set(handles.pushbutton12,'Enable','off')
    set(handles.pushbutton3,'Enable','off')
    
    Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);
    
    Ifusion_Control_Points(handles.axes1,handles.axes2)   
else
    display('Some points are missing');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Load the IVUS pullback data.
% % % %

Ifusion_Global



handles.output = 'closed';

%
% Update handles structure
%
guidata(hObject, handles);

%
% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
%
uiresume(handles.figure1);



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Visualize 'Before Pullback' angiographies in both 'left' and
% % % % 'right' images.
% % % %

Ifusion_Global

try
    posExtL = Ext_L.getPosition();
    delete(Ext_L)
catch
end

try
    posTipL = Tip_L.getPosition();
    delete(Tip_L)
catch
end

try
    posExtR = Ext_R.getPosition();
    delete(Ext_R)
catch
end

try
    posTipR = Tip_R.getPosition();
    delete(Tip_R)
catch
end

handles.LEFT  = squeeze(BPB_L(:,:,1,:));
handles.RIGHT = squeeze(BPB_R(:,:,1,:));

axes(handles.axes1)
hold on

im_s = imshow(uint8(min(handles.LEFT,[],3)));
set(im_s,'HitTest','off')

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);

axes(handles.axes2)
hold on

im_s = imshow(uint8(min(handles.RIGHT,[],3)));
set(im_s,'HitTest','off')

set(handles.radiobutton1,'Value',1)

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes2);

set(handles.slider1,'Value',1)
set(handles.slider2,'Value',1)
set(handles.slider1,'Max',size(BPB_L,4))
set(handles.slider2,'Max',size(BPB_R,4))
set(handles.slider1,'Min',1)
set(handles.slider2,'Min',1)
set(handles.slider1,'SliderStep',[1/get(handles.slider1,'Max') 0.4])
set(handles.slider2,'SliderStep',[1/get(handles.slider2,'Max') 0.4])

set(handles.text3,'String','Slide: 1')
set(handles.text4,'String','Slide: 1')
guidata(hObject, handles);

try
    Tip_R = impoint(handles.axes2,posTipR);
catch
end

try 
    Ext_R = impoint(handles.axes2,posExtR);
catch
end

try
    Ext_L=impoint(handles.axes1,posExtL);
catch
end

try
    Tip_L=impoint(handles.axes1,posTipL);
catch
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Visualize 'After Pullback' angiographies in both 'left' and
% % % % 'right' images.
% % % %

Ifusion_Global

try
    posExtL = Ext_L.getPosition();
    delete(Ext_L)
catch
end

try
    posTipL = Tip_L.getPosition();
    delete(Tip_L)
catch
end

try
    posExtR = Ext_R.getPosition();
    delete(Ext_R)
catch
end

try
    posTipR = Tip_R.getPosition();
    delete(Tip_R)
catch
end

handles.LEFT  = squeeze(APB_L(:,:,1,:));
handles.RIGHT = squeeze(APB_R(:,:,1,:));
axes(handles.axes1)
hold on

im_s = imshow(uint8(min(handles.LEFT,[],3)));

set(im_s,'HitTest','off')

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);

axes(handles.axes2)
hold on

im_s = imshow(uint8(min(handles.RIGHT,[],3)));

set(im_s,'HitTest','off')
set(handles.radiobutton2,'Value',1)

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes2);

set(handles.slider1,'Value',1)
set(handles.slider2,'Value',1)
set(handles.slider1,'Max',size(APB_L,4))
set(handles.slider2,'Max',size(APB_R,4))
set(handles.slider1,'Min',1)
set(handles.slider2,'Min',1)
set(handles.slider1,'SliderStep',[1/get(handles.slider1,'Max') 0.4])
set(handles.slider2,'SliderStep',[1/get(handles.slider2,'Max') 0.4])

set(handles.text3,'String','Slide: 1')
set(handles.text4,'String','Slide: 1')
guidata(hObject, handles);

try
    Tip_R = impoint(handles.axes2,posTipR);
catch
end

try
    Ext_R = impoint(handles.axes2,posExtR);
catch
end

try  
    Ext_L = impoint(handles.axes1,posExtL);
catch
end

try
    Tip_L = impoint(handles.axes1,posTipL);
catch
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % This function manages the selection of an area of Before Pullback
% % % % ('left'). The selected area, in all the frames is analyzed to find the
% % % % tip candidates. To this aim this code calls the function
% % % % 'detectCatheterTipMultipleFrames'.
% % % %

Ifusion_Global

rect = round(getrect(handles.axes1));

%
% The candidate tips must be selected from the Before Pullback sequences.
%
I = im2double (squeeze(BPB_L(:,:,1,:)) );

for u=1:size(BPB_L,4)
    %
    % The images can be preprocessed by uncommenting the following line.
    %
    
    %im_out(:,:,u) = imageEnhancment(I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
    im_out(:,:,u) = (I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
end

%
% Remove part of the image in case it has been preprocessed, since there is
% a border effect using the function 'imageEnhancment'.
%
im_out = im_out(14:end-13,14:end-13,:);

I = im2double( min(squeeze(BPB_L(:,:,1,:)),[],3  ));

I(rect(2):rect(2)+size(im_out,1)-1,rect(1):rect(1)+size(im_out,2)-1) = min(im_out,[],3);

XY = detectCatheterTipMultipleFrames(im_out);

X = XY(:,1);
Y = XY(:,2);

axes(handles.axes1)
try
    posExt = Ext_L.getPosition();
    delete(Ext_L)
catch
end

try
    posTip = Tip_L.getPosition();
    delete(Tip_L)
catch
end

hold on
im_s = imshow(I);
set(im_s,'HitTest','off')
scatter(rect(1)+Y,rect(2)+X,'xy');

try  
    Ext_L = impoint(handles.axes1,posExt);
catch
end

try 
    Tip_L = impoint(handles.axes1,posTip);
catch
end

TipCandLeft = [];

%user click on a different axis then, tip is automatically selected

TipCandLeft(:,2) = rect(2) + X(:)';
TipCandLeft(:,1) = rect(1) + Y(:)';

if isequal(TipCandRight,[])
    display('missing')
else
    % the best one tip
    [best_right best_left] = Best_antiprojected_couple(TipCandRight, TipCandLeft, 2,handles);
    
    Tip_L = impoint(handles.axes1,[best_left(1) best_left(2)]);
    Tip_R = impoint(handles.axes2,[best_right(1) best_right(2)]);
end

%

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


Ifusion_Global

rect = round(getrect(handles.axes2));

%
% The candidate tips must be selected from the Before Pullback sequences.
%
I = im2double (squeeze(BPB_R(:,:,1,:)) );

for u=1:size(BPB_R,4)
    %
    % The images can be preprocessed by uncommenting the following line.
    %
    
    % im_out(:,:,u) = imageEnhancment(I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
    im_out(:,:,u) = (I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
end
%
% Remove part of the image in case it has been preprocessed, since there is
% a border effect using the function 'imageEnhancment'.
%
im_out=im_out(14:end-13,14:end-13,:);

I = im2double( min(squeeze(BPB_R(:,:,1,:)),[],3  ));
I(rect(2):rect(2)+size(im_out,1)-1,rect(1):rect(1)+size(im_out,2)-1)=min(im_out,[],3);

XY = detectCatheterTipMultipleFrames(im_out);

X = XY(:,1);
Y = XY(:,2);

axes(handles.axes2)

try
    posExt = Ext_R.getPosition();
    delete(Ext_R)
catch
end

try
    posTip = Tip_R.getPosition();
    delete(Tip_R)
catch
end

hold on

im_s = imshow(I);
set(im_s,'HitTest','off')
scatter(rect(1)+Y,rect(2)+X,'xy');

try
    Tip_R = impoint(handles.axes2,posTip);
catch
end

try
    Ext_R = impoint(handles.axes2,posExt);
catch
end

TipCandRight = [];
%user click on a different axis then, tip is automatically selected
TipCandRight(:,2) = rect(2) + X(:)';
TipCandRight(:,1) = rect(1) + Y(:)';



if isequal(TipCandLeft,[])
    display('missing')
else
    % the best one tip
    [best_right best_left] = Best_antiprojected_couple(TipCandRight, TipCandLeft, 2,handles);
    
    Tip_L = impoint(handles.axes1,[best_left(1) best_left(2)]);
    Tip_R = impoint(handles.axes2,[best_right(1) best_right(2)]);
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



Ifusion_Global

rect = round(getrect(handles.axes1));

I = im2double (squeeze(APB_L(:,:,1,:)) );

for u=1:size(APB_L,4)
    %im_out(:,:,u) = imageEnhancment(I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
    im_out(:,:,u) = (I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
end
%removing border efect
im_out = im_out(14:end-13,14:end-13,:);
I = im2double( min(squeeze(APB_L(:,:,1,:)),[],3  ));

I(rect(2):rect(2)+size(im_out,1)-1,rect(1):rect(1)+size(im_out,2)-1)=min(im_out,[],3);

XY = detectCatheterTipMultipleFrames(im_out);
X = XY(:,1);
Y = XY(:,2);
axes(handles.axes1)

try
    posExt = Ext_L.getPosition();
    delete(Ext_L)
catch
end

try 
    posTip = Tip_L.getPosition();
    delete(Tip_L)
catch
end

hold on
im_s = imshow(I);

set(im_s,'HitTest','off')
scatter(rect(1)+Y,rect(2)+X,'xy');

try
    Ext_L = impoint(handles.axes1,posExt);
catch
end

try  
    Tip_L = impoint(handles.axes1,posTip);
catch
end

ExtCandLeft=[];
%user click on a different axis then, tip is automatically selected

ExtCandLeft(:,2) = rect(2) + X(:)';
ExtCandLeft(:,1) = rect(1) + Y(:)';

if isequal(ExtCandRight,[])
    display('missing')
else
    % the best one tip
    [best_right best_left] = Best_antiprojected_couple(ExtCandRight, ExtCandLeft, 1,handles);
    Ext_L = impoint(handles.axes1,[best_left(1) best_left(2)]);
    Ext_R = impoint(handles.axes2,[best_right(1) best_right(2)]);
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ifusion_Global

rect = round(getrect(handles.axes2));

I = im2double (squeeze(APB_R(:,:,1,:)) );

for u=1:size(APB_R,4)
    %im_out(:,:,u) = imageEnhancment(I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
    im_out(:,:,u) = (I((rect(2)-13):(rect(2)+rect(4)+13),(rect(1)-13):(rect(1)+rect(3)+13),u));
end

im_out = im_out(14:end-13,14:end-13,:);

I = im2double( min(squeeze(APB_R(:,:,1,:)),[],3  ));

I(rect(2):rect(2)+size(im_out,1)-1,rect(1):rect(1)+size(im_out,2)-1) = min(im_out,[],3);

XY = detectCatheterTipMultipleFrames(im_out);
X = XY(:,1);
Y = XY(:,2);
axes(handles.axes2)

try   
    posExt = Ext_R.getPosition();
    delete(Ext_R)
catch
end

try
    posTip = Tip_R.getPosition();
    delete(Tip_R)
catch
end

hold on

im_s = imshow(I);
set(im_s,'HitTest','off')

scatter(rect(1)+Y,rect(2)+X,'xy');

try
    Tip_R = impoint(handles.axes2,posTip);
catch
end

try 
    Ext_R = impoint(handles.axes2,posExt);
catch
end

ExtCandRight = [];

ExtCandRight(:,2) = rect(2) + X(:)';
ExtCandRight(:,1) = rect(1) + Y(:)';


if isequal(ExtCandLeft,[])
    display('missing')
else
    [best_right best_left] = Best_antiprojected_couple(ExtCandRight, ExtCandLeft, 1,handles);
    
    Ext_L = impoint(handles.axes1,[best_left(1) best_left(2)]);
    Ext_R = impoint(handles.axes2,[best_right(1) best_right(2)]);
end

function click_on_axes(hObject, eventdata, handles,curve)
if get(handles.checkbox3,'Value')
    
    Ifusion_Global;
    
    if ishandle(Epi)
        delete(Epi)
    end

    axes_selected = gca;
    p = get(axes_selected,'CurrentPoint');
    p = [p(1,1)-round(im_size/2) p(1,2)-round(im_size/2)];
    
    ep   = Epipolar(p,F(3-curve),F(curve),C(3-curve),C(curve),l(curve,:),c(curve,:),k(curve,:),l(3-curve,:),c(3-curve,:),k(3-curve,:));
    ep_s = StretchLine(ep + round(im_size/2), [ 1 1 [im_size im_size]]);
    
    if curve == 1
        axes(handles.axes2)
    else
        axes(handles.axes1)
    end
    hold on,
    
    Epi = plot(ep_s(:,2)', ep_s(:,1)','r');
    set(Epi,'HitTest','off')
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%THIS BUTTON DEFINES WHETHER USER WANTS TO SEE EPIPOLAR ON THE SCREEN
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% % % %
% % % % Create and visualize 3D model of the curve.
% % % %

Ifusion_Global;

try
    PullBack.StopTrim;
catch
    [FileName,PathName] = uigetfile(['D:\Pacientes Fusion\*.dcm'],'Select the PullBack');

    if FileName==0
        %
        % The user canceled the selection (continue without events)
        %
    else
        PB_real='Yes';
        f=waitbar(0.35,'Loading...');
        PullBack=dicominfo([PathName FileName]);
        set(handles.pushbutton4,'Enable','on');
        waitbar(0.6)
        waitbar(1)
        close(f)
    end
end

pts3D = [];
for i = 1:N_ctrl_pts
    v1(i,:) = (Curves{1}.control_pts{i}.getPosition() - round(im_size/2)) * sc_fact;
    v2(i,:) = (Curves{2}.control_pts{i}.getPosition() - round(im_size/2)) * sc_fact;
end
for i = 1:N_ctrl_pts
    pts3D(i,:) = Intersection_line_line(-k(1,:)*(v1(i,1))+l(1,:)*(v1(i,2))+C(1)*c(1,:),-c(1,:)*F(1),-k(2,:)*(v2(i,1))+l(2,:)*(v2(i,2))+C(2)*c(2,:),-c(2,:)*F(2) );
end

sz = PullBack.StopTrim;

X = spline(linspace(0,1,N_ctrl_pts),pts3D(:,1)',linspace(0,1,sz))';
Y = spline(linspace(0,1,N_ctrl_pts),pts3D(:,2)',linspace(0,1,sz))';
Z = spline(linspace(0,1,N_ctrl_pts),pts3D(:,3)',linspace(0,1,sz))';

pts3D = [];

pts3D(:,1) = X;
pts3D(:,2) = Y;
pts3D(:,3) = Z;

%
% Compute the length of the 3D model, i.e. the IVUS pullback lenght.
%

%
% The distance is computed by summing up the Euclidean 3D distance between
% subsequent points of the 3D curve.
%
d1 = sum(power(power(diff(pts3D(1:sz,1)),2)+power(diff(pts3D(1:sz,2)),2)+power(diff(pts3D(1:sz,3)),2),0.5));

figure(3)


plot3(-pts3D(:,1),-pts3D(:,2),-pts3D(:,3),'ro','MarkerSize',20,'MarkerFaceColor','r')

hold on
plot3(-pts3D(1,1),-pts3D(1,2),-pts3D(1,3),'ro','MarkerSize',20,'MarkerFaceColor',[151 7 3]/255)
plot3(-pts3D(end,1),-pts3D(end,2),-pts3D(end,3),'ro','MarkerSize',20,'MarkerFaceColor',[151 7 3]/255)
plot3(-pts3D(m1,1),-pts3D(m1,2),-pts3D(m1,3),'ys','MarkerEdgeColor','k',...
    'MarkerFaceColor','y',...
    'MarkerSize',35)
plot3(-pts3D(m2,1),-pts3D(m2,2),-pts3D(m2,3),'rs','MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',35)
hold off

set(gca, 'Projection', 'Perspective')
daspect([1 1 1])
grid on, box on,
title(['Model length: ' num2str(d1) ' mm']);


%% 3D Geometry Visualization
%

figure(4)

s  = 400;
v1 = [];
v2 = [];

quiver3(0,0,0,s,0,0,'b','LineWidth',2 )

hold on
quiver3(0,0,0,0,s,0,'b','LineWidth',2 )
quiver3(0,0,0,0,0,s ,'b','LineWidth',2 )
quiver3(0,0,0,-s,0,0,'b','LineWidth',2 )
quiver3(0,0,0,0,-s,0,'b','LineWidth',2 )
quiver3(0,0,0,0,0,-s ,'b','LineWidth',2 )

center =  C(1) * c(1,:);
focus1 = -F(1) * c(1,:);

plot3(focus1(1),focus1(2),focus1(3),'.r')

center =  C(2) * c(2,:);
focus2 = -F(2) * c(2,:);

plot3(focus2(1),focus2(2),focus2(3),'.r')

set(get(gca,'XLabel'),'String','axis X')
set(get(gca,'YLabel'),'String','axis Y')
set(get(gca,'ZLabel'),'String','axis Z')
daspect( [1 1 1])

for i = 1:N_ctrl_pts
    v1(i,:) = (Curves{1}.control_pts{i}.getPosition() - round(im_size/2)) * sc_fact;
    v2(i,:) = (Curves{2}.control_pts{i}.getPosition() - round(im_size/2)) * sc_fact;
    
    p1(i,:) = -k(1,:)*(v1(i,1)) + l(1,:)*(v1(i,2)) + C(1)*c(1,:);
    p2(i,:) = -k(2,:)*(v2(i,1)) + l(2,:)*(v2(i,2)) + C(2)*c(2,:);
    
    hold on
    plot3(p1(i,1),p1(i,2),p1(i,3),'.r','LineWidth',5)
    plot3(p2(i,1),p2(i,2),p2(i,3),'.r','LineWidth',5)
    line([p1(i,1) focus1(1)],[p1(i,2) focus1(2)],[p1(i,3) focus1(3)])
    line([p2(i,1) focus2(1)],[p2(i,2) focus2(2)],[p2(i,3) focus2(3)])
end

vv1 = v1;
vv2 = v2;

v1=zeros(size(Curves{1}.coor));v2=zeros(size(Curves{2}.coor));

for i=1:size(Curves{1}.coor,1)
    try
        v1(i,:) = ([Curves{1}.coor(i,2)  Curves{1}.coor(i,1)] - round(im_size/2)) * sc_fact;
    catch
    end

    try
        v2(i,:) = ([Curves{2}.coor(i,2)  Curves{2}.coor(i,1)] - round(im_size/2)) * sc_fact;
    catch
    end

    try
        p1(i,:) = -k(1,:)*(v1(i,1)) + l(1,:)*(v1(i,2)) + C(1)*c(1,:);
    catch
    end

    try
        p2(i,:) = -k(2,:)*(v2(i,1)) + l(2,:)*(v2(i,2)) + C(2)*c(2,:);
    catch
    end
end

plot3(p1(:,1),p1(:,2),p1(:,3),'y')
plot3(p2(:,1),p2(:,2),p2(:,3),'y')

for i = 1:N_ctrl_pts
    pts3(i,:) = Intersection_line_line(-k(1,:)*(vv1(i,1))+l(1,:)*(vv1(i,2))+C(1)*c(1,:),-c(1,:)*F(1),-k(2,:)*(vv2(i,1))+l(2,:)*(vv2(i,2))+C(2)*c(2,:),-c(2,:)*F(2) );
    hold on
    plot3(pts3(i,1),pts3(i,2),pts3(i,3),'.r','LineWidth',5)
end

plot3(pts3D(:,1),pts3D(:,2),pts3D(:,3),'k')

%
% Images
%

Image = imadjust(im2double(squeeze(BPB_L(:,:,1,TipSlide_L))));
I = zeros(size(Image,1),size(Image,2),3);
I(:,:,1) = Image;
I(:,:,2) = Image;
I(:,:,3) = Image;

[X Y] = meshgrid(-round(im_size/2):10:round(im_size/2));

for i = 1:size(X,1)
    for j = 1:size(X,1)
        temp = -k(1,:)*(X(i,j)*sc_fact)+l(1,:)*(Y(i,j)*sc_fact)+C(1)*c(1,:);
        xx(i,j) = temp(1);
        yy(i,j) = temp(2);
        zz(i,j) = temp(3);
    end
end

hold on
surface(xx,yy,zz,I,...
    'FaceColor','texturemap',...
    'EdgeColor','none',...
    'CDataMapping','direct')
colormap(gray)

Image = imadjust(im2double(squeeze(BPB_R(:,:,1,TipSlide_R))));
I = zeros(size(Image,1),size(Image,2),3);
I(:,:,1) = Image;
I(:,:,2) = Image;
I(:,:,3) = Image;

[X Y] = meshgrid(-round(im_size/2):10:round(im_size/2));

for i = 1:size(X,1)
    for j = 1:size(X,1)
        temp = -k(2,:)*(X(i,j)*sc_fact)+l(2,:)*(Y(i,j)*sc_fact)+C(2)*c(2,:);
        xx(i,j) = temp(1);
        yy(i,j) = temp(2);
        zz(i,j) = temp(3);
    end
end

hold on
surface(xx,yy,zz,I,...
    'FaceColor','texturemap',...
    'EdgeColor','none',...
    'CDataMapping','direct')
colormap(gray)
%%VISION MODULE 3D GEOMETRY

function [best_right best_left] = Best_antiprojected_couple(cand_right, cand_left, extrem, handles)
%
% [best_right best_left] = Best_antiprojected_couple(cand_right, cand_left, extrem, handles)
%
% SYNOPSIS: This function, starting from the two lists of 'left' and
%           'right' tip candidates, find out the best couple that minimizes the
%           anti-projection error.
%
% INPUT:    cand_right:	list of 'right' candidates points
%           cand_left:  list of 'right' candidates points
%           extrem:     variable that can assume two values:
%                       - 1: the list of points represent 'extremes'.
%                       - 2: the list of points represent 'tips'.
%           handles:    handler of the figure Ifusion_interface_2.fig
%
% OUTPUT:   best_right: the right point of the best couple (1x2 matrix)
%           best_left:  the left point of the best couple  (1x2 matrix)
%
% REF:
%
% COMMENTS: See graphic explanation in the PPT documentation.
%

Ifusion_Global;

v2 = cand_right;
v1 = cand_left;

%
% For each right point candidate 
%
for i = 1:size(cand_right,1)
    %
    % For each left point candidate 
    %
    for j = 1:size(cand_left,1)
        %
        % Compute the anti-projection error for the 'ith' right and 'jth'
        % left couple of points
        %
        [p e] = Intersection_line_line(-k(1,:)*(v1(j,1))+l(1,:)*(v1(j,2))+C(1)*c(1,:),-c(1,:)*F(1),-k(2,:)*(v2(i,1))+l(2,:)*(v2(i,2))+C(2)*c(2,:),-c(2,:)*F(2) );
        %
        % Assign the error at the proper location in matrix error_mat (see PPT documentation)
        %
        error_mat(i,j) = e;
    end
end

%
% Find the (i,j) indices of the couple that minimizes the anti-projection
% error.
%
[i j] = ind2sub(size(error_mat),find(error_mat == min(min(error_mat))));

%
% Set the output values.
%
best_right = cand_right(i(1),:);
best_left  = cand_left(j(1),:);

%
% Depending on the best couple, set the best BeforePullback frames that
% containes the best couple's points.
%
if extrem == 2
    clc
    TipSlide_R = i(1);
    TipSlide_L = j(1);
    
    %
    % Print best left and right frames.
    %
    [TipSlide_L TipSlide_R]
    
    set(handles.pushbutton7,'Enable','off');
    set(handles.pushbutton8,'Enable','off');
else
    set(handles.pushbutton11,'Enable','off');
    set(handles.pushbutton12,'Enable','off');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try

Ifusion_Global;
path6=PullBack.Filename;    


Coor1 = Curves{1}.coor;
Coor2 = Curves{2}.coor;

for id=1:N_ctrl_pts
   ctrl_pts1(id,:)=Curves{1}.control_pts{id}.getPosition();
   ctrl_pts2(id,:)=Curves{2}.control_pts{id}.getPosition();
end

info = dicominfo(path1);
name = uiputfile;
save(name,'path1','path2','path3','path4','path5','path6','Coor1','Coor2','TipSlide_L','TipSlide_R','c','k','l','C','F','ctrl_pts1','ctrl_pts2');
catch
  display('CAUTION: This Case is not ready to be saved')    
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ifusion_Global;

try
    load(Patient_case,'Coor1','Coor2','TipSlide_R','TipSlide_L','ctrl_pts1','ctrl_pts2')
    size(ctrl_pts1,1);
    old_case=1;

catch
    load(Patient_case,'Coor1','Coor2','TipSlide_R','TipSlide_L')
    old_case=0;
    Curves{1}.control_pts={};
    Curves{2}.control_pts={};
end
Curves{1}.coor=Coor1;
Curves{1}.pointer=[];


Curves{2}.coor=Coor2;
Curves{2}.pointer=[];


axes(handles.axes1)
hold on

im_s = imshow(im2double(squeeze(BPB_L(:,:,1,TipSlide_L))) );

set(handles.slider1,'Value',TipSlide_L);
set(handles.text3,'String',['Slide: ' num2str(TipSlide_L)]);
set(im_s,'HitTest','off')

hold on
Curves{1}.pointer = plot(Curves{1}.coor(:,2),Curves{1}.coor(:,1),'y');


axes(handles.axes2)
hold on

im_s = imshow(im2double(squeeze(BPB_R(:,:,1,TipSlide_R))) );

set(handles.slider2,'Value',TipSlide_R);
set(handles.text4,'String',['Slide: ' num2str(TipSlide_R)]);
set(im_s,'HitTest','off')

hold on
Curves{2}.pointer = plot(Curves{2}.coor(:,2),Curves{2}.coor(:,1),'y');

set(handles.pushbutton7,'Enable','off')
set(handles.pushbutton8,'Enable','off')
set(handles.pushbutton11,'Enable','off')
set(handles.pushbutton12,'Enable','off')
set(handles.pushbutton3,'Enable','off')

Ifusion_Trace_Curves (handles.axes1,handles.axes2,handles.axes1);

Ifusion_Control_Points(handles.axes1,handles.axes2)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



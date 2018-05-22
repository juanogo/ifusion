% IFUSION MATLAB IMPLEMENTATION
% by Juan Diego Gomez PhD(Std)and Carlo Gatta PhD
% Medical Imaging Group
% Computer Vision Center CVC.
% Barcelona, Spain
% 2009
function varargout = Ifusion_interface_3(varargin)
% IFUSION_INTERFACE_3 M-file for Ifusion_interface_3.fig
%      IFUSION_INTERFACE_3, by itself, creates a new IFUSION_INTERFACE_3 or raises the existing
%      singleton*.
%
%      H = IFUSION_INTERFACE_3 returns the handle to a new IFUSION_INTERFACE_3 or the handle to
%      the existing singleton*.
%
%      IFUSION_INTERFACE_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IFUSION_INTERFACE_3.M with the given input arguments.
%
%      IFUSION_INTERFACE_3('Property','Value',...) creates a new IFUSION_INTERFACE_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ifusion_interface_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ifusion_interface_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ifusion_interface_3

% Last Modified by GUIDE v2.5 11-Nov-2009 20:53:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Ifusion_interface_3_OpeningFcn, ...
    'gui_OutputFcn',  @Ifusion_interface_3_OutputFcn, ...
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


% --- Executes just before Ifusion_interface_3 is made visible.
function Ifusion_interface_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ifusion_interface_3 (see VARARGIN)

% Choose default command line output for Ifusion_interface_3

Ifusion_Global

try
    CORO(1,1,1,1)
catch
    CORO=BPB_L;
    l(3,:)=l(1,:);k(3,:)=k(1,:);c(3,:)=c(1,:);
    C(1,3)=C(1,1);
    F(1,3)=F(1,1);
    path5=path1;
    
end

set(handles.slider1,'Value',1)
set(handles.slider2,'Value',1)
set(handles.slider3,'Value',1)
set(handles.slider1,'Max',size(CORO,4))
set(handles.slider2,'Max',PullBack.StopTrim)
set(handles.slider3,'Max',PullBack.StopTrim)
set(handles.slider1,'Min',1)
set(handles.slider2,'Min',1)
set(handles.slider3,'Min',1)
set(handles.slider1,'SliderStep',[1/get(handles.slider1,'Max') 0.4])
set(handles.slider2,'SliderStep',[1/get(handles.slider2,'Max') 0.4])
set(handles.slider3,'SliderStep',[1/get(handles.slider2,'Max') 0.4])

axes(handles.axes5)
im_s=imshow(uint8(CORO(:,:,1,1)));
set(im_s,'HitTest','off')
set(handles.slider1,'Value',1 )
set(handles.text1,'String',num2str(1))

Inicialization(handles.figure1, [], handles)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ifusion_interface_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ifusion_interface_3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

Ifusion_Global

value=round(get(hObject, 'Value'));
axes(handles.axes5)
im_s=imshow(uint8(CORO(:,:,1,value)));
set(im_s,'HitTest','off')
set(handles.text1,'String',num2str(value))
hold on
plot(Coronary_curve(:,2),Coronary_curve(:,1),'LineWidth',2)
plot(Coronary_curve(m1,2),Coronary_curve(m1,1),'oy','LineWidth',2)


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

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Ifusion_Global

m1=round(get(hObject,'Value'));
if PB_real(1)=='Y'
 % im6=uint8(PullBack(:,:,m1));
 im6=uint8(PullBack(:,:,1,m1));
end
Refresh_axes6(hObject, eventdata, handles);
Refresh_axes2(hObject, eventdata, handles);

Distance(handles);



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

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


function click_on_fig6(hObject, eventdata, handles)
ifusion_Global;

p6=get(gca,'CurrentPoint');

%Refresh the axes 6
Refresh_axes6(hObject, eventdata, handles);

if PB_real(1)=='Y'
    %generate image for axes 2 (im2)
    for i=1:2*r
        % image2(i,:)=PullBack(round(a(i)+centerx),round(-(b(i)-centery)),:);
        image2(i,:)=PullBack(round(a(i)+centerx),round(-(b(i)-centery)),1,:);
    end
    im2=uint8(image2);
end
Refresh_axes2(hObject, eventdata, handles);






function click_on_fig2(hObject, eventdata, handles)
Ifusion_Global;

p2=get(gca,'CurrentPoint');
m1=round(p2(1,1));
Refresh_axes2(hObject, eventdata, handles);

if PB_real(1)=='Y'
 % im6=uint8(PullBack(:,:,m1));
 im6=uint8(PullBack(:,:,1,m1));
end
Refresh_axes6(hObject, eventdata, handles);

Distance(handles);





% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Ifusion_Global;

figure (3)


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
grid on, box on, 


function Inicialization(hObject, eventdata, handles)

Ifusion_Global;

m1=10; m2=5;
set(handles.slider3,'Value',m2);
centerx=round(double(PullBack.Width/2));
centery=round(double(PullBack.Height/2));
p6=[0 100];
r=centerx-5;

clear BPB_L BPB_R APB_L APB_R

if PB_real(1)=='Y'
    try
        % keyboard
        temp=PullBack.Filename;
        f = waitbar(0.35,'Loading PullBack...');        
        PullBack = dicomread(PullBack.Filename);        
        waitbar(0.6)
        % PullBack = squeeze(PullBack(:,:,1,:));
        % PullBack = dicom_vol(PullBack);        
        waitbar(1)
        close(f)
    catch
        display('PullBack is longer than available memory (Mode simulation is on)')
        PB_real='No';
        PullBack=dicominfo(temp);
        close(f);
    end
end

%Generate image for axes 2 (im6)
if PB_real(1)=='Y'
  % im6=uint8( PullBack(:,:,m1));
  im6=uint8( PullBack(:,:,1,m1));
else
  im6=uint8( zeros(im_size,im_size));
end
Refresh_axes6(hObject, eventdata, handles);

%Generate image for axes 2 (im2)

if PB_real(1)=='Y'
    for i=1:2*r
        % image2(i,:)=PullBack(round(a(i)+centerx),round(-(b(i)-centery)),:);
        image2(i,:) = PullBack(round(a(i)+centerx),round(-(b(i)-centery)),1,:);
    end
    im2=uint8(image2);
else
    image2=zeros(im_size,PullBack.StopTrim);
    im2=uint8(image2);
end

Refresh_axes2(hObject, eventdata, handles);


% It generates the curve to be shown on the axes 5

for id=1:size(pts3D,1)
    %
    % This command finds the 3D intersection point between
    % the Coronography plane and the line containing the 3D control point and
    % the focus of the plane.   
    %
    temp = Intersection_plane_line(pts3D(id,:), -F(3)*c(3,:), C(3)*c(3,:), c(3,:));
    
    %
    % Project to image plane in pixels
    %
    temp = ([l(3,:); -k(3,:)]'\ (temp-(C(3)*c(3,:)))')' / sc_fact;
    
    %
    % Convert to local reference system in pixels
    %
    temp = temp + round(im_size/2);
    
    %
    % Update the position of the control point.
    %
    Coronary_curve(id,:)=[temp(1),temp(2)];

end

axes(handles.axes5)
hold on
plot(Coronary_curve(:,2),Coronary_curve(:,1),'LineWidth',2)
%plot(Curves{1}.coor(:, 2),Curves{1}.coor(:,1),'r')


%initial longitude

Distance(handles);

function Distance(handles)
Ifusion_Global;

%
% Compute the distance between first curve point and point at 'm1', the
% user set it in the longitudinal cut
%

%
% The distance is computed by summing up the Euclidean 3D distance between
% subsequent points of the 3D curve.
%
d1 = sum(power(power(diff(pts3D(1:m1,1)),2)+power(diff(pts3D(1:m1,2)),2)+power(diff(pts3D(1:m1,3)),2),0.5));

%
% Compute the distance between first curve point and point at 'm2', the
% user set it in the longitudinal cut
%

%
% The distance is computed by summing up the Euclidean 3D distance between
% subsequent points of the 3D curve.
%
d2= sum(power(power(diff(pts3D(1:m2,1)),2)+power(diff(pts3D(1:m2,2)),2)+power(diff(pts3D(1:m2,3)),2),0.5));

%
% Compute the distance between m2 and m1
%
d = abs(d2-d1);

set(handles.text3,'String',num2str(d1))
set(handles.text4,'String',num2str(d2))
set(handles.text5,'String',num2str(d))



% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Ifusion_Global;

m2=round(get(handles.slider3,'Value'));

Refresh_axes2(hObject, eventdata, handles);

Distance(handles);





% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function Refresh_axes6(hObject, eventdata, handles)
Ifusion_Global;

axes(handles.axes6)
im=imshow(im6);
set(im,'HitTest','off')
set(handles.axes6,'Visible','on')
set(handles.axes6,'ButtonDownFcn',{@click_on_fig6,handles} )

set(handles.slider2,'Value',m1);
set(handles.text2,'String',['Slide: ', num2str(m1)]);
x=round(p6(1,1)); y=round(p6(1,2));
x=x-centerx;
y=-(y-centery);
angle=calcular_angulos(x,y);

a=0:r; b=zeros(size(a));
a=round((0:r)*cos(deg2rad(angle)));
b=round((0:r)*sin(deg2rad(angle)));
a=[-a(size(a,2):-1:2  )   a];
b=[-b(size(b,2):-1:2  )   b];
hold on
plot(a+centerx , -(b-centery),'y');%hittest off
hold off
axes(handles.axes5)

try Coronary_curve(m1,2)    
    im_s=imshow(uint8(CORO(:,:,1,round(get(handles.slider1,'Value')))));
    set(im_s,'HitTest','off')
    hold on
    plot(Coronary_curve(:,2),Coronary_curve(:,1),'LineWidth',2)
    plot(Coronary_curve(m1,2),Coronary_curve(m1,1),'oy','LineWidth',2)
    
catch
end



function Refresh_axes2(hObject, eventdata, handles)
Ifusion_Global;

axes(handles.axes2)
im=imshow(im2);
set(im,'HitTest','off')
set(handles.axes2,'Visible','on')
set(handles.axes2,'HitTest','on')
set(handles.axes2,'ButtonDownFcn',{@click_on_fig2,handles} )
hold on
plot(m1,1:im_size,'y')
plot(m2,1:im_size,'g')
hold off
axes(handles.axes5)
try Coronary_curve(m1,2)    
    im_s=imshow(uint8(CORO(:,:,1,round(get(handles.slider1,'Value')))));
    set(im_s,'HitTest','off')
    hold on
    plot(Coronary_curve(:,2),Coronary_curve(:,1),'LineWidth',2)
    plot(Coronary_curve(m1,2),Coronary_curve(m1,1),'oy','LineWidth',2)
    
catch
end




function varargout = ERObject(varargin)
% EROBJECT MATLAB code for ERObject.fig
%      EROBJECT, by itself, creates a new EROBJECT or raises the existing
%      singleton*.
%
%      H = EROBJECT returns the handle to a new EROBJECT or the handle to
%      the existing singleton*.
%
%      EROBJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EROBJECT.M with the given input arguments.
%
%      EROBJECT('Property','Value',...) creates a new EROBJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ERObject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ERObject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ERObject

% Last Modified by GUIDE v2.5 27-Jan-2016 10:19:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ERObject_OpeningFcn, ...
                   'gui_OutputFcn',  @ERObject_OutputFcn, ...
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



% --- Executes just before ERObject is made visible.
function ERObject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ERObject (see VARARGIN)

% Choose default command line output for ERObject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes ERObject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ERObject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

set(handles.pushbutton2,'Visible','off');
set(handles.pushbutton3,'Visible','off');
set(handles.pushbutton4,'Visible','off');
set(handles.pushbutton5,'Visible','off');
set(handles.pushbutton6,'Visible','off');
set(handles.pushbutton7,'Visible','off');
set(handles.pushbutton8,'Visible','off');
set(handles.pushbutton9,'Visible','off');
set(handles.pushbutton10,'Visible','off');
set(handles.pushbutton11,'Visible','off');
set(handles.pushbutton12,'Visible','off');
set(handles.pushbutton13,'Visible','off');
set(handles.pushbutton14,'Visible','off');
set(handles.pushbutton15,'Visible','off');
set(handles.pushbutton16,'Visible','off');
set(handles.pushbutton17,'Visible','off');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes (handles.axes1);
[FileName,PathName] = uigetfile({'*.tif'},...
    'Selecione o MDE');
Diretorio = fullfile(PathName,FileName);
DEM = GRIDobj(Diretorio);
A_DEM = fillsinks(DEM);
imageschs(A_DEM);
freezeColors;
colorbar off;
title('MDE');
axis off;
set(handles.pushbutton1,'userdata',A_DEM); % Disponibiliza os dados do MDE para outros botões.
set(handles.pushbutton3,'Visible','on');
set(handles.pushbutton4,'Visible','on');
guidata(hObject,handles);

set(handles.pushbutton16,'Visible','on');

 % --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes (handles.axes2);
set(handles.pushbutton3,'Visible','on');
A_DEM = get(handles.pushbutton1,'userdata');% Puxa o dados do MDE do botão 1
f = warndlg('A Imagem Multiespectral deve ter a mesma resolução e tamanho do MDE','Atenção!');
waitfor(f);
disp ('proceguir');
[FileName,PathName] = uigetfile({'*.tif'},...
    'Selecione a imagem multiespectral');
Diretorio = fullfile(PathName,FileName);
RapidEye = GRIDobj(Diretorio);
[Bandas_RapidEye,x,y] = GRIDobj2mat(RapidEye);
ORbands =str2double(inputdlg({'Ordem da banda Near - Infravermelho (apenas número):',...
    'Ordem da banda R -  Vermelho (apenas número):'},'Ordem',1,{'5','3'}));
INFR = RapidEye.Z (:,:,ORbands(1));
VERM = RapidEye.Z (:,:,ORbands(2));
NDVI1 = NDVI (INFR,VERM);
TT = A_DEM < 1;
NEle_DEM=size(A_DEM.Z)
NEle_NDVI=size(NDVI1)

if NEle_DEM ~= NEle_NDVI
	errordlg('As imagens DEM e multiespectral têm tamanhos e/ou resoluções diferentes.','Erro');
else
	A_NDVI = TT + NDVI1;
    set(handles.pushbutton3,'userdata',...
    A_NDVI);% Disponibiliza os dados do NDVI para outros botões.
    imshow (A_NDVI.Z);
    freezeColors;
    title('NDVI');
    axis off;
    set(handles.pushbutton2,'Visible','on');     
end

guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_NDVI = get(handles.pushbutton3,'userdata');% Puxa o dados do MDE do botão 1
[FileName,PathName] = uiputfile('NDVI(Normalized Difference Vegetation Index).tif',...
    'Escolha a pasta para salvar o NDVI');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_NDVI,Diretorio);


%FileName = 'Modelo Digital de Elevação.tif';
%Diretorio = fullfile(PathName,FileName);
%GRIDobj2geotiff(A_NDVI,Diretorio);

guidata(hObject,handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A_DEM = get(handles.pushbutton1,'userdata');
A_Aspe = aspect(A_DEM);
axes (handles.axes3);
imageschs (A_Aspe);
freezeColors;
colorbar off;
title('Aspecto');
axis off;
guidata(hObject,handles);

axes (handles.axes4);
A_DSin = gradient8(A_DEM,'sin');
imageschs (A_DSin);
freezeColors;
colorbar off;
title('Declividade');
axis off;
guidata(hObject,handles);

axes (handles.axes5);
A_CPer = curvature(A_DEM,'profc');
imageschs(A_CPer,A_CPer,'colormap',gray,'colorbar',false);
freezeColors;
colorbar off;
title('Curvatura no perfil');
axis off;

axes (handles.axes6);
A_CPla = curvature(A_DEM,'planc')
imageschs(A_CPla,A_CPla,'colormap',gray,'colorbar',false);
freezeColors;
colorbar off;
title('Curvatura no plano');
axis off;

axes (handles.axes7);
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
imageschs(A_DEM,dilate(sqrt(A_FAcc),...
    ones(5)),'colormap',flipud(copper));
freezeColors;
colorbar off;
title('Fluxo de acumulação');
axis off;

axes (handles.axes8);
A_DSin = gradient8(A_DEM,'sin');
A_TWI = twi(A_FAcc,A_DSin);
imageschs(A_TWI);
freezeColors;
colorbar off;
title('Umidade topográfica');
axis off;

axes (handles.axes9);
A_DTan = gradient8(A_DEM,'tan');
A_ICMF = icmf(A_FAcc,A_DTan);
imageschs(A_ICMF);
freezeColors;
colorbar off;
title('Máximo fluxo corrente');
axis off;

axes (handles.axes10);
A_DTan = gradient8(A_DEM,'tan');
A_ICTS = icts(A_FAcc,A_DSin);
imagesc(A_ICTS);
freezeColors;
colorbar off
title('Cap. transporte de sedimentos');
axis off;

axes (handles.axes11);
FD = FLOWobj(A_DEM);
W = A_FAcc>5000;
S = STREAMobj(FD,W);
MS = STREAMobj2mapstruct(S);
set(handles.pushbutton4,'userdata',MS);
imageschs(A_DEM,A_DEM,'colormap',...
    gray,'colorbar',false);
mapshow(MS);
freezeColors;
colorbar off;
title('Drenagem');
axis off;

set(handles.pushbutton5,'Visible','on');
set(handles.pushbutton6,'Visible','on');
set(handles.pushbutton7,'Visible','on');
set(handles.pushbutton8,'Visible','on');
set(handles.pushbutton9,'Visible','on');
set(handles.pushbutton10,'Visible','on');
set(handles.pushbutton11,'Visible','on');
set(handles.pushbutton12,'Visible','on');
set(handles.pushbutton13,'Visible','on');
set(handles.pushbutton14,'Visible','on');

guidata(hObject,handles);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
A_Aspe = aspect(A_DEM);
[FileName,PathName] = uiputfile('Aspecto.tif',...
    'Escolha a pasta para salvar o Aspecto');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_Aspe,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');

choice = questdlg('Deseja salvar a declividade em qual formato?',...
	'Salvar Declividade', ...
	'Graus','Porcentagem','Porcentagem');
% gravando resposta
switch choice
    case 'Graus'
          resp = 1;
    case 'Porcentagem'
          resp = 2;
end

if resp == 1
	A_Decl = gradient8(A_DEM,'deg');
    [FileName,PathName] = uiputfile('Declividade em graus.tif',...
    'Escolha a pasta para salvar a Declividade em graus');
else
	A_Decl = gradient8(A_DEM,'per');
    [FileName,PathName] = uiputfile('Declividade em pordentagem.tif',...
    'Escolha a pasta para salvar a Declividade em pordentagem');
end

Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_Decl,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
A_CPer = curvature(A_DEM,'profc');
[FileName,PathName] = uiputfile('Curvatura no perfil.tif',...
    'Escolha a pasta para salvar a Curvatura no perfil.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_CPer,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
A_CPla = curvature(A_DEM,'planc');
[FileName,PathName] = uiputfile('Curvatura no plano.tif',...
    'Escolha a pasta para salvar a Curvatura no plano.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_CPla,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
[FileName,PathName] = uiputfile('Fluxo de Acumulação.tif',...
    'Escolha a pasta para salvar o Fluxo de Acumulação.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_FAcc,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
A_DSin = gradient8(A_DEM,'sin');
A_TWI = twi(A_FAcc,A_DSin);
[FileName,PathName] = uiputfile('Índice de Umidade Topográfica.tif',...
    'Escolha a pasta para salvar o Índice de Umidade Topográfica.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_TWI,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
A_DTan = gradient8(A_DEM,'tan');
A_ICMF = icmf(A_FAcc,A_DTan);
[FileName,PathName] = uiputfile('Índice de Máximo Fluxo Corrente.tif',...
    'Escolha a pasta para salvar o Índice de Máximo Fluxo Corrente.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_ICMF,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
A_DSin = gradient8(A_DEM,'sin')
A_ICTS = icts(A_FAcc,A_DSin);
[FileName,PathName] = uiputfile('Índice de Capacidade de Tranporte de Sedimentos.tif',...
    'Escolha a pasta para salvar o Índice de Capacidade de Tranporte de Sedimentos.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_ICTS,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A_DEM = get(handles.pushbutton1,'userdata');
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
Densidade=str2double(inputdlg({'Densidade da drenagem: quanto MENOR esse número, MAIOR a quantidade de feições de drenagens. Valor sugerido:'},...
    'Densidade',1,{'5000'}));
W = A_FAcc>Densidade;
S = STREAMobj(FD,W);
MS = STREAMobj2mapstruct(S);
[FileName,PathName] = uiputfile('Drenagem.shp',...
    'Escolha a pasta para salvar a Drenagem');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(MS,pasta_nome);
guidata(hObject,handles);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A_DEM = get(handles.pushbutton1,'userdata');

A_DSin = gradient8(A_DEM,'sin');
A_DTan = gradient8(A_DEM,'tan');
B_Ddeg = gradient8(A_DEM,'deg');

C_NDVI = get(handles.pushbutton3,'userdata')
%C_NDVI = A_NDVI;

D_Aspe = aspect(A_DEM);

F_CPer = curvature(A_DEM,'profc');

G_CPla = curvature(A_DEM,'planc');

FD = FLOWobj(A_DEM);
H_FAcc  = flowacc(FD);

E_TWI = twi(H_FAcc,A_DTan);

I_ICTS = icts(H_FAcc,A_DSin);

J_ICMF = icmf(H_FAcc,A_DTan);

% Escolha da árvore
[FileName,PathName] = uigetfile({'*.txt'},'Selecione a árvore');
Diretorio = fullfile(PathName,FileName);

f = warndlg({'A árvore de decisão é específica para uma determinada região, caso' 'você queira calcular a susceptibilidade a processos erosivos de' 'outras áreas, verifique a disponibilidade no site: www.erobject.com.br' 'ou entre em contato com geodenilson@gmail.com.' 'Clique em ok para continuar...'},...
    'Atenção!');waitfor(f);
disp ('prosseguir');

ARV1 = importdata(Diretorio);
NEle = numel (ARV1);
ARV2=char(ARV1);
contador = 1;
while contador<=NEle;
eval(ARV2(contador,:));
contador = contador+1;
end;

% Excluindo pixels isolados efeito sal-pimenta

VEC1 = ERO.Z
VEC2 = bwareaopen(VEC1,30);
VEC3 = double (VEC2);
VEC4 = ~im2bw(VEC3,graythresh(VEC3));
VEC5 = bwareaopen(VEC4,50);
VEC6 = double (VEC5);
VEC7 = ~im2bw(VEC6,graythresh(VEC6));
VEC8 = logical (VEC7);
ERO2 = ERO==2
ERO2.Z = VEC8

Vetor = ERO2Vector(ERO2);

set(handles.pushbutton14,'userdata',ERO2);

axes (handles.axes12);
imageschs(A_DEM,A_DEM,'colormap',gray,'colorbar',false);
mapshow(Vetor);
freezeColors;
colorbar off;
title('Sucept. a erosão linear');
axis off;

set(handles.pushbutton15,'Visible','on');
set(handles.pushbutton16,'Visible','on');
set(handles.pushbutton17,'Visible','on');
guidata(hObject,handles);

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ERO2 = get(handles.pushbutton14,'userdata');
Vetor = ERO2Vector(ERO2);
[FileName,PathName] = uiputfile('Areas_sucept_erosao_linear.shp',...
    'Escolha a pasta para salvar as áreas de suceptibilidade a erosão linear');% Cria variável de nome do arquivo e diretório.
Diretorio = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(Vetor,Diretorio);
guidata(hObject,handles);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A_DEM = get(handles.pushbutton1,'userdata')
[FileName,PathName] = uiputfile('Modelo Digital de Elevação.tif',...
    'Escolha a pasta para salvar o Modelo Digital de Elevação.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_DEM,Diretorio)
guidata(hObject,handles);

%uiputfile('NDVI.tif','Escolha a pasta para salvar o NDVI');

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uiputfile('Variaveis.tif',...
    'Escolha a pasta para salvar as variáveis');

 
A_DEM = get(handles.pushbutton1,'userdata');
FileName = 'Modelo Digital de Elevação.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_DEM,Diretorio);

A_NDVI = get(handles.pushbutton3,'userdata');
FileName = 'NDVI(Normalized Difference Vegetation Index).tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_NDVI,Diretorio);

A_Aspe = aspect(A_DEM);
FileName = 'Aspecto.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_Aspe,Diretorio);

A_DDeg = gradient8(A_DEM,'deg');
FileName = 'Declividade.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_DDeg,Diretorio);

A_CPer = curvature(A_DEM,'profc');
FileName = 'Curvatura no perfil.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_CPer,Diretorio);

A_CPla = curvature(A_DEM,'planc');
FileName = 'Curvatura no plano.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_CPla,Diretorio);

FD = FLOWobj(A_DEM);
A_FAcc  = flowacc(FD);
FileName = 'Fluxo de Acumulação.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_FAcc,Diretorio);

A_DTan = gradient8(A_DEM,'tan');
A_TWI = twi(A_FAcc,A_DTan);
FileName = 'Índice de Umidade Topográfica.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_TWI,Diretorio);

A_DSin = gradient8(A_DEM,'sin');
A_ICTS = icts(A_FAcc,A_DSin);
FileName = 'Índice de Capacidade de Tranporte de Sedimentos.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_ICTS,Diretorio);

A_ICMF = icmf(A_FAcc,A_DTan);
FileName = 'Índice de Máximo Fluxo Corrente.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_ICMF,Diretorio);

W = A_FAcc>5000;
S = STREAMobj(FD,W);
MS = STREAMobj2mapstruct(S);
FileName = 'Drenagem.shp';
Diretorio = fullfile(PathName,FileName);
shapewrite(MS,Diretorio);

ERO2 = get(handles.pushbutton14,'userdata');
Vetor = ERO2Vector(ERO2);
FileName = 'Areas_sucept_erosao_linear';
Diretorio = fullfile(PathName,FileName);
shapewrite(Vetor,Diretorio);
guidata(hObject,handles);

msgbox('Todas as variáveis foram salvas');

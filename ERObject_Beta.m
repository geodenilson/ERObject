function varargout = ERObject_Beta(varargin)
gui_Singleton = 1; 
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ERObject_Beta_OpeningFcn, ...
                   'gui_OutputFcn',  @ERObject_Beta_OutputFcn, ...
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

function ERObject_Beta_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = ERObject_Beta_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
% --------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.up_mult,'Visible','off');
set(handles.up_segments,'Visible','off');
set(handles.up_ndvi,'Visible','off');
set(handles.up_dem,'Visible','off');
set(handles.up_aspect,'Visible','off');
set(handles.up_slope,'Visible','off');
set(handles.up_profcurv,'Visible','off');
set(handles.up_plancurv,'Visible','off');
set(handles.up_facc,'Visible','off');
set(handles.up_twi,'Visible','off');
set(handles.up_spi,'Visible','off');
set(handles.up_ls,'Visible','off');
set(handles.up_drainage,'Visible','off');
set(handles.up_lep,'Visible','off');
set(handles.up_external_tree,'Visible','off');
set(handles.up_threshold,'Visible','off');


set(handles.geobia,'Visible','off');
set(handles.exploratory_analysis,'Visible','off');
set(handles.explo_mult,'Visible','off');
set(handles.explo_ndvi,'Visible','off');
set(handles.explo_dem,'Visible','off');
set(handles.explo_aspect,'Visible','off');
set(handles.explo_slope,'Visible','off');
set(handles.explo_profcurv,'Visible','off');
set(handles.explo_plancurv,'Visible','off');
set(handles.explo_facc,'Visible','off');
set(handles.explo_twi,'Visible','off');
set(handles.explo_spi,'Visible','off');
set(handles.explo_ls,'Visible','off');

set(handles.menu_tools,'Visible','off');
set(handles.Segmentation_Mult,'Visible','off');
set(handles.Compute_NDVI,'Visible','off');
set(handles.compute_variables,'Visible','off');
set(handles.shape_attributes,'Visible','off');


set(handles.attributes_segment,'Visible','off');
set(handles.fractalDimension,'Visible','off');
set(handles.compacity,'Visible','off');

set(handles.alter_rgb,'Visible','off');
set(handles.save_variables,'Visible','off');
set(handles.dem,'Visible','off');
set(handles.ndvi,'Visible','off');
set(handles.aspect,'Visible','off');
set(handles.slope,'Visible','off');
set(handles.prof_curvature,'Visible','off');
set(handles.plan_curvature,'Visible','off');
set(handles.f_accumulation,'Visible','off');
set(handles.twi,'Visible','off');
set(handles.spi,'Visible','off');
set(handles.ls,'Visible','off');
set(handles.drainage,'Visible','off');
set(handles.up_layer,'Visible','off');

set(handles.save_rule,'Visible','off');
set(handles.run_tree,'Visible','off');

set(handles.save_shapefile_geobia,'Visible','off');
set(handles.external_tree_shp,'Visible','off');

set(handles.segmentation,'Visible','off');
set(handles.attributes_segment_mul_dem_shp,'Visible','off');
set(handles.erosion_susceptibility_shp,'Visible','off');

set(handles.erosion_susceptibility,'Visible','off');
set(handles.obiaclass,'Visible','off');

guidata(hObject,handles);

function menu_tools_Callback(hObject, eventdata, handles);% 1 botão: "File".
guidata(hObject,handles);
function up_layer_Callback(hObject, eventdata, handles);
guidata(hObject,handles);
function about_Callback(hObject, eventdata, handles);
guidata(hObject,handles);

function file_Callback(hObject, eventdata, handles);
guidata(hObject,handles);
function geobia_Callback(hObject, eventdata, handles);
guidata(hObject,handles);

% --------------------------------------------------------------------
function open_image_multi_Callback(hObject, eventdata, handles) %2 botão: "Open Image Multiespectral".
global FileName PathName;% Variável global para acessar imagem multiespectral em outras funções.
[FileName,PathName] = uigetfile({'*.tif'},'Selecione a imagem Multiespectral')...
    ; %Pasta e nome para abrir imagem multespectral.
ln_multi = fullfile(PathName,FileName);
global mulT;
mulT = GRIDobj(ln_multi);%Insere imagem na classe GRIDobj.
[s] = plotRGB2(mulT); %Executa função plotRGB2, que gera strutura "s".
NBands = mulT.size (1,3);%Verifica quantas bandas a imagem possui.
for i=1:NBands %Loop para executar linhas da estrutura "s"
    eval ([char(s(i).out) ';']);%Executa linhas da coluna out da estrutura
                                % "s", que separa as bandas da imagem.
    eval (['delete(' (char(39)) (char(s(i).pasta)) (char(39))...
        ');']);%apaga arquivos gerados pela linha anterior da pasta temp. 
end
RGB=cat(3,B1,B2,B3); % Empilha as bandas 1, 2 e 3 para visualização.
RGB = uint16(RGB);% define o tipo dos dados de imagem (neste caso 16 bis-RapidEye).
global rgb_aju;
global R;
rgb_aju = imadjust(RGB,stretchlim(RGB),[]);% Equaliza automaticamente a imagem.
mapshow(rgb_aju, R); %Plota a imagem. 
axis off; % desabilita informações dos eixos da plotagem.


set(handles.menu_tools,'Visible','on');
set(handles.Segmentation_Mult,'Visible','on');
set(handles.Compute_NDVI,'Visible','on');
set(handles.up_layer,'Visible','on');
set(handles.up_mult,'Visible','on');
set(handles.alter_rgb,'Visible','on');
guidata(hObject,handles);

function Segmentation_Mult_Callback(hObject, eventdata, handles)
global FileName PathName; %Chamada da Variável global para acessar imagem multiespectral.
Diretorio = fullfile(PathName,FileName); %Pasta e nome para abrir imagem multespectral.
RapidEye = GRIDobj(Diretorio);%Insere imagem na classe GRIDobj.
canto = int32 (RapidEye.georef.BoundingBox([1, 3, 2, 4]));
Parametros_Baatz = str2double(inputdlg({'Compacidade:','Cor:','Escala:'},'Baatz',1,{'0.5',...
    '0.5','60'}));%Janela de para coleta de parametros para execução do segmentador Baatz. 
comp = Parametros_Baatz(1); %Variável compacidade do segmentador Baatz. 
cor = Parametros_Baatz(2);%Variável cor do segmentador Baatz.
escala = Parametros_Baatz(3);%Variável escala do segmentador Baatz.
h = waitbar(0,'Processing...');
global Seg_BaatzG; %Variável global para acessar imagem segmentada em outras funções.
waitbar(1/2,h,sprintf('Processing... %.2f%%',1/2*100));
Seg_BaatzG = InterImage_Seg_Baatz(FileName,Diretorio,canto,comp,cor,escala);
waitbar(2/2,h,sprintf('Processing... %.2f%%',2/2*100));
%Execução do segmentador Baatz com base na função "InterImage_Seg_Baatz" (+detalhes na função).
global SBaatz;
SBaatz = Seg_BaatzG;
Seg_BaatzG.georef = RapidEye.georef;%Passa parâmetros de da imagem original para a segmentação. 
Seg_BaatzG.refmat = RapidEye.refmat;%Passa parâmetros de da imagem original para a segmentação.
Seg_BaatzG.size = RapidEye.size;%Passa parâmetros de da imagem original para a segmentação.
global SRt;
SRt = GRIDobj2polygon2(Seg_BaatzG,'Geometry','Polygon');%Gera estrutura para grear o shapefile.
close(h);
geoshow(SRt, 'FaceColor', 'none','EdgeColor','blue');%Plota a segmentação na view exixtente. 


set(handles.run_tree,'Visible','on');
set(handles.geobia,'Visible','on');
set(handles.shape_attributes,'Visible','on');
set(handles.exploratory_analysis,'Visible','on');
set(handles.explo_mult,'Visible','on');
set(handles.save_shapefile_geobia,'Visible','on');
set(handles.segmentation,'Visible','on');
set(handles.up_segments,'Visible','on');
guidata(hObject,handles);

% --------------------------------------------------------------------
function topographic_variables_Callback(hObject,...
    eventdata, handles)% 1 botão: "Topographic Variables".
guidata(hObject,handles);

% --------------------------------------------------------------------
function Compute_NDVI_Callback(hObject, eventdata, handles)
global FileName PathName;
Diretorio = fullfile(PathName,FileName);
RapidEye = GRIDobj(Diretorio);
ORbands =str2double(inputdlg({'Ordem da banda Near - Infravermelho (apenas número):',...
    'Ordem da banda R -  Vermelho (apenas número):'},'Ordem',1,{'5','3'}));
INFR = RapidEye.Z (:,:,ORbands(1));
VERM = RapidEye.Z (:,:,ORbands(2));
NDVI1 = NDVI (INFR,VERM);
global A_NDVI;
A_NDVI = RapidEye;
A_NDVI.Z = NDVI1;
imageschs(A_NDVI,A_NDVI,'colormap',gray);
axis off;
colorbar off;

set(handles.explo_ndvi,'Visible','on');
set(handles.save_variables,'Visible','on');
set(handles.ndvi,'Visible','on');
set(handles.up_ndvi,'Visible','on');
guidata(hObject,handles);

% --------------------------------------------------------------------
function open_dem_Callback(hObject, eventdata, handles)
global FileName1 PathName1;
[FileName1,PathName1] = uigetfile({'*.tif'},...
    'Selecione o MDE');
Diretorio1 = fullfile(PathName1,FileName1);
global A_DEM;
DEM = GRIDobj(Diretorio1);
A_DEM = fillsinks(DEM);
imageschs(A_DEM);
axis off;
colorbar off;


set(handles.up_layer,'Visible','on');
set(handles.explo_dem,'Visible','on');
set(handles.menu_tools,'Visible','on');
set(handles.compute_variables,'Visible','on');
set(handles.save_variables,'Visible','on');
set(handles.up_dem,'Visible','on');
set(handles.dem,'Visible','on');
guidata(hObject,handles);

% --------------------------------------------------------------------
function compute_variables_Callback(hObject, eventdata, handles)
h = waitbar(0,'Processing...');
global A_DEM;
global A_Aspe;
A_Aspe = aspect(A_DEM);
imageschs (A_Aspe);
axis off;

global A_DSin;
A_DSin = gradient8(A_DEM,'sin');
imageschs (A_DSin);
axis off;

global A_CPer;
A_CPer = curvature(A_DEM,'profc');
imageschs(A_CPer,A_CPer,'colormap',gray,'colorbar',false);
axis off;

global A_CPla;
A_CPla = curvature(A_DEM,'planc');
imageschs(A_CPla,A_CPla,'colormap',gray,'colorbar',false);
axis off;

FD = FLOWobj(A_DEM);
global A_FAcc;
A_FAcc = flowacc(FD);
imageschs(A_DEM,dilate(sqrt(A_FAcc),...
    ones(5)),'colormap',flipud(copper));
axis off;

global A_TWI;
A_TWI = twi(A_FAcc,A_DSin);
imageschs(A_TWI);
axis off;

A_DTan = gradient8(A_DEM,'tan');
global A_ICMF
A_ICMF = icmf(A_FAcc,A_DTan);
imageschs(A_ICMF);
axis off;

global A_ICTS;
A_ICTS = icts(A_FAcc,A_DSin);
imagesc(A_ICTS);
axis off;

W = A_FAcc>5000;
S = STREAMobj(FD,W);
global MS;
MS = STREAMobj2mapstruct(S);
imageschs(A_DEM,A_DEM,'colormap',...
    gray,'colorbar',false);
close(h);
geoshow(MS, 'DisplayType','line','Color','red','LineWidth',1.5);
axis off;


set(handles.attributes_segment,'Visible','on');

set(handles.up_aspect,'Visible','on');
set(handles.up_slope,'Visible','on');
set(handles.up_profcurv,'Visible','on');
set(handles.up_plancurv,'Visible','on');
set(handles.up_facc,'Visible','on');
set(handles.up_twi,'Visible','on');
set(handles.up_spi,'Visible','on');
set(handles.up_ls,'Visible','on');
set(handles.up_drainage,'Visible','on');

set(handles.explo_aspect,'Visible','on');
set(handles.explo_slope,'Visible','on');
set(handles.explo_profcurv,'Visible','on');
set(handles.explo_plancurv,'Visible','on');
set(handles.explo_facc,'Visible','on');
set(handles.explo_twi,'Visible','on');
set(handles.explo_spi,'Visible','on');
set(handles.explo_ls,'Visible','on');

set(handles.aspect,'Visible','on');
set(handles.slope,'Visible','on');
set(handles.prof_curvature,'Visible','on');
set(handles.plan_curvature,'Visible','on');
set(handles.f_accumulation,'Visible','on');
set(handles.twi,'Visible','on');
set(handles.spi,'Visible','on');
set(handles.ls,'Visible','on');
set(handles.drainage,'Visible','on');


set(handles.erosion_susceptibility,'Visible','on');
guidata(hObject,handles);

function alter_rgb_ClickedCallback(hObject, eventdata, handles)
global FileName PathName;% Variável global para acessar imagem multiespectral em outras funções.
ln_multi = fullfile(PathName,FileName);
global mulT
mulT = GRIDobj(ln_multi);%Insere imagem na classe GRIDobj.
[s] = plotRGB2(mulT); %Executa função plotRGB2, que gera strutura "s".
NBands = mulT.size (1,3);%Verifica quantas bandas a imagem possui.
for i=1:NBands %Loop para executar linhas da estrutura "s"
    eval ([char(s(i).out) ';']);%Executa linhas da coluna out da estrutura
                                % "s", que separa as bandas da imagem.
    eval (['delete(' (char(39)) (char(s(i).pasta)) (char(39))...
        ');']);%apaga arquivos gerados pela linha anterior da pasta temp. 
end
ORbands =str2double(inputdlg({'R:','G:','B:'},...
    'Cor RGB',1,{'3','2','1'})); %Abre janela de dialogo para escolha de bandas.

cont = 1;
for i=1:3 %Loop que tranforma a resposta da caixa de dialogo em estrutura.
    lis(i).coll = num2str(ORbands(i));
    eval (['B' lis(i).coll '_OBj = mulT;']);
    eval (['B' lis(i).coll '_OBj.Z = B' lis(i).coll ';']);
    eval (['global Ban' num2str(cont) ';'])
    eval (['Ban' num2str(cont) ' = B' lis(i).coll '_OBj;']);
    cont = cont+1;
end

eval(['RGB=cat(3,B' lis(1).coll ',B' lis(2).coll ',B' lis(3).coll...
    ');']); % Empilha as bandas de acordo com escolha da caixa de diálogo.
RGB = uint16(RGB);% define o tipo dos dados de imagem (neste caso 16 bis-RapidEye).
global rgb_aju;
global R;
rgb_aju = imadjust(RGB,stretchlim(RGB),[]);% Equaliza automaticamente a imagem.
mapshow(rgb_aju, R); %Plota a imagem. 
axis off; % desabilita informações dos eixos da plotagem.
guidata(hObject,handles);

function uipushtool8_ClickedCallback(hObject, eventdata, handles)
cla reset;%Limpa tala de plotagem.
axis off;%Limpa exixos da plotagem.
clear global xy;
clear global h;
clear global binary;
clearvars -global;

set(handles.save_rule,'Visible','off');
set(handles.up_mult,'Visible','off');
set(handles.up_segments,'Visible','off');
set(handles.up_ndvi,'Visible','off');
set(handles.up_dem,'Visible','off');
set(handles.up_aspect,'Visible','off');
set(handles.up_slope,'Visible','off');
set(handles.up_profcurv,'Visible','off');
set(handles.up_plancurv,'Visible','off');
set(handles.up_facc,'Visible','off');
set(handles.up_twi,'Visible','off');
set(handles.up_spi,'Visible','off');
set(handles.up_ls,'Visible','off');
set(handles.up_drainage,'Visible','off');
set(handles.up_lep,'Visible','off');
set(handles.geobia,'Visible','off');
set(handles.exploratory_analysis,'Visible','off');
set(handles.explo_mult,'Visible','off');
set(handles.explo_ndvi,'Visible','off');
set(handles.explo_dem,'Visible','off');
set(handles.explo_aspect,'Visible','off');
set(handles.explo_slope,'Visible','off');
set(handles.explo_profcurv,'Visible','off');
set(handles.explo_plancurv,'Visible','off');
set(handles.explo_facc,'Visible','off');
set(handles.explo_twi,'Visible','off');
set(handles.explo_spi,'Visible','off');
set(handles.explo_ls,'Visible','off');
set(handles.menu_tools,'Visible','off');
set(handles.Segmentation_Mult,'Visible','off');
set(handles.Compute_NDVI,'Visible','off');
set(handles.compute_variables,'Visible','off');
set(handles.shape_attributes,'Visible','off');
set(handles.attributes_segment,'Visible','off');
set(handles.fractalDimension,'Visible','off');
set(handles.compacity,'Visible','off');
set(handles.alter_rgb,'Visible','off');
set(handles.save_variables,'Visible','off');
set(handles.dem,'Visible','off');
set(handles.ndvi,'Visible','off');
set(handles.aspect,'Visible','off');
set(handles.slope,'Visible','off');
set(handles.prof_curvature,'Visible','off');
set(handles.plan_curvature,'Visible','off');
set(handles.f_accumulation,'Visible','off');
set(handles.twi,'Visible','off');
set(handles.spi,'Visible','off');
set(handles.ls,'Visible','off');
set(handles.drainage,'Visible','off');
set(handles.up_layer,'Visible','off');
set(handles.save_shapefile_geobia,'Visible','off');
set(handles.segmentation,'Visible','off');
set(handles.attributes_segment_mul_dem_shp,'Visible','off');
set(handles.erosion_susceptibility_shp,'Visible','off');
set(handles.erosion_susceptibility,'Visible','off');
set(handles.obiaclass,'Visible','off');
set(handles.external_tree_shp,'Visible','off');
set(handles.up_external_tree,'Visible','off');
set(handles.up_threshold,'Visible','off');

guidata(hObject,handles);

function erosion_susceptibility_Callback(hObject, eventdata, handles)
global A_DEM;

A_DSin = gradient8(A_DEM,'sin');
A_DTan = gradient8(A_DEM,'tan');
global B_Ddeg;
B_Ddeg = gradient8(A_DEM,'deg');
global A_NDVI;
C_NDVI = A_NDVI;
C_NDVI.georef = A_DEM.georef;
C_NDVI.refmat = A_DEM.refmat;
C_NDVI.size = A_DEM.size;
global A_Aspe;
D_Aspe = A_Aspe;
global A_CPer;
F_CPer = A_CPer;
global A_CPla;
G_CPla = A_CPla;
FD = FLOWobj(A_DEM);
H_FAcc  = flowacc(FD);
global A_FAcc;
H_FAcc = A_FAcc;
% A_DSin = gradient8(A_DEM,'sin');
E_TWI = twi(H_FAcc,A_DTan);
I_ICTS = icts(H_FAcc,A_DSin);
J_ICMF = icmf(H_FAcc,A_DTan);

% Escolha da árvore
[FileName,PathName] = uigetfile({'*.txt'},'Selecione a árvore');
Diretorio = fullfile(PathName,FileName);

f = warndlg({'A árvore de decisão é específica para uma determinada região, caso' 'você queira calcular a susceptibilidade a processos erosivos para' 'outras áreas, verifique a disponibilidade no site: www.erobject.com.br' 'ou entre em contato com geodenilson@gmail.com.' 'Clique em ok para continuar...'},...
    'Atenção!');waitfor(f);

h = waitbar(0,'Processing...');

ARV1 = importdata(Diretorio);
NEle = numel (ARV1);
ARV2=char(ARV1);
contador = 1;
while contador<=NEle;
eval(ARV2(contador,:));
contador = contador+1;
end;
waitbar(1/4,h,sprintf('Processing... %.2f%%',1/4*100));

% Excluindo pixels isolados
VEC1 = ERO.Z;
VEC2 = bwareaopen(VEC1,30);
VEC3 = double (VEC2);
VEC4 = ~im2bw(VEC3,graythresh(VEC3));
VEC5 = bwareaopen(VEC4,50);
VEC6 = double (VEC5);
VEC7 = ~im2bw(VEC6,graythresh(VEC6));
VEC8 = logical (VEC7);
ERO2 = ERO==2;
ERO2.Z = VEC8;
waitbar(2/4,h,sprintf('Processing... %.2f%%',2/4*100));

global Seg_BaatzG 
Seg_BaatzG.georef = A_DEM.georef;
Seg_BaatzG.refmat = A_DEM.refmat;
Seg_BaatzG.size = A_DEM.size;

Mult = ERO2.Z .* Seg_BaatzG.Z;
Seg_BaatzG_Unic = unique(Mult);
ERO_Seg = ismember(Seg_BaatzG.Z, Seg_BaatzG_Unic);
ERO_Seg1 = Seg_BaatzG;
ERO_Seg1.Z = ERO_Seg;
waitbar(3/4,h,sprintf('Processing... %.2f%%',3/4*100));

global SEG2;
% Excluindo segmentos isolados
SEG1 = ERO_Seg1.Z;
SEG2 = bwareaopen(SEG1,30);
SEG3 = double (SEG2);
SEG4 = ~im2bw(SEG3,graythresh(SEG3));
SEG5 = bwareaopen(SEG4,50);
SEG6 = double (SEG5);
SEG7 = ~im2bw(SEG6,graythresh(SEG6));
SEG8 = logical (SEG7);
SEG2 = ERO_Seg1==2;
SEG2.Z = SEG8;

waitbar(4/4,h,sprintf('Processing... %.2f%%',4/4*100));
global Vetor;
Vetor = ERO2Vector(SEG2);
close (h)
%imageschs(A_DEM,A_DEM,'colormap',gray,'colorbar',false);
mapshow(Vetor, 'FaceColor', 'green');
colorbar off;
axis off;
set(handles.up_lep,'Visible','on');
set(handles.erosion_susceptibility_shp,'Visible','on');
guidata(hObject,handles);

function attributes_segment_Callback(hObject, eventdata, handles)

A3 = {'SBaatz','A_DEM','A_Aspe','A_CPer','A_ICMF',...
    'A_ICTS','A_CPla','A_FAcc','A_NDVI','fractalDimension',...
    'compacity','Ban1','Ban2','Ban3','A_TWI'}';
B3 = who('global');
C3 = ismember(A3,B3);
D3 = find(C3==0);
E3 = isempty(D3);
if E3==1
    h = waitbar(0,'Processing...');
    global SBaatz;
    Seg_BaatzG = SBaatz;
    global A_DEM;
    global A_Aspe;
    global A_CPer;
    global A_ICMF;
    global A_ICTS;
    global A_CPla;
    global A_FAcc;
    global A_NDVI;
    global fractalDimension;
    global compacity;
    global Ban1;
    Ban1.georef = A_DEM.georef;
    Ban1.refmat = A_DEM.refmat;
    Ban1.size = A_DEM.size;
    global Ban2;
    Ban2.georef = A_DEM.georef;
    Ban2.refmat = A_DEM.refmat;
    Ban2.size = A_DEM.size;
    global Ban3;
    Ban3.georef = A_DEM.georef;
    Ban3.refmat = A_DEM.refmat;
    Ban3.size = A_DEM.size;
    C_NDVI = A_NDVI;
    C_NDVI.georef = A_DEM.georef;
    C_NDVI.refmat = A_DEM.refmat;
    C_NDVI.size = A_DEM.size;
    global A_TWI;
    A_Ddeg = gradient8(A_DEM,'sin');
    waitbar(1/19,h,sprintf('Processing... %.2f%%',1/19*100));
    Aspe = MeanAtributes(A_Aspe,Seg_BaatzG);
    waitbar(2/19,h,sprintf('Processing... %.2f%%',2/19*100));
    Cper = MeanAtributes(A_CPer,Seg_BaatzG);
    waitbar(3/19,h,sprintf('Processing... %.2f%%',3/19*100));
    Cpla = MeanAtributes(A_CPla,Seg_BaatzG);
    waitbar(4/19,h,sprintf('Processing... %.2f%%',4/19*100));
    Ddeg = MeanAtributes(A_Ddeg,Seg_BaatzG);
    waitbar(5/19,h,sprintf('Processing... %.2f%%',5/19*100));
    DEM = MeanAtributes(A_DEM,Seg_BaatzG);
    waitbar(6/19,h,sprintf('Processing... %.2f%%',6/19*100));
    Facc = MeanAtributes(A_FAcc,Seg_BaatzG);
    waitbar(7/19,h,sprintf('Processing... %.2f%%',7/19*100));
    ICMF = MeanAtributes(A_ICMF,Seg_BaatzG);
    waitbar(8/19,h,sprintf('Processing... %.2f%%',8/19*100));
    ICTS = MeanAtributes(A_ICTS,Seg_BaatzG);
    waitbar(9/19,h,sprintf('Processing... %.2f%%',9/19*100));
    NDVI = MeanAtributes(C_NDVI,Seg_BaatzG);
    waitbar(10/19,h,sprintf('Processing... %.2f%%',10/19*100));
    TWI = MeanAtributes(A_TWI,Seg_BaatzG);
    waitbar(11/19,h,sprintf('Processing... %.2f%%',11/19*100));
    Banda1 = MeanAtributes(Ban1,Seg_BaatzG);
    waitbar(12/19,h,sprintf('Processing... %.2f%%',12/19*100));
    Banda2 = MeanAtributes(Ban2,Seg_BaatzG);
    waitbar(13/19,h,sprintf('Processing... %.2f%%',13/19*100));
    Banda3 = MeanAtributes(Ban3,Seg_BaatzG);
    waitbar(14/19,h,sprintf('Processing... %.2f%%',14/19*100));
    TabfractalDimension = Obj2tableBox(fractalDimension);
    Tabcompacity = Obj2tableBox(compacity);
    waitbar(15/19,h,sprintf('Processing... %.2f%%',15/19*100));
    join = JoinTems(Aspe,Cper,Cpla,Ddeg,DEM,Facc,ICMF,ICTS,NDVI,TWI,...
        TabfractalDimension, Tabcompacity, Banda1, Banda2, Banda3);
    waitbar(16/19,h,sprintf('Processing... %.2f%%',16/19*100));
    shape = OrganizeFild(join);
    waitbar(17/19,h,sprintf('Processing... %.2f%%',17/19*100));
    global struct_final;
    waitbar(18/19,h,sprintf('Processing... %.2f%%',18/19*100));
    struct_final = table2struct(shape);
    waitbar(19/19,h,sprintf('Processing... %.2f%%',19/19*100));
    close (h);
else
    errordlg('You have not calculated all the variables for this function. ','File Error'); 
end
set(handles.attributes_segment_mul_dem_shp,'Visible','on');
guidata(hObject,handles);

function exploratory_analysis_Callback(hObject, ~, handles)

function save_variables_Callback(hObject, eventdata, handles)

function dem_Callback(hObject, eventdata, handles)
global A_DEM;
[FileName,PathName] = uiputfile('digital_elevation_model.tif',...
    'Escolha a pasta para salvar o Modelo Digital de Elevação.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_DEM,Diretorio);
guidata(hObject,handles);

function aspect_Callback(hObject, eventdata, handles)
global A_Aspe
[FileName,PathName] = uiputfile('aspecto.tif',...
    'Escolha a pasta para salvar o Aspecto');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_Aspe,Diretorio);
guidata(hObject,handles);

function slope_Callback(hObject, eventdata, handles)
global A_DEM;
choice = questdlg('Deseja salvar a declividade em qual formato?',...
	'Save Slope', ...
	'Degree','Percent','Percent');
% gravando resposta
switch choice
    case 'Degree'
          resp = 1;
    case 'Percent'
          resp = 2;
end
if resp == 1
	A_Decl = gradient8(A_DEM,'deg');
    [FileName,PathName] = uiputfile('slope_degree.tif',...
    'Escolha a pasta para salvar a Declividade em graus');
else
	A_Decl = gradient8(A_DEM,'per');
    [FileName,PathName] = uiputfile('slope_percent.tif',...
    'Escolha a pasta para salvar a Declividade em pordentagem');
end
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_Decl,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function prof_curvature_Callback(hObject, eventdata, handles)
global A_CPer;
[FileName,PathName] = uiputfile('prof_curvature.tif',...
    'Escolha a pasta para salvar a Curvatura no perfil.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_CPer,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function plan_curvature_Callback(hObject, eventdata, handles)
global A_CPla;
[FileName,PathName] = uiputfile('plan_curvature.tif',...
    'Escolha a pasta para salvar a Curvatura no plano.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_CPla,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function f_accumulation_Callback(hObject, eventdata, handles)
global A_FAcc;
[FileName,PathName] = uiputfile('flow_accumulation.tif',...
    'Escolha a pasta para salvar o Fluxo de Acumulação.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_FAcc,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function twi_Callback(hObject, eventdata, handles)
global A_TWI;
[FileName,PathName] = uiputfile('topographic_wetness_index.tif',...
    'Escolha a pasta para salvar o Índice de Umidade Topográfica.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_TWI,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function spi_Callback(hObject, eventdata, handles)
global A_ICMF;
[FileName,PathName] = uiputfile('stream_power_index.tif',...
    'Escolha a pasta para salvar o Índice de Máximo Fluxo Corrente.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_ICMF,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function ls_Callback(hObject, eventdata, handles)
global A_ICTS;
[FileName,PathName] = uiputfile('length_slope.tif',...
    'Escolha a pasta para salvar o Índice de Capacidade de Tranporte de Sedimentos.tif');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff (A_ICTS,Diretorio);
guidata(hObject,handles);

% --------------------------------------------------------------------
function drainage_Callback(hObject, eventdata, handles)
global A_DEM;
FD = FLOWobj(A_DEM);
A_FAcc = flowacc(FD);
Densidade=str2double(inputdlg({'Densidade da drenagem: quanto MENOR o valor, MAIOR a quantidade de feições de drenagens.'},...
    'Densidade',1,{'5000'}));
W = A_FAcc>Densidade;
S = STREAMobj(FD,W);
MS = STREAMobj2mapstruct(S);
[FileName,PathName] = uiputfile('drainage.shp',...
    'Escolha a pasta para salvar a Drenagem');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(MS,pasta_nome);
guidata(hObject,handles);

% --------------------------------------------------------------------
function save_shapefile_geobia_Callback(hObject, eventdata, handles)
% hObject    handle to save_shapefile_geobia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function segmentation_Callback(hObject, eventdata, handles)
global SRt
[FileName,PathName] = uiputfile('segmentation.shp',...
    'Escolha a pasta para salvar a Segmentação');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(SRt,pasta_nome);
guidata(hObject,handles);

% --------------------------------------------------------------------
function attributes_segment_mul_dem_shp_Callback(hObject, eventdata, handles)
global struct_final;
[FileName,PathName] = uiputfile('seg_atributes_mult_dem.shp',...
    'Escolha a pasta para salvar a Segmentação');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(struct_final,pasta_nome);
guidata(hObject,handles);

% --------------------------------------------------------------------
function erosion_susceptibility_shp_Callback(hObject, eventdata, handles)
global Vetor;
[FileName,PathName] = uiputfile('erosion_susceptibility.shp',...
    'Escolha a pasta para salvar PEL');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
shapewrite(Vetor,pasta_nome);
guidata(hObject,handles);

% --------------------------------------------------------------------
function ndvi_Callback(hObject, eventdata, handles)
global A_NDVI
[FileName,PathName] = uiputfile('normalized_difference_vegetation_index.tif',...
    'Escolha a pasta para salvar o NDVI');
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_NDVI,Diretorio);


% --------------------------------------------------------------------
function shape_attributes_Callback(hObject, eventdata, handles)
h = waitbar(0,'Processing...');
global Seg_BaatzG;
global A_DEM
A = A_DEM;
B = Seg_BaatzG;
props = regionprops(B.Z, A.Z, 'Area');
waitbar(1/5,h,sprintf('Processing... %.2f%%',1/5*100));
allIntensities = [props.Area];
C = zeros(size(B.Z));
for k = 1 : max(B.Z(:));
C(B.Z==k) = allIntensities(k);
end
SEG = A;
SEG.Z = C;
AreaM2 = SEG .* SEG.cellsize .* SEG.cellsize;

props = regionprops(B.Z, A.Z, 'Perimeter');
waitbar(2/5,h,sprintf('Processing... %.2f%%',2/5*100))
allIntensities = [props.Perimeter];
C = zeros(size(B.Z));
for k = 1 : max(B.Z(:));
C(B.Z==k) = allIntensities(k);
end
SEG = A;
SEG.Z = C;
perimetroM = SEG .* SEG.cellsize + 35%;
waitbar(3/5,h,sprintf('Processing... %.2f%%',3/5*100))

global fractalDimension;
fractalDimension = 2 .* ((log(perimetroM ./ 4)) ./ (log(AreaM2)));
waitbar(4/5,h,sprintf('Processing... %.2f%%',4/5*100))

global compacity;
compacity = (perimetroM ./ AreaM2) ./ (sqrt(AreaM2));
waitbar(5/5,h,sprintf('Processing... %.2f%%',5/5*100));

close (h);

set(handles.fractalDimension,'Visible','on');
set(handles.compacity,'Visible','on');

guidata(hObject,handles);


% --------------------------------------------------------------------
function up_mult_Callback(hObject, eventdata, handles)
global rgb_aju;
global R;
mapshow(rgb_aju, R); %Plota a imagem. 
axis off; % desabilita informações dos eixos da plotagem.
guidata(hObject,handles);

function up_segments_Callback(hObject, eventdata, handles)
global SRt;
geoshow(SRt, 'FaceColor', 'none','EdgeColor',...
    'blue');%Plota a segmentação na view exixtente.
guidata(hObject,handles);

function up_ndvi_Callback(hObject, eventdata, handles)
global A_NDVI;
imageschs(A_NDVI,A_NDVI,'colormap',gray);
axis off;
colorbar off;
guidata(hObject,handles);

function up_dem_Callback(hObject, eventdata, handles)
global A_DEM;
imageschs(A_DEM);
axis off;
colorbar off;
guidata(hObject,handles);

function up_aspect_Callback(hObject, eventdata, handles)
global A_Aspe;
imageschs (A_Aspe);
axis off;
colorbar off;
guidata(hObject,handles);

function up_slope_Callback(hObject, eventdata, handles)
global A_DSin;
imageschs(A_DSin,A_DSin,'colormap',gray);
axis off;
colorbar off;
guidata(hObject,handles);

function up_profcurv_Callback(hObject, eventdata, handles)
global A_CPer;
imageschs(A_CPer,A_CPer,'colormap',gray,'colorbar',false);
axis off;
colorbar off;
guidata(hObject,handles);

function up_plancurv_Callback(hObject, eventdata, handles)
global A_CPla;
imageschs(A_CPla,A_CPla,'colormap',gray,'colorbar',false);
axis off;
colorbar off;
guidata(hObject,handles);

function up_facc_Callback(hObject, eventdata, handles)
global A_DEM;
global A_FAcc;
imageschs(A_DEM,dilate(sqrt(A_FAcc),ones(5)),'colormap',...
    flipud(copper));
axis off;
colorbar off;
guidata(hObject,handles);

function up_twi_Callback(hObject, eventdata, handles)
global A_TWI;
imageschs(A_TWI);
axis off;
colorbar off;
guidata(hObject,handles);

function up_spi_Callback(hObject, eventdata, handles)
global A_ICMF;
imageschs(A_ICMF);
axis off;
colorbar off;
guidata(hObject,handles);

function up_ls_Callback(hObject, eventdata, handles)
global A_ICTS;
imagesc(A_ICTS);
axis off;
colorbar off;
guidata(hObject,handles);

function up_drainage_Callback(hObject, eventdata, handles)
global MS;
geoshow(MS, 'DisplayType','line','Color','red','LineWidth',1.5);
guidata(hObject,handles);

function up_lep_Callback(hObject, eventdata, handles)
global Vetor;
mapshow(Vetor, 'FaceColor', 'green');
colorbar off;
axis off;
guidata(hObject,handles);

% --------------------------------------------------------------------
function up_threshold_Callback(hObject, eventdata, handles)
thres = CheckThres;
SRtu_class = ERO2Vector(thres);
mapshow(SRtu_class, 'FaceColor', [0.3 0.5 1]);
colorbar off;
axis off;
guidata(hObject,handles);


% --------------------------------------------------------------------
function up_external_tree_Callback(hObject, eventdata, handles)
global Vetor_tree;
mapshow(Vetor_tree, 'FaceColor', 'none','EdgeColor','red');
colorbar off;
axis off;
guidata(hObject,handles);




function quit_Callback(hObject, eventdata, handles)
cla reset;%Limpa tala de plotagem.
axis off;%Limpa exixos da plotagem.

clearvars -global;
closereq %Fecha o programa.

function explo_mult_Callback(hObject, eventdata, handles)

global mulT
% global Seg_BaatzG
[s] = plotRGB2(mulT); %Executa função plotRGB2, que gera strutura "s".
NBands = mulT.size (1,3);%Verifica quantas bandas a imagem possui.
for i=1:NBands %Loop para executar linhas da estrutura "s"
    eval ([char(s(i).out) ';']);%Executa linhas da coluna out da estrutura
                                % "s", que separa as bandas da imagem.
    eval (['delete(' (char(39)) (char(s(i).pasta)) (char(39))...
        ');']);%apaga arquivos gerados pela linha anterior da pasta temp. 
end
band =str2double(inputdlg({'Image band:'}...
    ,'Order',1,{'1'}));
if band > NBands
cmd1  = ['errordlg(' (char(39)) 'The image has only ' num2str(NBands)...
    ' bands.' (char(39)) ',' (char(39)) 'File Error' (char(39)) ');'];  
eval (cmd1);
end
bandthreshold = ['B' num2str(band)];
cmd3 = ['[low_B' num2str(band) ',hig_B' num2str(band) ',exp_B' num2str(band) '] = AuxCheckThres_Band(' bandthreshold ');'];
eval (cmd3);
cmd5 = ['global exp_B' num2str(band)];
eval (cmd5);
cmd6 = ['global low_B' num2str(band) ';'];
eval (cmd6);
cmd7 = ['global hig_B' num2str(band) ';'];
eval (cmd7);

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_ndvi_Callback(hObject, eventdata, handles)
global A_NDVI;
[low_NDVI, hig_NDVI,exp_NDVI] = AuxCheckThres(A_NDVI);
global exp_NDVI;
global low_NDVI;
global hig_NDVI;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_dem_Callback(hObject, eventdata, handles)
global A_DEM;
[low_DEM, hig_DEM,exp_DEM] = AuxCheckThres(A_DEM);
global exp_DEM;
global low_DEM;
global hig_DEM;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_aspect_Callback(hObject, eventdata, handles)
global A_Aspe;
[low_Aspe, hig_Aspe,exp_Aspe] = AuxCheckThres(A_Aspe);
global exp_Aspe;
global low_Aspe;
global hig_Aspe;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_slope_Callback(hObject, eventdata, handles)
global A_DSin;
[low_DSin, hig_DSin,exp_DSin] = AuxCheckThres(A_DSin);
global exp_DSin;
global low_DSin;
global hig_DSin;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_profcurv_Callback(hObject, eventdata, handles)
global A_CPer;
[low_CPer, hig_CPer,exp_CPer] = AuxCheckThres(A_CPer);
global exp_CPer;
global low_CPer;
global hig_CPer;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_plancurv_Callback(hObject, eventdata, handles)
global A_CPla;
[low_CPla, hig_CPla,exp_CPla] = AuxCheckThres(A_CPla);
global exp_CPla;
global low_CPla;
global hig_CPla;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_facc_Callback(hObject, eventdata, handles)
global A_FAcc;
[low_FAcc, hig_FAcc,exp_FAcc] = AuxCheckThres(A_FAcc);
global exp_FAcc;
global low_FAcc;
global hig_FAcc;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_twi_Callback(hObject, eventdata, handles)
global A_TWI;
[low_TWI, hig_TWI,exp_TWI] = AuxCheckThres(A_TWI);
global exp_TWI;
global low_TWI;
global hig_TWI;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_spi_Callback(hObject, eventdata, handles)
global A_ICMF;
[low_SPI, hig_SPI,exp_SPI] = AuxCheckThres(A_ICMF);
global exp_SPI;
global low_SPI;
global hig_SPI;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function explo_ls_Callback(hObject, eventdata, handles)
global A_ICTS;
[low_LS, hig_LS,exp_LS] = AuxCheckThres(A_ICTS);  
global exp_LS;
global low_LS;
global hig_LS;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function fractalDimension_Callback(hObject, eventdata, handles)
global fractalDimension
[low_FRaD, hig_FRaD,...
    exp_FRaD] = AuxCheckThres(fractalDimension);  
global exp_FRaD;
global low_FRaD;
global hig_FRaD;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);


function compacity_Callback(hObject, eventdata, handles)
global compacity;
[low_Comp, hig_Comp,...
    exp_Comp] = AuxCheckThres(compacity);  
global exp_Comp;
global low_Comp;
global hig_Comp;

set(handles.obiaclass,'Visible','on');
set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);


% --------------------------------------------------------------------
function erosion_Callback(hObject, eventdata, handles)

global SEG2;
[low_SEG2, hig_SEG2, exp_SEG2] = AuxCheckThres(SEG2);  
global exp_SEG2;
global low_SEG2;
global hig_SEG2;

set(handles.save_rule,'Visible','on');
set(handles.up_threshold,'Visible','on');
guidata(hObject,handles);

function obiaclass_Callback(hObject, eventdata, handles)
thres = CheckThres;
[FileName,PathName] = uiputfile('class.shp',...
    'Escolha a pasta para salvar a Class');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.
SRtu_class = ERO2Vector(thres);
shapewrite(SRtu_class,pasta_nome);

guidata(hObject,handles);

function clear_thresholds_Callback(hObject, eventdata, handles)
G_names = who('global');

Index_var1 = strfind(G_names, 'exp_');
Index_var = find(not(cellfun('isempty', Index_var1)));

Index_hig1 = strfind(G_names, 'hig_');
Index_hig = find(not(cellfun('isempty', Index_hig1)));

Index_low1 = strfind(G_names, 'low_');
Index_low = find(not(cellfun('isempty', Index_low1)));

NEle = numel(Index_var);
for i = 1:NEle
    eval (['clear global ' G_names{Index_var(i)}]);
    eval (['clear global ' G_names{Index_hig(i)}]);
    eval (['clear global ' G_names{Index_low(i)}]);
end
set(handles.save_rule,'Visible','on');
guidata(hObject,handles);


% --------------------------------------------------------------------
function About2_Callback(hObject, eventdata, handles)
h = msgbox('Esta e versão 1.0 Beta de ErObject, desenvolvida com o objetivo de possibilitar análise geográfica de imagens de satélite e o uso de Modelos Digitais de Elevação - MDE, apoiada na técnica de análise baseada em objetos, para determinação de áreas com susceptibilidade e localização de processos erosivos lineares.');
guidata(hObject,handles);


% --------------------------------------------------------------------
function save_rule_Callback(hObject, eventdata, handles)
[FileName,PathName] = uiputfile('rules.txt',...
    'Escolha a pasta para salvar a árvore');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.

G_names = who('global');

Index_var1 = strfind(G_names, 'exp_');
Index_var = find(not(cellfun('isempty', Index_var1)));
Index_low1 = strfind(G_names, 'low_');
Index_low = find(not(cellfun('isempty', Index_low1)));
Index_hig1 = strfind(G_names, 'hig_');
Index_hig = find(not(cellfun('isempty', Index_hig1)));

NEle = numel(Index_var);

for i = 1:NEle
    eval (['global ' G_names{Index_var(i)}]);
    eval (['global ' G_names{Index_hig(i)}]);
    eval (['global ' G_names{Index_low(i)}]);
end

fid=fopen(pasta_nome,'a');
fprintf(fid,'PEL=');
hasTextBeenWritten = 0;
for i = 1:NEle
%E = G_names{Index_var(i)}(5:end);
E = G_names{Index_var(i)};
F = num2str((eval(G_names{Index_low(i)})));
G = num2str((eval(G_names{Index_hig(i)})));
if hasTextBeenWritten
fprintf(fid,'&');
end
fprintf(fid, '%s>%s&%s<%s', E, F, E, G');
hasTextBeenWritten = 1;
end

fclose('all');
guidata(hObject,handles);


% --------------------------------------------------------------------
function run_tree_Callback(hObject, eventdata, handles)

G_names = who('global');

Index_var1 = strfind(G_names, 'exp_');
Index_var = find(not(cellfun('isempty', Index_var1)));
Index_low1 = strfind(G_names, 'low_');
Index_low = find(not(cellfun('isempty', Index_low1)));
Index_hig1 = strfind(G_names, 'hig_');
Index_hig = find(not(cellfun('isempty', Index_hig1)));

NEle = numel(Index_var);

NEle = numel(Index_var);
eval (['global ' G_names{Index_var(1)}]);
eval (['global ' G_names{Index_hig(1)}]);
eval (['global ' G_names{Index_low(1)}]);

for i = 2:NEle
    eval (['global ' G_names{Index_var(i)}]);
    eval ([G_names{Index_var(i)} '.refmat =' G_names{Index_var(1)} '.refmat']);
    eval ([G_names{Index_var(i)} '.size =' G_names{Index_var(1)} '.size']);
    eval (['global ' G_names{Index_hig(i)}]);
    eval (['global ' G_names{Index_low(i)}]);
end

[FileName,PathName] = uigetfile({'*.txt'},'Selecione a árvore');
Diretorio = fullfile(PathName,FileName);
ARV1 = importdata(Diretorio);
NEle = numel (ARV1);
ARV2=char(ARV1);
for i = 1:NEle
eval(ARV2(i,:));

global Vetor_tree;
Vetor_tree = ERO2Vector(PEL);
geoshow(Vetor_tree, 'FaceColor', 'none','EdgeColor','red');
colorbar off;
axis off;
set(handles.up_external_tree,'Visible','on');
set(handles.external_tree_shp,'Visible','on');
end;


% --------------------------------------------------------------------
function external_tree_shp_Callback(hObject, eventdata, handles)
global Vetor_tree;

[FileName,PathName] = uiputfile('External_Tree.shp',...
    'Escolha a pasta para salvar o shapefile');% Cria variável de nome do arquivo e diretório.
pasta_nome = fullfile(PathName,FileName); %Une o caminho de salvamento com o nome do arquivo.

shapewrite(Vetor_tree,pasta_nome);

%% Load a DEM into Matlab
%
% TopoToolbox 2 reads the ESRI ascii grid format and single band geotiffs 
% into an instance of GRIDobj. 
%
% *Note that, throughout the use of TopoToolbox, it is assumed that the DEM
% has a projected coordinate system (e.g. UTM WGS84) and that elevation and 
% horizontal coordinates are in meter units.*
%
tic

[FileName,PathName] = uigetfile({'*.tif'},'Selecione o MDE');
Diretorio = fullfile(PathName,FileName);
DEM = GRIDobj(Diretorio);

%%
% Selecionar a imagem Multiespectral

[FileName,PathName] = uigetfile({'*.tif'},'Selecione a imagem RapidEye');
Diretorio = fullfile(PathName,FileName);
RapidEye = GRIDobj(Diretorio);

%% View the DEM
%
% Matlab provides numerous ways to display gridded data (images). Among
% these are |imagesc|, |surf|, |pcolor|, |imshow|, etc. 
% TopoToolbox overwrites only |imagesc| and |surf|

%imagesc(DEM)

%%
% If none of the available visualization functions are what you are looking
% for, you can simply convert your DEM to the standard representation using
% GRIDobj2mat. The function returns two coordinate vectors and a matrix
% with values. Here we crop our DEM to a smaller extent beforehand.

%[Z,X,Y] = GRIDobj2mat(DEM);

%%
% Note: See the help of the function |crop| on other ways to clip your data
% to a desired extent.

%% Export an instance of GRIDobj to the disk
%
% TopoToolbox ships with two functions for writing instances of GRIDobj
% back the hard drive so that they can be read by standard GIS software
% such as ArcGIS etc.

%GRIDobj2geotiff(DEM,'test.tif');

%%
% Note that writing geotiffs is possible without having the mapping toolbox
% available, however, TopoToolbox will then write an image with a tfw-file
% (worldfile). See help |GRIDobj2geotiff| for details.

%% Fill sinks
%
% Often DEMs feature erroneous topographic depressions that should be
% filled prior to flow path computation. You can fill sinks using the
% function |fillsinks|. Note that in some situations it is more appropriate
% to not fill sinks but to carve the DEM which will be shown below (see
% section on FLOWobj).

A_DEM = fillsinks(DEM);

%Escolher pasta para salvar todas as variáveis.
[FileName,PathName] = uiputfile('Variaveis.tif','Escolha a pasta para salvar as variáveis');

%Salvando variável
FileName = 'Modelo Digital de Elevação.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_DEM,Diretorio);

%% FLOWobj and flow related functions
%
% Users of previous versions of TopoToolbox will remember that flow
% direction was stored as a sparse matrix that contained the information of
% the directed acyclic graph of the flow network. TopoToolbox 2 uses a
% novel technique to store flow direction that allows for easy coding and
% fast performance. Flow direction is stored as a new object, |FLOWobj|, an
% instance of which is derived from an existing DEM (instance of
% |GRIDobj|).
%
% Here is a fast way to calculate flow accumulation based on the previously
% sink filled DEM. The flow accumulation grid is dilated a little bit, so
% that flow paths are more easily appreciated in the figure.

FD = FLOWobj(A_DEM);
A_FAcc  = flowacc(FD);
%imageschs(DEM,dilate(sqrt(A_FAcc),ones(5)),'colormap',flipud(copper));

% ou imageschs(DEM,dilate(sqrt(A),ones(5)),'colormap',parula);

%Salvando variável
FileName = 'Fluxo de Acumulação.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_FAcc,Diretorio);

%%
% It may also be interesting to know the distance from each drainage basin
% outlet in upstream direction along the flow network.
%
D = flowdistance(FD);
%imageschs(A_DEM,D);

%% STREAMobj - a class for stream networks
%
% While FLOWobj stores the information on the entire flow network on
% hillslopes and in channels, STREAMobj is a class that is used to analyze 
% the channelized part of the flow network only. The storage strategy is
% very similar to the one of the class FLOWobj.
%
% Again, various methods (functions) are associated with STREAMobj that
% allow for manipulating, plotting and retrieving information on the stream
% network geometry and patterns.
%
% There are various ways to extract the channelized flow network from DEMs.
% In this example we simply use an area threshold.

% calculate flow accumulation
A_FAcc = flowacc(FD);
% Note that flowacc returns the number of cells draining
% in a cell. Here we choose a minimum drainage area of 10000 cells.
W = A_FAcc>5000;
% create an instance of STREAMobj
S = STREAMobj(FD,W);
% and plot it
%plot(S)

%%
% Exportar a rede de fluxo para shapefile

MS = STREAMobj2mapstruct(S);
%shapewrite(MS,'shape.shp')

%Salvando variável
FileName = 'Drenagem.shp';
Diretorio = fullfile(PathName,FileName);
shapewrite(MS,Diretorio);

%%
% Declividade

A_DTan   = gradient8(A_DEM);
A_DSin   = gradient8(A_DEM,'sin');

%Salvando variável
FileName = 'Declividade.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_DTan,Diretorio);

%%
% Curvatura no perfil

A_CPer = curvature(A_DEM,'profc');

%Salvando variável
FileName = 'Curvatura no perfil.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_CPer,Diretorio);

%%
% Curvatura no plano

A_CPla = curvature(A_DEM,'planc');

%Salvando variável
FileName = 'Curvatura no plano.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_CPla,Diretorio);

%%
% Indice de umidade topográfica 

A_TWI = twi(A_FAcc,A_DTan);

%Salvando variável
FileName = 'Índice de Umidade Topográfica.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_TWI,Diretorio);

%%
%Índice capacidade de transporte de sedimentos (Moore and Burch)

A_ICTS = icts(A_FAcc,A_DSin);

%Salvando variável
FileName = 'Índice de Capacidade de Tranporte de Sedmentos.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_ICTS,Diretorio);

%%
%índice corrente de máximo fluxo

A_ICMF = icmf(A_FAcc,A_DTan);

%Salvando variável
FileName = 'Índice de Máximo Fluxo Corrente.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_ICMF,Diretorio);

%% 
%Aspecto

A_Aspe = aspect(A_DEM);

%Salvando variável
FileName = 'Aspecto.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_Aspe,Diretorio);

%%
%NDVI

%[Bandas_RapidEye,x,y] = GRIDobj2mat(RapidEye);
INFR = RapidEye.Z (:,:,5);
VERM = RapidEye.Z (:,:,3);
NDVI1 = NDVI (INFR,VERM);
TT = A_DEM < 1
A_NDVI = TT + NDVI1;

%Salvando variável
FileName = 'NDVI.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_NDVI,Diretorio);

%%
%Normalizando variáveis com intervalos entre 0 e 1 e salvando:

A_DEM_N = normalizar(A_DEM);

mkdir (PathName,'Variaveis_Normalizadas'); % Cria pasta no diretorio pai "PathName"
FileName = 'Variaveis_Normalizadas\A_DEM_N.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(A_DEM_N,Diretorio);

B_DTan = normalizar(A_DTan);

FileName = 'Variaveis_Normalizadas\B_DTan.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(B_DTan,Diretorio);

C_NDVI = normalizar(A_NDVI);

FileName = 'Variaveis_Normalizadas\C_NDVI.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(C_NDVI,Diretorio);

D_Aspe = normalizar(A_Aspe);

FileName = 'Variaveis_Normalizadas\D_Aspe.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(D_Aspe,Diretorio);

E_TWI = normalizar(A_TWI);

FileName = 'Variaveis_Normalizadas\E_TWI.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(E_TWI,Diretorio);

F_CPer = normalizar(A_CPer);

FileName = 'Variaveis_Normalizadas\F_CPer.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(F_CPer,Diretorio);

G_CPla = normalizar(A_CPla);

FileName = 'Variaveis_Normalizadas\G_CPla.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(G_CPla,Diretorio);

H_FAcc = normalizar(A_FAcc);

FileName = 'Variaveis_Normalizadas\H_FAcc.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(H_FAcc,Diretorio);

I_ICTS = normalizar(A_ICTS);

FileName = 'Variaveis_Normalizadas\I_ICTS.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(I_ICTS,Diretorio);

J_ICMF = normalizar(A_ICMF);

FileName = 'Variaveis_Normalizadas\J_ICMF.tif';
Diretorio = fullfile(PathName,FileName);
GRIDobj2geotiff(J_ICMF,Diretorio);

%%
% Bandas da RapdEye
%R = RapidEye.Z (:,:,3);
%G = RapidEye.Z (:,:,2);
%B = RapidEye.Z (:,:,1);

%Rapid_R = R + TT;
%Rapid_G = G + TT;
%Rapid_B = B + TT;

%% Calculando áreas de suceptibilidade a processos erosivos lineares:

% AND1

M11 = and(C_NDVI<=0.561202,B_DTan<=0.059337);
M12 = and(A_DEM_N<=0.218646,C_NDVI<=0.347984);
M13 = C_NDVI<=0.347984;
M21 = and(M11,M12);
AND1 = and(M21,M13);

% AND2

M11 = and(C_NDVI<=0.561202,B_DTan<=0.059337);
M12 = and(G_CPla>0.62124,B_DTan<=0.01912);
AND2 = and(M11,M12);

% AND3

M11 = and(C_NDVI<=0.561202,B_DTan<=0.059337);
M12 = and(G_CPla>0.62124,B_DTan>0.01912);
M13 = D_Aspe<=0.201087;
M21 = and(M11,M12);
AND3 = and(M21,M13);

% AND4

M11 = and(C_NDVI<=0.561202,B_DTan<=0.059337);
M12 = and(G_CPla>0.62124,B_DTan>0.01912);
M13 = and(D_Aspe>0.201087,A_DEM_N<=0.366354);
M21 = and(M11,M12);
AND4 = and(M21,M13);

% AND5

M11 = and(C_NDVI<=0.561202,B_DTan>0.059337);
M12 = C_NDVI<=0.329038
AND5 = and(M11,M12);

% AND6

M11 = and(C_NDVI<=0.561202,B_DTan>0.059337);
M12 = and(C_NDVI>0.329038,I_ICTS<=0.030355);
M13 = and(E_TWI<=0.135604,C_NDVI<=0.426316);
M21 = and(M11,M12);
AND6 = and(M21,M13);

% AND7

M11 = and(C_NDVI<=0.561202,B_DTan>0.059337);
M12 = and(C_NDVI>0.329038,I_ICTS<=0.030355);
M13 = and(E_TWI>0.135604,I_ICTS<=0.007356);
M14 = and(F_CPer<=0.606554,A_DEM_N>0.535359);
M21 = and(M11,M12);
M22 = and(M13,M14);
AND7 = and(M21,M22);

% AND8

M11 = and(C_NDVI<=0.561202,B_DTan>0.059337);
M12 = and(C_NDVI>0.329038,I_ICTS<=0.030355);
M13 = and(E_TWI>0.135604,I_ICTS>0.007356);
M14 = and(A_DEM_N>0.641893,C_NDVI<=0.425818);
M15 = G_CPla>0.507035;
M21 = and(M11,M12);
M22 = and(M13,M14);
M31 = and(M21,M22);
AND8 = and(M31,M15);

% AND9

M11 = and(C_NDVI<=0.561202,B_DTan>0.059337);
M12 = and(C_NDVI>0.329038,I_ICTS>0.030355);
AND9 = and(M11,M12);

% OR

OR11 = or(AND1,AND2);
OR12 = or(AND3,AND4);
OR13 = or(AND5,AND6);
OR14 = or(AND7,AND8);
OR21 = or(OR11,OR12);
OR22 = or(OR13,OR14);
ERO = or(OR21,OR22); 

%%
% Transformando a imagem para vetor

Vetor = ERO2Vector(ERO);

%%
% Salvando Shape de suceptibilidade e processos erisivos:

FileName = 'Areas_sucept_erosao_linear';
Diretorio = fullfile(PathName,FileName);
shapewrite(Vetor,Diretorio)

%%
%Subplot

figure
subplot(3,4,1)
imageschs(A_DEM);
freezeColors;
colorbar off;
title('MDE');
axis off;

subplot(3,4,2)
imshow (A_NDVI.Z);
freezeColors;
title('NDVI');
axis off;

subplot(3,4,3)
imageschs (A_Aspe);
freezeColors;
colorbar off;
title('Aspecto');
axis off;

subplot(3,4,4)
imageschs (A_DSin);
freezeColors;
colorbar off;
title('Declividade');
axis off;

subplot(3,4,5)
imageschs(A_CPer,A_CPer,'colormap',gray,'colorbar',false);
freezeColors;
colorbar off;
title('Curvatura no perfil');
axis off;

subplot(3,4,6)
imageschs(A_CPla,A_CPla,'colormap',gray,'colorbar',false);
freezeColors;
colorbar off;
title('Curvatura no plano');
axis off;

subplot(3,4,7)
imageschs(A_DEM,dilate(sqrt(A_FAcc),ones(5)),'colormap',flipud(copper));
freezeColors;
colorbar off;
title('Fluxo de acumulação');
axis off;

subplot(3,4,8)
imageschs(A_TWI);
freezeColors;
colorbar off;
title('Umidade topográfica');
axis off;

subplot(3,4,9)
imageschs(A_ICMF);
freezeColors;
colorbar off;
title('Força do escoamento');
axis off;

subplot(3,4,10)
imagesc(A_ICTS);
freezeColors;
colorbar off
title('C. Trasporte de sedimentos');
axis off;

subplot(3,4,11)
imageschs(A_DEM,A_DEM,'colormap',gray,'colorbar',false);
mapshow(MS);
freezeColors;
colorbar off;
title('Drenagem');
axis off;

subplot(3,4,12)
imshow(ERO.Z);
freezeColors;
title('Sucep. a erosão linear');
axis off;

clc

toc

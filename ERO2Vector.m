function ERO2Vector = ERO2Vector(A)

% calculate different topographic wetness indices
%            2000)
%Verifivicar

% min(NORM(:)) tem que dar 0
% max(NORM(:)) tem que dar 1


[Vet] = GRIDobj2polygon(A,'Geometry','Polygon')
NEle = numel(Vet);
NLin = (1:NEle)';
contador = 1;
while contador<=NEle;
Vet(contador).Seq = NLin(contador);
contador = contador+1;
end;

ERO2Vector = Vet;

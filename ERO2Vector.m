function ERO2Vector = ERO2Vector(A)

% calculate different topographic wetness indices

[Vet] = GRIDobj2polygon(A,'Geometry','Polygon');
NEle = numel(Vet);
NLin = (1:NEle)';
contador = 1;
while contador<=NEle;
Vet(contador).Seq = NLin(contador);
%Vet(contador).Seq2 = NLin(contador);
contador = contador+1;
end;

ERO2Vector = Vet;
end
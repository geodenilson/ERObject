function Sum_BoundingBox = Sum_BoundingBox(A)

% Soma BoundingBox

NEle = numel(A.Geometry);
contador = 1;
while contador<=NEle;
Vbou = A.BoundingBox{contador};
Disx = Vbou(2)-Vbou(1);
%A.Disx(contador) = Disx;
Disy = Vbou(4)-Vbou(3);
%A.Disy(contador) = Disy;
Xr = (Vbou(2)- Disx);
%A.Xr(contador) = Xr;
Yr = (Vbou(4)- Disy);
%A.Yr(contador) = Yr;

Vert = numel (A.X{(contador),1});
Yrs = num2str(Yr);
Xrs = num2str(Xr);
NVert = num2str(Vert);

XY = [Xrs ' ' Yrs ' ' NVert];
soma = strrep(XY, '.', ',');

A.Chave(contador) = {soma};
contador = contador+1;
end;
Sum_BoundingBox = A;
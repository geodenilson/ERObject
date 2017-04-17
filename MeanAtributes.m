function [Table_Box] = MeanAtributes(A,B)
props = regionprops(B.Z, A.Z, 'MeanIntensity');
allIntensities = [props.MeanIntensity];
C = zeros(size(B.Z));
for k = 1 : max(B.Z(:));
C(B.Z==k) = allIntensities(k);
end
SEG = A;
SEG.Z = C;
[SRt] = GRIDobj2polygon2(SEG,'Geometry','Polygon');
[Mstru] = mstruct2shape(SRt);
Table = struct2table(Mstru);
Table_Box= Sum_BoundingBox(Table);
end
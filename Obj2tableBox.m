function [Table_Box] = Obj2tableBox(A)

[SRt] = GRIDobj2polygon2(A,'Geometry','Polygon');
[Mstru] = mstruct2shape(SRt);
Table = struct2table(Mstru);
Table_Box= Sum_BoundingBox(Table);

end
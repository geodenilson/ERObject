function [Seg_Vec] = mstruct2shape(mstruct)

output = [tempdir 'shp_dell' '.shp'];
shapewrite(mstruct,output);
Seg_Vec = shaperead(output);
output1 = [tempdir 'shp_dell' '.dbf'];
output2 = [tempdir 'shp_dell' '.shx'];
delete (output, output1, output2);

end

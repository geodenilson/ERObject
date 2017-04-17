function [s1] = plotRGB2(A)

NBands = A.size (1,3);

for i=1:NBands
    NameB = ['B',num2str(i)];
    eval([NameB(1:2) '=A.Z(:,:,i);']);
    A1=A;
    eval (['A1.Z=' NameB(1:2) ';']);
    output = [tempdir, NameB(1:2), '.tif'];
    GRIDobj2geotiff(A1,output);
    list1 = {['[' NameB(1:2) ',R]' '=geotiffread ' '(' (char(39)) (output) (char(39)) ')']};
    list(i) = {list1};
    list2 = list';
    field = 'out';
    s1 = cell2struct(list2, field, 2);     
end

for i=1:NBands
    NameB = ['B',num2str(i)];
    output = [tempdir, NameB(1:2), '.tif'];
    s1(i).pasta = (output);
end


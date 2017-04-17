function [A1] = OrganizeFild(A)

A(:,[7 8 9 10 11 12 14 15 16 17 18 20 21 22,...
    23 24 26 27 28 29 30 32 33 34 35 36 38,...
    39 40 41 42 44 45 46 47 48 50 51 52 53,...
    54 56 57 58 59 60 62 63 64 65 66 68 69,...
    70 71 72 74 75 76 77 78 80 81 82 83 84,...
    86 87 88 89 90]) = [];


A.Properties.VariableNames{1} = 'Geometry';
A.Properties.VariableNames{2} = 'BoundingBox';
A.Properties.VariableNames{3} = 'X';
A.Properties.VariableNames{4} = 'Y';
A.Properties.VariableNames{5} = 'ID';
A.Properties.VariableNames{6} = 'exp_Aspe';
A.Properties.VariableNames{7} = 'exp_CPer';
A.Properties.VariableNames{8} = 'exp_CPla';
A.Properties.VariableNames{9} = 'exp_DSin';
A.Properties.VariableNames{10} = 'exp_DEM';
A.Properties.VariableNames{11} = 'exp_FAcc';
A.Properties.VariableNames{12} = 'exp_SPI';
A.Properties.VariableNames{13} = 'exp_LS';
A.Properties.VariableNames{14} = 'exp_NDVI';
A.Properties.VariableNames{15} = 'exp_TWI';
A.Properties.VariableNames{16} = 'exp_FRaD';
A.Properties.VariableNames{17} = 'exp_Comp';
A.Properties.VariableNames{18} = 'exp_B1';
A.Properties.VariableNames{19} = 'exp_B2';
A.Properties.VariableNames{20} = 'exp_B3';

A1 = A;

end
function [A1,B1] = RevmoveDplicados(A,B)

% Remove Duplocados

A_List=setdiff(A.Chave, B.Chave);
B_List=setdiff(B.Chave, A.Chave);

NEle = numel(A_List);
contador = 1;
while contador<=NEle;
A (~cellfun(@isempty, strfind(A.Chave, A_List(contador))), :)=[];
B (~cellfun(@isempty, strfind(B.Chave, A_List(contador))), :)=[];
contador = contador+1;
end;

NEle = numel(B_List);
contador = 1;
while contador<=NEle;
A (~cellfun(@isempty, strfind(A.Chave, B_List(contador))), :)=[];
B (~cellfun(@isempty, strfind(B.Chave, B_List(contador))), :)=[];
contador = contador+1;
end;

A1 = A;
B1 = B;
end
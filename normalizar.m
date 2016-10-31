function NORM = normalizar(A)
% calculate different topographic wetness indices
%            2000)
%Verifivicar

% min(NORM(:)) tem que dar 0
% max(NORM(:)) tem que dar 1


NORM = (A-min(A(:))) ./ (max(A(:)-min(A(:))))

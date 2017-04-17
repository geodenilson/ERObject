function NDVI = NDVI (INFRA1,VERMELHO1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
NDVI=(INFRA1-VERMELHO1)./(INFRA1+VERMELHO1);
end


function [SEG] = gmaNex(Atrib,Baatz)
props = regionprops(Baatz.Z, Atrib, 'MeanIntensity');
allIntensities = [props.MeanIntensity];
C = zeros(size(Baatz.Z));
for k = 1 : max(Baatz.Z(:));
C(Baatz.Z==k) = allIntensities(k);
end
SEG = Baatz;
SEG.Z = C;
end
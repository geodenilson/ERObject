function [SEG] = gmaex(Atrib,Baatz)
props = regionprops(Baatz.Z, Atrib.Z, 'MeanIntensity');
allIntensities = [props.MeanIntensity];
C = zeros(size(Baatz.Z));
for k = 1 : max(Baatz.Z(:));
C(Baatz.Z==k) = allIntensities(k);
end
SEG = Atrib;
SEG.Z = C;
end
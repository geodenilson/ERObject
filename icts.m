function WI = icts(SCA,G)

% calculate different topographic wetness indices
% XXX
G = max(G,0.001);
n  = 1.3;
m  = 0.4;
%WI = ((SCA.*5)/22.13).^m .* (G/0.0896).^n

WI = (m+1)*((SCA.*5)/22.13).^m .* (G/0.0896).^n;
                     
         end

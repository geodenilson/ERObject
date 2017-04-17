function WI = icmf(SCA,G)

% calculate different topographic wetness indices
G = max(G,0.001);
WI = SCA .* G;
                     
end

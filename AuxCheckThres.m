function [low_A, hig_A, exp_A] = AuxCheckThres(A)

global Seg_BaatzG;
G_names = who('global');
Index_var1 = strfind(G_names, 'exp_');
Index_var = find(not(cellfun('isempty', Index_var1)));
NEle = numel(Index_var);

if NEle >=1
    choice = questdlg('Would you like to join the thresholds?', ...
    'Join thresholds', ...
    'No','Yes','No');
    switch choice
    case 'No'
        dessert = 0;
    case 'Yes'
        dessert = 1;
    end
    
    if dessert == 1
        thres = CheckThres_2
        
        thres.refmat = A.refmat
        thres.size = A.size
        
        A_1 = thres .* A;
        exp_A = gmaex(A_1,Seg_BaatzG);
        [low_A, hig_A] = threshold(exp_A.Z);
        
    elseif dessert ==0  
        exp_A = gmaex(A,Seg_BaatzG);
        [low_A, hig_A] = threshold(exp_A.Z);
    end

else
exp_A = gmaex(A,Seg_BaatzG);
[low_A, hig_A] = threshold(exp_A.Z);    
end

end


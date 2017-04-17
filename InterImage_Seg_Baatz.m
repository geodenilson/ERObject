function [Seg_Baatz] = InterImage_Seg_Baatz(FileName,inputImg,canto,comp,cor,scal)

output = [tempdir FileName];

if isdeployed
    Baatz = [ctfroot '\ta_baatz_segmenter\ta_baatz_segmenter.exe'];
else    
    Baatz = [pwd '\ta_baatz_segmenter\ta_baatz_segmenter.exe'];
end

West = canto(1);
North = canto(4);
East = canto(3);
South = canto(2);
cmdstr = sprintf('!%s %s %f %f %f %f "" "tmpdir" "" Baatz "50" "" %f %f %f "0,1,2" "1,1,1" %s "seg" "0.2" "" "" "no"',...
                Baatz,inputImg,West,North,East,South,comp,cor,scal,output);
eval(cmdstr);
ArqTIF = [tempdir FileName '.plm_output.tif'];
Seg_Baatz = GRIDobj(ArqTIF);
dell1 = [tempdir FileName];
dell2 = [tempdir FileName '.plm'];
delete (ArqTIF, dell1, dell2);

end
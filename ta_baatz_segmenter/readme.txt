The following parameters must be set in order to use the program:
1. input_image: path to tif
2. geoWest: west corner
3. geoNorth: north corner
4. geoEast: east corner
5. geoSouth: south corner
6. mask_file: no need to use, leave ""
7. tmpdir: usually "." to create output locally
8. fuzzysets: no need to use, leave ""
9. Baatz: leave "Baatz" so that the algorithm will use the Baatz method
10. euc_treshold: the parameter of euclidean distance between pixels
11. area_min: no need to use, leave ""
12. compactness: start with "0.5" and than change to see the differences
13. baatz_color: start with "0.5" and than change to see the differences
14. scale: tart with "20" and than change to see the differences
15. input_bands: the bands, starting with 0, example "0,1,3" to use first, second and fourth bands
16. input_weights: the weights for each band, from 0 to 1, the amount of weights is equal to the amount of input bands
17. output: file name of the output
18. class: the class name for dbf, used only in debug mode, use "baatz_segmentation" for example
19. reliability: only for interimage, use "1.0"
20. blank parameter, leave ""
21. blank parameter, leave ""
22. use_optmization: if "yes" will divide the image into blocks to divide the segmentation.

example of use:

ta_baatz_segmenter "multi.tif" "406584.000000" "7431978.000000" "408186.000000" "7430776.000000" "" "." "" Baatz "200" "" "0.5" "0.5" "20" "0,1,2" "1,1,1" output "baatz_segmentation" "1.0" "" "" "no"

will generate the file output.plm_output.tif, with the segmentation. pixels with same label define each region. you can use gdal vectorizer to create a shapefile with the segmentation.
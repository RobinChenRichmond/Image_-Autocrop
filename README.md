# Image_Autocrop

This is an autocrop preprocessiong algorithm runs in matlab environment.

Prerequisite: to test the actual improvement of accuracy of dataset, you need to install the vlfeat toolbox and then run phow_caltech 101 on both datasets(before and after autocrop).

This algorithm works in a more straight forward way than the image division algorithm. Just runs the autocrop and the results will be saved in the given path. Attention: You need to create all folders for the outputs. There’re 3 steps in this algorithm: the first step removes most of the pixels in the background by the definition, the second step makes a copy of the image, changes the copy into binary image, and gets the largest area, and the third step gets the needed boundary parameters from the binary and uses these parameters to crop the target in the original image.

There’re some parameters need to be changed because of the change of situations. Most of the parameters are path, but user may also need to change the definition of the pixels they want to remove in the first step. For example, if most of the part of background is red, the user may remove the pixel if the red value in this pixel is larger than some ratio of green value and blue value.

There are also two optional files of codes called autocrop_refinement and secondcrop. They are used to crop the unsuccessfully cropped images a second time, and users can further improve the output by running autocrop_refinement. Users also need to change the definition of some pixels need to remove and path of folder in the autocrop_refinement file. The secondcrop file is just a helper method and users do not need to modify it.

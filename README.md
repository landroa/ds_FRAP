# FRAP
For dendritic spine FRAP analysis


Running MATLAB code: 
First, load both curvefit and tif_file_processing in MATLAB 2020 with the CurveFitting Toolbox Add-On. Using FIJI, open a linescan .tif file from a FRAP trial. Adjust the image brightness using the "auto" button, only once. Perform mean filtering with an average pixel ct. of 2.0. Then, using transform, shift the image 90 degrees to the left and use the rectangle tool to draw the spine ROI. Following this, plot the profile of the FRAP ROI and save all data to a csv file appropriate titled for the trial. 

Adjust the 'load' function in tif_file_processing for the file and then adjust the time vector for the trial time and fluorescence intensity vector length. 

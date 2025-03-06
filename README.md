<p align="center">
  <img src="https://github.com/MarcoMustacchi/MarcoMustacchi.github.io/blob/main/assets/img/icons/UniPD_logo.svg" width="150">
</p>

<h1 align="center">Computer Vision - Laboratory Activities <br> UniPd</h1>

## Build
Clone this repository
```
git clone https://github.com/MarcoMustacchi/ComputerVision
cd ComputerVision
cd Lab1
```

Execute the following commmands
```
mkdir build
cd build
cmake ..
make
```

## Run
```
./Lab1
```
## Lab Homeworks
<table>
<tr>
<th> Lab 1 - Intro to OpenCV </th>
<th> Lab 2 - Filters and Histogram </th>
<th> Lab 3 - Mouse Callback </th>
<th> Lab 4 - Edge Detection </th>
</tr>
<tr>
<td width="25%">
<ul>
  <li>OpenCV Hello World</li>
  <li>Dealing with the image channels and Chessboard creation</li>
  <li>Rotation and affine transform</li>    
</ul>
</td>
  
<td width="25%">
<ul>
  <li>Gray-scale convertion</li>
  <li>Implementation of max/min, Median and Gaussian filters</li>
  <li>Image histogram and histogram equalization</li>    
</ul>
</td>
  
<td width="25%">
<ul>
  <li>Callback functions on mouse click</li>
  <li>Image segmentation and mask</li>
  <li>Change image's colors using mask</li>    
</ul>
</td>
  
<td width="25%">
<ul>
  <li>Canny edge detector and trackbars</li>
  <li>Hough transform for lines</li>
  <li>Road sign detection with Hough circular transform</li>
</ul>
</td>
</tr>
  
<tr>
<th> Lab 5 - Segmentation </th>
<th> Lab 6 - Image Matching </th>
<th> Lab 7 - Image Stitching </th>
<th> Lab 8 - Camera Calibration </th>
</tr>
<tr>
<td width="25%">
<ul>
  <li>Otsu's optimal threshold (Histogram based)</li>
  <li>Region growing method and Watershed transformation</li>
  <li>Clustering color based methods</li>
</ul>
</td>
  
<td width="25%">
<ul>
  <li>Evaluating features on images</li>
  <li>Matching features between images</li>
  <li>Compare images' content using different matching strategy</li>
</ul>
</td>
  
<td width="25%">
  <ul>
  <li>Creation of a panorama by merging together a set of images</li>
  <li>Cylindrical projection and SIFT feature extraction</li>
  <li>Brute force matcher and findHomography() function</li>
</ul>
</td>
  
<td width="25%">
<ul>
  <li>Get calibration images using a camera</li>
  <li>Calibrates the camera using the points of the pattern</li>
  <li>Undistorts and rectifies new images</li> 
</ul>
</td>
</tr> 
  
</table>

## Computer Vision - Summer Project
<a href="https://github.com/MarcoMustacchi/ComputerVision/raw/master/Project/CV_project_summer_2022.pdf">📄Task</a>
<a href="https://github.com/MarcoMustacchi/ComputerVision/raw/master/Project/ComputerVision_ProjectReport_Mustacchi_Rizzetto_Violin.pdf">📄Report</a>

#### Human hands detection and segmentation - Result example
<p align="center">
  <img src="https://github.com/MarcoMustacchi/ComputerVision/blob/master/Project/Dataset/rgb/07.jpg" width="32%"/> <img src="https://github.com/MarcoMustacchi/ComputerVision/blob/master/Project/results/resultsDetection/Color/07.jpg" width="32%"/> <img src="https://github.com/MarcoMustacchi/ComputerVision/blob/master/Project/results/resultsSegmentation/Color/07.jpg" width="32%"/> 
</p>


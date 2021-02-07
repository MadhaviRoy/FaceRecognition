## Development and implementation of real time face recognition systems


Face plays a major role in defining one’s identity and emotions as well. We humans have a fantastic ability to recognise and differentiate hundreds of familiar faces even after years at a glance, despite of changes in lightning conditions, expressions, age or hairstyle. This ability of humans has motivated both philosophers and scientists to understand the encoding and decoding of faces in human brain.
	Face recognition has a variety of applications like criminal identification, security system, image and film processing, human machine interaction etc. Now-a-days, cameras come with built in functions for detecting faces and even expressions. Face detection is also required in film making for image enhancement applications.
	A lot of work has been done and is still in progress to approach this problem.
  Here We design and implement a GUI based face recognition system capable of detecting faces in live acquired images and recognising the detected faces. The designed system should detect, extract and recognize frontal faces from live images acquired in sufficient daylight.
  The overall system contains four blocks : Image Acquisition block, Face Detection Block, FaceRecognision block and Person Identity block. 
  
   
### Image Acquisition block

	This block is the first step in face recognition system applications as it provides the input to the system. It triggers the integrated camera (or a externally attached) via frame grabber. Snapshot function from MATLAB’s image acquisition toolbox [2] is used to serve the purpose. This image is the provided to the face detection block.
	
### Face Detection Block:

	Face detection performs locating and extracting face image operations for face recognition system.
Skin color segmentation is applied as a first step for face detection, as it
reduces computational time for searching whole image. While segmentation is
applied, only segmented region is searched weather the segment includes any face or not.
the RGB image is first converted into HSV and YCbCr both the color spaces [3][]. The YCbCr space segments
the image into a luminosity component and color components, whereas an HSV spacedivides the image into the three components of hue, saturation and color value. The effect of luminosity can be reduced as we ignore the Y component in further processing. 
The following conversions are used to convert the RGB image into YCbCr [3]
 Y = 0.257* R + 0.504* G + 0.098 * B + 16
cb =  0.148* R - 0.291* G + 0.439 * B + 128
 cr =  0.439 * R - 0.368* G -0.071 * B + 128
The Original image is also converted into HSV image as hue value is further used for thresholding. It uses a MATLAB inbuilt function rgb2hsv for conversion.
Thresholding was performed using a combination of  Cb, Cr and hue values produced better results for segmentation. The following relation was used for thresholding:
120<=Cr<=195
140<=Cb<=195
0.01<=hue<=0.1
The thresholding operation is so performed that the pixel satisfying the criteria is assigned a value 1 otherwise its kept 0, thereby producing a binary image.
As it is evident from the results of thresholding, that black region appears at eyes and some other parts of face as well. So a series of morphological operations are performed to erase those blocks. A structural element of size 30-by-30 is used for the closing operation. The morphological close operation is a dilation followed by an erosion, using the same structuring element for both operations.The connected regions are separated using a area open operation. Now the binary image is multiplied with the original image to extract the required region from the original image. 
Finally the obtained region is verified to be a face or not. This is done using Maximally Stable Extremal Regions (MSER) algorithm in MATLAB. The MSER detector incrementally steps through the intensity range of the input image to detect stable regions. The x-y co-ordinates of the centroid of above region is obtained using the following
x=regions.Centroid(1,1) 
y=regions.Centroid(1,2) 
Finally the region of size 180-by-120 is cropped. This region can be used for training or for testing (recognition purpose) depending on the user input from GUI. If user selects it to be a training image, a copy of this cropped image is automatically saved in the train database with the consecutive serial number.jpg as its name, (for example 50.jpg if the last image saved was 49.jpg)
### Face Recognition 
The detected face now needs to be identified, and this part is called face recognition. Various methods as discussed in the literature survey, can be used to accomplish the task, like neural networks, Template matching,Facial feature based approach, model based approach etc. In this work we choose information theory based approach due to its simplicity and reliability. Here,we extract the information content in the face by capturing the variations in the collection of face images, encode it efficiently and compare it with the face models encoded similarly. 
	Therefore, we wish to find Principal Components of the distribution of faces or eigenvectors of covariance matrix of the set of face images. The eigenvectors can be thought of as a set of features that together characterize the variation between face images. Each image location contributes to each eigen vector, which form a ghostly face called eigenface. Each eigenface deviated from uniform gray where some facial feature differs among  the set of training faces,forming a map of variation between the faces. Each face can be represented exactly in terms of linear combination of eigen faces. 








### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.

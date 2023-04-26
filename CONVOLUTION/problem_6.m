% % Problem 6a
img = imread('board.tif');
imshow(img);
imgex = imcrop(img,[200,90,300,180]); % cropping image using rectangular block
figure();
imshow(imgex);
title('problem 6a extracted image');

profile on
% problem 6b(i) converting rgb to grayscale using loop
tic % used for calculating elapsed time can be seen in the command line
img1 = imread('board.tif');
R =0;
G =0;
B =0;
imgsize = size(img1); % finding dimension of image
grayScale = zeros(imgsize(1),imgsize(2)); 

for i= 1:imgsize(1)
    for j = 1:imgsize(2)
       R = img1(i,j,1);
       G = img1(i,j,2);
       B = img1(i,j,3);
       grayval = int32((R+G+B)/3); % taking average value of R,G,B as grayscale value
       grayScale(i,j)=(grayval); %assigning values       
    end       
end
figure();
imshow(grayScale);
title('6b{i} grayscale using loop');
toc % used for calculating elapsed time can be seen in the command line

% problem 6b(ii) converting rgb to grayscale using matrix operation 
tic
imgray1 = (img1(:,:,1)+img1(:,:,2)+img1(:,:,3)/3); % averaing R,G<B using matrix operation
figure();
imshow (imgray1)
title('6b (ii) grayscale using matrix operation');
toc

% %problem 6b (iii) converting rgb to grayscale using matlab function
tic
img1 = imread('board.tif');
imggray = rgb2gray(img1); % matlab function
figure();
imshow (imggray);
title('6b (iii) grayscale using matlab function');
toc



% %problem 6c (i) converting grayscale to binary using loop 

tic
img1 = imread('board.tif');
imggray = rgb2gray(img1); %converting image to grayscale
thresh = mean(imggray,'all'); % calculating threshold using cumulative mean value 
imsize = size(imggray); % finding dimension of image
binary =zeros(imsize(1),imsize(2)); % creating canvas

for i= 1:imsize(1)
    for j= 1:imsize(2)
        if imggray(i,j) >= thresh  % if pixel value is greater than threshold
            binary(i,j) = 1; % then assign 1
        else
            binary(i,j) = 0;
        end
    end
end
figure, subplot(1,2,1)
imshow(imggray), axis off
title('6c (i) grayscale image');
subplot(1,2,2)
imshow(binary), axis off
title('6c (i) binary image');
toc


% %problem 6c (ii)  converting image to binary using matrix operation

tic
img1 = imread('board.tif');
imggray = rgb2gray(img1);
binaryimg=imggray>=mean(imggray,"all");
figure, subplot(1,2,1)
imshow(imggray), axis off
title('6c (ii) grayscale image');
subplot(1,2,2)
imshow(binaryimg), axis off
title('6c (ii) binary image');
toc

%problem 6c (iii) converting image to binary using matlab function

tic
img1 = imread('board.tif');
imggray = rgb2gray(img1);
binaryim = im2bw(imggray,0.5); %converting grayscale to binary using 0.5 threshhold
figure, subplot(1,2,1)
imshow(imggray), axis off
title('6c (iii) grayscale image');
subplot(1,2,2)
imshow(binaryim), axis off
title('6c (iii) binary image');
toc
profile viewer;
%  problem 6d (i) applying averaging filter using loop

img1 = imread('board.tif');
ws =7; %window size is 7

imgsize = size(img1);
imggray = rgb2gray(img1);
smoothedimg = zeros(imgsize(1),imgsize(2)); % creating a canvas
imgd= im2double(img1);
r = 0; %actual pixel index row
c = 0;  %actual pixel index column

for i= 1:imgsize(1)
    for j = 1:imgsize(2)
        total = int32(0);
        for x = -3:3 % -3 to 3 is 7 pixels
            for y = -3:3 % -3 to 3 is 7 pixels
                r = i+x;
                c = j+y;
                if r < 1 || r > imgsize(1) || c < 1 || c > imgsize(2) % if the index is invalid 
                    total = total + int32(imggray(i, j)); % take the original center pixel
                else
                    total = total + int32(imggray(r, c));
                end
            end
        end
        total = int32(total / (ws*ws));
        smoothedimg(i,j) = (total);
    end
end
mean(smoothedimg,'all');
figure();
imshow(uint8(smoothedimg));
title('6d{i} using for loop');

% %  problem 6d (ii) using matlab function conv2
img1 = imread('board.tif'); 
imggray= rgb2gray(img1); 
filter = ones(7,7)/49; % creating the 7 x 7 filter

imgfil = conv2(imggray,filter,'same'); % applying filter using conv2 function 
figure();
imshow(uint8(imgfil));
title('6d(ii) using conv2 function');


% % extra credit

img1 = imread('10.jpg');
originalsize = dir('10.jpg').bytes; %finding the original image size
imggray= double(rgb2gray(img1)); %converting image to grayscale
figure();
imshow(uint8(imggray));
title(' Extra credit Original Image')
[U,S,V] = svd(imggray); %applying svd approximation
compressionratio =[]; 
relativeerror=[]; 
x = [3,10,20,40]; % singular top values of the image
for sval = x 
    newS = S; %reseting S
    newS(sval+1:end,sval+1:end)=0; 
    compimg = U*newS*V'; % getting compressed image
    compimg1 = compimg/255;
    figure();
    imshow(compimg1);
    title('Extra credit compressed images');
    filename = 'temp.jpg';
    imwrite(compimg1,filename); % storing newly compressed file 
    fileinfo = dir(filename);  % finding the image size of compressed images
    compsize = fileinfo.bytes;
    compratio = (compsize/originalsize)*100; % calculating comparison ratio
    compressionratio(end+1) = compratio;
    abserror = abs(imggray - compimg); % calculating absolute error
    relerror = abs(abserror/imggray);  % calculating relative error
    rele = norm(relerror, 2);  % normalization using 2-norm
    relativeerror(end+1) = rele;
end

mltable = table(relativeerror,compressionratio)


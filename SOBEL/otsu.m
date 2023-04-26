clc, clear all, close('all');
% Read Image
Img = imread('umbrella_woman.jpg');
[rows,cols,dims] = size(Img);
% If RGB convert it to gray
Img = rgb2gray(Img);
Img = double(Img);
%covert to 8 bit
Img = uint8(255 * (Img - min(Img(:))) / (max(Img(:)) - min(Img(:))));
% Display Original Image
figure, imagesc(Img);title('Original Image'),axis off, axis image, colormap(gray);

[Frequency,bins] = imhist(Img);
% Compute Global mean
mg = mean(Img(:));
% Let the threshold value varies from k = 0 to 255
Classvariance = zeros(1,256);
Goodness = Classvariance;
NormalizedFreq = Frequency / (rows * cols);

SigmaGlobal = var(double(Img(:)));
% We are starting from k 1 till 254 because at k=0, P1 = 0 and at k = 255,
% P1 = 1 therefore P2 = 1 - P1 = 0;
for k = 1:255-1
    P1 = sum(NormalizedFreq(1:k+1));
    mk = sum((NormalizedFreq(1:k+1) .* (0:k)')); 
    Classvariance(k+1) = (mg * P1 - mk)^2 / (P1 * (1 - P1));
    Goodness(k+1) = Classvariance(k+1) / SigmaGlobal;
end

[~,index]= max(Classvariance);


string = sprintf('Thresholded Image with k = %d ',index);
figure,imagesc(Img>index);title(string);axis off, axis image,colormap(gray);

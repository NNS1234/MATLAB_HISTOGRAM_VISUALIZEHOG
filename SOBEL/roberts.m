% MATLAB Code | Robert Operator from Scratch 
  
% Read Input Image 
input_image = imread('umbrella_woman.jpg'); 
  
% Displaying Input Image 
input_image = uint8(input_image); 
figure, imshow(input_image); title('Input Image'); 
  
% Convert the truecolor RGB image to the grayscale image 
input_image = rgb2gray(input_image); 
  
% Convert the image to double 
input_image = double(input_image); 
  
% Pre-allocate the filtered_image matrix with zeros 
filtered_image = zeros(size(input_image)); 
[r,c] = size(input_image);
n_direction = zeros(size(input_image));   
% Robert Operator Mask 
Mx = [1 0; 0 -1]; 
My = [0 1; -1 0]; 
  
% Edge Detection Process 
% When i = 1 and j = 1, then filtered_image pixel   
% position will be filtered_image(1, 1) 
% The mask is of 2x2, so we need to traverse  
% to filtered_image(size(input_image, 1) - 1 
%, size(input_image, 2) - 1) 
for i = 1:size(input_image, 1) - 1 
    for j = 1:size(input_image, 2) - 1 
  
        % Gradient approximations 
        Gx = sum(sum(Mx.*input_image(i:i+1, j:j+1))); 
        Gy = sum(sum(My.*input_image(i:i+1, j:j+1))); 
                 
        % Calculate magnitude of vector 
        filtered_image(i, j) = sqrt(Gx.^2 + Gy.^2); 
        n_direction(i,j) = atan2(Gy,Gx);
        n_direction(i,j) = n_direction(i,j)*(180/pi);
         
    end
end
 n_direction_dis = zeros(r-2,c-2);
for i = 1:r-2
    for j = 1:c-2
        if ((n_direction(i, j) > 0 ) && (n_direction(i, j) < 22.5) || (n_direction(i, j) > 157.5) && (n_direction(i, j) < -157.5))
            n_direction_dis(i, j) = 0;
        end
        
         if ((n_direction(i, j) > 22.5) && (n_direction(i, j) < 67.5) || (n_direction(i, j) < -112.5) && (n_direction(i, j) > -157.5))
            n_direction_dis(i, j) = 45;
        end
        
        if ((n_direction(i, j) > 67.5 && n_direction(i, j) < 112.5) || (n_direction(i, j) < -67.5 && n_direction(i, j) > 112.5))
            n_direction_dis(i, j) = 90;
        end
        
        if ((n_direction(i, j) > 112.5 && n_direction(i, j) <= 157.5) || (n_direction(i, j) < -22.5 && n_direction(i, j) > -67.5))
            n_direction_dis(i, j) = 135;
        end
    end
end

n_direction_dis= uint8(n_direction_dis); 
figure, imshow(n_direction_dis); title('gradient direction');

% Displaying Filtered Image 
filtered_image = uint8(filtered_image); 
figure, imshow(filtered_image); title('roberts filter'); 
  
% Define a threshold value 
thresholdValue = 15; % varies between [0 255] 
output_image = max(filtered_image, thresholdValue); 
output_image(output_image == round(thresholdValue)) = 0; 
  
% Displaying Output Image 
output_image = imbinarize(output_image); 
figure, imshow(output_image); title('after thresholding roberts'); 
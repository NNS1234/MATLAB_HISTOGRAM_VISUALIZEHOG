% Read Input Image 
input_image = imread('umbrella_woman.jpg'); 
input_image=imgaussfilt(input_image);
  
% Displaying Input Image 
input_image = uint8(input_image); 
figure, imshow(input_image); title('Input Image'); 
  
% Convert the truecolor RGB image to the grayscale image 
input_image = rgb2gray(input_image); 
  
% Convert the image to double 
input_image = double(input_image);
%for calculating direction ;Pre-allocate the matrix with zeros 
[r,c] = size(input_image);
n_direction = zeros(size(input_image));  
% Pre-allocate the filtered_image matrix with zeros 
filter_image = zeros(size(input_image)); 
  
% prewit Operator Mask 
M_x = [-1 0 1; -1 0 1; -1 0 1]; 
M_y = [-1 -1 -1; 0 0 0; 1 1 1];  
% When i = 1 and j = 1, then filter_image pixel   
% position will be filter_image(2, 2) 
% The mask is of 3x3, so we need to traverse  
% to filter_image(size(input_image, 1) - 2 
%, size(input_image, 2) - 2) ,so we are not considering borders

for i = 1:size(input_image, 1) - 2 
    for j = 1:size(input_image, 2) - 2 
  
        % Gradient calculation 
        Gx = sum(sum(M_x.*input_image(i:i+2, j:j+2))); 
        Gy = sum(sum(M_y.*input_image(i:i+2, j:j+2))); 
                 
        % Calculate magnitude of vector 
        filter_image(i, j) = sqrt(Gx.^2 + Gy.^2); 
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
filter_image = uint8(filter_image); 
figure, imshow(filter_image); title('prewitt filter'); 
  
% Define a threshold value 
thresholdValue = 70; % varies between [0 255] 
output_image = max(filter_image, thresholdValue); 
output_image(output_image == round(thresholdValue)) = 0; 
  
% Displaying Output Image 
output_image = imbinarize(output_image); 
figure, imshow(output_image); title('After threshold prewitt edge detection'); 
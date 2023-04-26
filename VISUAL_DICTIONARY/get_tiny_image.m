%nudrat saber
%1001733394
function [feature] =  get_tiny_image(I,output_size)
%zeros 
feature=zeros(output_size);
%RESIZE 
res = imresize(I,output_size);
%RESHAPE
shp = reshape(res,output_size(1),output_size(2));
%subtracted by its mean and divided by its norm to get the mean to zero and length to a unit
avg=mean(shp);
feature=(double(shp)-avg)/(sqrt(sum(shp.*shp)));

end


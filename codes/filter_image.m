%nudrat nawal saber
%1001733394
function[im_dx, im_dy] = filter_image(im)


[m,n]=size(im);

filter_x=[-1 0 1]; 
filter_y=filter_x' ;
paddedImage=zeros(m+2, n+2);
for i=1: m
    for j=1:n
        paddedImage(i+1,j+1)=im(i,j);

    end
end  


 [padded_m, padded_n]=size(paddedImage);

 im_dx=zeros(m,n);
 im_dy=zeros(m,n);


for i=2:padded_m-1
    for j=2:padded_n-1
        im_dx(i-1,j-1)=sum(sum(filter_x.*paddedImage(i-1:i+1,j-1:j+1)));
        im_dy(i-1,j-1)=sum(sum(filter_y.*paddedImage(i-1:i+1,j-1:j+1)));
      
    end
end

%figure(1);
%imshow(im_filtered_x);
%figure(2);
%imshow(im_filtered_y);



end


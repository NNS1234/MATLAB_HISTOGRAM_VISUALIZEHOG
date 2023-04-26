%nudrat nawal saber
%1001733394
function [hog]=HOG(im) 
figure(1), imshow(im);title('input image');
inputImage=rgb2gray(im);
inputdouble=im2double(inputImage);

[im_dx, im_dy] = filter_image(inputdouble);

figure(2);
imagesc(im_dx);title('differential along x');
figure(3);
imagesc(im_dy);title('differential along y');
[grad_mag,grad_angle]=  get_gradients(im_dx,im_dy);
figure(4), imagesc(grad_mag); title('gradient magnitude');
figure(5), imagesc(grad_angle);title('gradient angle');

[m,n,p]=size(im);
[x,y]=meshgrid(1:2:n,1:2:m);

figure; imshow(inputImage); hold on;title('gradients at every 3rd pixel'); 
q=quiver(x,y,im_dx(1:2:m,1:2:n),im_dy(1:2:m,1:2:n));
q.AutoScaleFactor = 3;
q.ShowArrowHead = 'off';
q.Color='r';
q.LineWidth=2;

cell_size=8;
block_size=3;
[ori_hist]=build_histogram(grad_mag,grad_angle,cell_size);

[ori_histo_normalized]=get_block_descriptor(ori_hist,block_size);

hog=zeros(size(ori_histo_normalized,1)*size(ori_histo_normalized,2)*size(ori_histo_normalized,3),1);
dim3=size(ori_histo_normalized,3);
k=1;
for i=1: size(ori_histo_normalized,1)
    for j=1: size(ori_histo_normalized,2)
        temp = permute(ori_histo_normalized(i,j,:),[3 2 1]);
        hog((k-1)*dim3 +1: dim3*k)=temp;
        k=k+1;
        
    end
end
[HOGoutput]= VisualizeHOG(ori_hist,im);
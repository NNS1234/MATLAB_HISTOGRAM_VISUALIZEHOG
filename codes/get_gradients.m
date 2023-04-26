%nudrat nawal saber
%1001733394
function [grad_mag,grad_angle]=  get_gradients(im_dx,im_dy)
[m ,n]=size(im_dx);
grad_mag= zeros(m,n);
grad_angle=zeros(m,n);

for i=1:m
    for j=1:n
        grad_mag(i,j)=sqrt(im_dx(i,j)*im_dx(i,j)+ im_dy(i,j)* im_dy(i,j));
        grad_angle(i,j)=atan2d(im_dy(i,j),im_dx(i,j));
        if grad_angle(i,j)<0
            grad_angle(i,j)=180+grad_angle(i,j);
        end
        if grad_angle(i,j)==180
            grad_angle(i,j)=0;
        end
    end
end


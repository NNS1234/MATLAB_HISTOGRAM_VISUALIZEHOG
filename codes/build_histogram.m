%nudrat nawal saber
%1001733394
function [ori_hist]=build_histogram(grad_mag,grad_angle,cell_size)
[m,n]=size(grad_mag);
M=floor(m/cell_size);
N=floor(n/cell_size);
ori_hist= zeros(M,N,6);
for i=1:M
    for j=1:N
        for indicesx= cell_size*(i-1)+1:cell_size*i
            for indicesy= cell_size*(j-1)+1:cell_size*j
                
        if (grad_angle(indicesx,indicesy)>=0 && grad_angle(indicesx,indicesy)<15)  ||  (grad_angle(indicesx,indicesy)>=165 && grad_angle(indicesx,indicesy)<180)
            ori_hist(i,j,1)=ori_hist(i,j,1)+grad_mag(indicesx,indicesy);
        end    
             if (grad_angle(indicesx,indicesy)>=15)&&(grad_angle(indicesx,indicesy)<45)
             ori_hist(i,j,2)=ori_hist(i,j,2)+grad_mag(indicesx,indicesy);
             end
             if (grad_angle(indicesx,indicesy)>=45) && (grad_angle(indicesx,indicesy)<75)
             ori_hist(i,j,3)=ori_hist(i,j,3)+grad_mag(indicesx,indicesy);
             end
             if (grad_angle(indicesx,indicesy)>=75) && (grad_angle(indicesx,indicesy)<105)
             ori_hist(i,j,4)=ori_hist(i,j,4)+grad_mag(indicesx,indicesy);
             end
             if (grad_angle(indicesx,indicesy)>=105) && (grad_angle(indicesx,indicesy)<135)
            ori_hist(i,j,5)=ori_hist(i,j,5)+grad_mag(indicesx,indicesy);
             end
             if (grad_angle(indicesx,indicesy)>=135) && (grad_angle(indicesx,indicesy)<165)
            ori_hist(i,j,6)=ori_hist(i,j,6)+grad_mag(indicesx,indicesy);
             end
    end
        end
    end
end
             
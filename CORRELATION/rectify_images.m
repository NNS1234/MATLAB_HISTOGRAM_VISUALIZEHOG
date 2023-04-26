%REFERENCE https://www.youtube.com/watch?v=GpU1Vx-b3VA&t=454s
function [rectL, rectR] = rectify_images(imgL, imgR,C_L, C_R)
    imgL = imread(imgL);
    imgL=rgb2gray(imgL);
    imgR = imread(imgR);
    imgR=rgb2gray(imgR);
    
    [Kl, Rl, tl] = findCameraParameters(C_L);
    [Kr, Rr, tr] = findCameraParameters(C_R);
  
    
    e1 = (tl-tr)/2;             % base
    e2 = cross(Rl(3,:)',e1);    % orthogal to y
    e3 = cross(e1,e2);          % orthogonal to x and y

    R = [e1'/norm(e1)           % rotational matrix
         e2'/norm(e2)
         e3'/norm(e3)];
      
    Hl = Kr*R*inv(Kl); 
    Hr = Kl*(R)*inv(Kr);
    
    [m,n] = size(imgL);
    rectL = zeros(2*m,2*n);
    rectR = zeros(2*m,2*n);
    for i = 1:m
        for j = 1:n
            p = ([i,j,1])';
            p_dash = abs(Hl*p);
            p_dash = round(p_dash ./ p_dash(3));
            p_dash = p_dash + 1;
            rectL(p_dash(1), p_dash(2)) = imgL(i,j);
            
            p = ([i,j,1])';
            p_dash = abs(Hr*p);
            p_dash = round(p_dash ./ p_dash(3));
            p_dash = p_dash + 1;
            rectR(p_dash(1), p_dash(2)) = imgR(i,j);
        end
    end
end


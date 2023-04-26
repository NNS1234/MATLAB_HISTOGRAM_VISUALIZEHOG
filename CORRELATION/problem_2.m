load('DATA/disparity.mat');
%GROUND TRUTH FORM DISPARITY
figure(1),imshow(uint8(L));
title("Ground Truth");
%RUNNING METHODS
N=3;
methods = ["SSD", "CC", "NCC"];
for i = 1:N
    Corrs(methods(i), i, double(L));
end

function Corrs(method, i, D_L)
imgL = rgb2gray(imread('viewL-1.png'));
imgR = rgb2gray(imread('viewR.png'));
    [R, C] = size(D_L);
    %GETTIME
    startTime = now;
    
    disp_map = compute_corrs(imgL, imgR, method);
    time_ = datestr(now - startTime, "HH:MM:SS");
    Error = sum(abs(D_L-disp_map), 'all');
    err=sum((D_L-disp_map).^2, 'all');
    Mean_s_e = err/(R*C);
    disp((method) + "time is: " + time_ + "in HH:MM:SS");
    disp("Error: " + string(Error));
    disp("Mean Squared Error: " + string(Mean_s_e));
    
  
    figure(i+1),imshow(uint8(disp_map));
    title("Disparity map " + (method))
end


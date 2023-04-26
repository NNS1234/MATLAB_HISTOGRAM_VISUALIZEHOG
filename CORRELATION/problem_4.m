% REFERENCE https://www.youtube.com/watch?v=Bm1yqdM_yWc
%https://link.springer.com/article/10.1007/s11042-018-6475-6
load('DATA/linefit.mat');

% a) Fit a line through the first set of measurements using a least squares
% approach. xs and ny1
Line1 = bestFitLS(xs, n_y1)

figure(1),scatter(xs, n_y1); hold on;
plot(xs, -((Line1(1)*xs)+Line1(3))/Line1(2));
title("Line 1 USING xs, n _y1");
disp("-----------------------------------");

% Problem b) Find the best fit for xs, n_y2
Line2 = bestFitLS(xs, n_y2)

figure(2),scatter(xs, n_y2); hold on;
plot(xs, -((Line2(1)*xs)+Line2(3))/Line2(2));
title("Line 2 using xs, n _y2");
disp("###############");

% Problem c) Find the best fit for xs, n_y2 for like RANSAC
Line3 = CUST(xs, n_y2, 0.04)

figure(3),scatter(xs, n_y2); hold on;
plot(xs, -((Line3(1)*xs)+Line3(3))/Line3(2));
title("Line 3 using xs, n _y2 using RANSAC BASED algorithm. Alpha = 0.04");
disp("#####################");

% C) Find the best fit WITH RANSAC
Line4 = CUST(xs, n_y2, 0.10)

figure(4),scatter(xs, n_y2); hold on;
plot(xs, -((Line4(1)*xs)+Line4(3))/Line4(2));
title("Line 3 using xs, n _y2 using RANSAC BASED algorithm. Alpha = 0.10");
disp("###################");

clear

function Line = bestFitLS(x, y)
    pts = transpose([x; y; ones(1, size(x, 2))]);
    [U,D,V] = svd(pts);
    Line = transpose(V(:,2));
end

function Line = CUST(x, y, Learning_Rate)
    
    n = max(size(x));
    outliers = [];
    NUM_INL = 1;
    COUNT = 0;
    Line = bestFitLS(x,y);
    
    Points = [x; y; ones(1,n)];
    weight = 0;
    while(COUNT/NUM_INL ~= 1)  
        
        DIST_MAT = abs(Line*Points/norm(Line(1:2)));
        MEAN_DIS = mean(DIST_MAT);
        DEV_DIS = std(DIST_MAT);
        weight = weight + (Learning_Rate*DEV_DIS);
        DIS_PATCH = MEAN_DIS + weight;
        
        COUNT = NUM_INL;
        XInliers = x(DIST_MAT < DIS_PATCH);
        YInliers = y(DIST_MAT < DIS_PATCH);
        NUM_INL = max(size(XInliers));
        
        Line = bestFitLS(XInliers, YInliers);
        outliers = [x(DIST_MAT > DIS_PATCH); y(DIST_MAT > DIS_PATCH);];
    end
    disp("Outliers: ");
    disp((outliers)');
end
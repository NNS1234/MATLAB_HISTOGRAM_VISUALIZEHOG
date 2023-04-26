RGB = imread('lines.jpg');
%THRESHOLD
p = 15;                    
%grayscale
I = rgb2gray(RGB);
%APPLYING GAUSSIAN FLTER
I=imgaussfilt(I);
%apply the sobel filter
BW=edge(I, 'Sobel');
%take theta and rho 
T = -90:1:89;
rho_max = round(sqrt(sum(size(BW) .^ 2)));

R = -rho_max:1:rho_max;
%accumulator
Acc = zeros(max(size(R)), 180);

[R, C] = size(BW);

for x = 1:R
    for y = 1:C
        if(BW(x,y) == 1)
            for theta = -90:1:89
                theta_index = theta + 90 + 1;
                theta = theta * pi/180;             % Converting degrees to radians
                
                rho = round((x*cos(theta)) + (y*sin(theta)));
                rho_index = rho + rho_max + 1;
                
                Acc(rho_index, theta_index) = Acc(rho_index, theta_index) + 1;
            end
        end
    end
end

% houghpeaks
Acc_max = Acc;
peakValues = [];
for i = 1:1:p
   max_i = max(Acc_max, [], 'all') ;
   [rho, theta] = find(Acc_max == max_i(1));
   peakValues = [peakValues; rho(1), theta(1)];
   Acc_max(rho(1), theta(1)) = -1;
end

%houghlines

lines = houghlines(BW,T,R,peakValues);

lines = [];
for i = 1:1:p
    line.theta = peakValues(i,2) - 90 - 1;
    line.rho = peakValues(i,1) - rho_max - 1;
    line.point1 = [];
    line.point2 = [];
    line.last = [];
    lines = [lines; line];
end

for i = 1:1:R
    for j = 1:1:C
        if BW(i,j) == 1
            for k = 1:1:p
               theta =  lines(k).theta*pi/180;
               rho = round(i*cos(theta) + j*sin(theta));
               if rho == lines(k).rho
                    if isempty(lines(k).point1) == 1
                        lines(k).point1 = [i,j];
                        continue;
                    end
                    lines(k).point2 = lines(k).last;
                    lines(k).last = [i,j];
               end
            end
        end
    end
end

imshow(BW)
hold on
for k = 1:numel(lines)
    if isempty(lines(k).point1) == 0
        x1 = lines(k).point1(2);
        y1 = lines(k).point1(1);
        x2 = lines(k).point2(2);
        y2 = lines(k).point2(1);
        plot([x1 x2],[y1 y2],'Color','red','LineWidth', 4)
    end
end
hold off

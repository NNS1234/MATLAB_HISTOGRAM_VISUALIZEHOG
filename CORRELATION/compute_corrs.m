function [disparity_map] = compute_corrs(img_left, img_right, method)

    win_size = 5;
    thres = 60;
    
    I_LFT = img_left;
    I_RGHT = img_right;
    
   %padding
    [m, n] = size(I_LFT);
    N1 = ceil((win_size)/2);
    I_LFT = [zeros(m, N1), I_LFT, zeros(m, N1)];
    I_LFT = [zeros(N1, n+(2*N1)); I_LFT; zeros(N1, n+(2*N1))];
    I_RGHT = [zeros(m, N1), I_RGHT, zeros(m, N1)];
    I_RGHT = [zeros(N1, n+(2*N1)); I_RGHT; zeros(N1, n+(2*N1))];
    
    [m, n] = size(I_LFT);
    disparity_map = zeros(m,n);
    
    switch(method)
        case "SSD"
            disp("SSD");
            for i = 1+N1:m-N1
                for j = 1+N1+1:n-N1
                    patch = I_LFT(i-N1:i+N1, j-N1:j+N1);
                    strip = I_RGHT(i-N1:i+N1, :);
                    min_cost = Inf;
                    index = 0;
                    for k = 1+N1:n-N1
                        if abs(j-k) <= thres
                            other_patch = strip(:, k-N1:k+N1);
                            cost = sum((other_patch - patch).^2,'all'); 
                            if cost < min_cost
                                min_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        case "CC"
            disp("CC");
            for i = 1+N1:m-N1
                for j = 1+N1+1:n-N1
                    patch = I_LFT(i-N1:i+N1, j-N1:j+N1);
                    patch_mean = mean(patch, 'all');
                    strip = I_RGHT(i-N1:i+N1, :);
                    max_cost = -Inf;
                    index = 0;
                    for k = 1+N1:n-N1
                        if abs(j-k) <= thres
                            other_patch = strip(:, k-N1:k+N1);
                            other_patch_mean = mean(other_patch, 'all');
                            cost = sum((other_patch - other_patch_mean) .* (patch - patch_mean), 'all');
                            if cost > max_cost
                                max_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        case "NCC"
            disp("NCC");
            normalized_sum_left = double(0);
            normalized_sum_right = double(0);
            for i = 1+N1:m-N1
                for j = 1+N1+1:n-N1
                    patch = I_LFT(i-N1:i+N1, j-N1:j+N1);
                    normalized_sum_left = normalized_sum_left + double((I_LFT(i,j) - mean(patch, 'all')) .^ 2);
                    
                    other_patch = I_RGHT(i-N1:i+N1, j-N1:j+N1);
                    normalized_sum_right = normalized_sum_right + double((I_RGHT(i,j) - mean(other_patch, 'all')) .^ 2);
                end
            end
            
            normal = double(sqrt(normalized_sum_left) * sqrt(normalized_sum_right));
            
            for i = 1+N1:m-N1
                for j = 1+N1+1:n-N1
                    patch = I_LFT(i-N1:i+N1, j-N1:j+N1);
                    patch_mean = mean(patch, 'all');
                    strip = I_RGHT(i-N1:i+N1, :);
                    max_cost = -Inf;
                    index = 0;
                    for k = 1+N1:n-N1
                        if abs(j-k) <= thres
                            other_patch = strip(:, k-N1:k+N1);
                            other_patch_mean = mean(other_patch, 'all');
                            cost = sum((other_patch - other_patch_mean) .* (patch - patch_mean), 'all')/normal;
                            if cost > max_cost
                                max_cost = cost;
                                index = k;
                            end
                        end
                    end
                    disparity_map(i,j) = abs(j - index);     % LEFT - RIGHT
                end
            end
        otherwise
            disp("Select a normal output");
    end
    
%REMOVE OUTLIERS AND CONV
    K= ones(win_size, win_size)./(win_size.^2);
    disparity_map = conv2(disparity_map, K);
    disparity_map = disparity_map(1+N1:m-N1, 1+N1:n-N1);
    
end
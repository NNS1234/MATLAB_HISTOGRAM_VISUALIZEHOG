L1 = transpose([-1, -1, 2; -1, -1, 3]);
L2 = transpose([0, -1, 2; 0, -1, 3]);
L3 = transpose([1, -1, 2; 1, -1, 3]);
X1 = find_intersection(L1(:,1), L1(:,2), L2(:,1), L2(:,2));
X2 = find_intersection(L2(:,1), L2(:,2), L3(:,1), L3(:,2));
X3 = find_intersection(L3(:,1), L3(:,2), L1(:,1), L1(:,2));
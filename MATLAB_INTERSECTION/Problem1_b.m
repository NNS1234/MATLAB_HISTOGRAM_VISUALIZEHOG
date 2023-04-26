 L1 = transpose([-1, -1, 2; -1, -1, 3]);
 L2 = transpose([0, -1, 2; 0, -1, 3]);
 intersectionpoint = find_intersection(L1(:,1), L1(:,2), L2(:,1), L2(:,2));
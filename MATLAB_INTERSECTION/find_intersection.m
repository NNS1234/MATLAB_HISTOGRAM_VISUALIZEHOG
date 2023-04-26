
function propoint = find_intersection(P11, P12, P21, P22)
X = P11 - P12;% r = (1 - C1)P11 + (C1)P12 = (1 - C2)P21 + (C2) =>%   => C1(P12 - P11) - C2(P22 - P21) + (P11 - P21)
Y = P22 - P21; %X(C1) + Y(C2) + C = 0
Z = P11 - P21;
intpoint = linsolve([X,Y],Z); %actuall point for intersecting
t1 = intpoint(1); 
t2 = intpoint(2);
%Say that the lines intersect, then we can equal r1 and r2
propoint = round(P11 + t1*(P12 - P11),2); %project point 

intpoint = round(P21 + t2*(P22 - P21),2);

if propoint == intpoint
    fprintf('Lines intersect');
else
    fprintf('Lines intersect at infinity');
    propoint = [1/0; 1/0; 1/0];
end

L1 = [P11, P12, propoint];
L2 = [P21, P22, propoint];

propoint = project_point(propoint);

P11 = project_point(P11);
P12 = project_point(P12);
P21 = project_point(P21);
P22 = project_point(P22);
L1pro = [P11, P12, propoint];
L2pro = [P21, P22, propoint];
figure;
plot3(L1(1,:), L1(2,:), L1(3,:), '-o', L2(1,:), L2(2,:), L2(3,:), '-o', L1pro(1,:), L1pro(2,:), L1pro(3,:), '-o', L2pro(1,:), L2pro(2,:), L2pro(3,:), '-o');
legend({'L1', 'L2', 'projected L1', 'projected L2'});



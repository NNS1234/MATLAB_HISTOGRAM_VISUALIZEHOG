P1_L1 = [1; 0; 0; -1];
P1_L2 = [1; 0; 0; 0];
P2_L1 = [3; 0; 2; -1];
P2_L2 = [3; 0; 2; -2];
P3_L1 = [5; 0; -2; -1];
P3_L2 = [5; 0; -2; -2];

%for first equation
P1_L1_P = transpose(getPoints(P1_L1));
P1_L2_P = transpose(getPoints(P1_L2));
P1_X = round(find_intersection(P1_L1_P(:,1),P1_L1_P(:,2),P1_L2_P(:,1),P1_L2_P(:,2)),2);

P1_L1_Project = [project_point(P1_L1_P(:,1)), project_point(P1_L1_P(:,2)), P1_X];
P1_L2_Project = [project_point(P1_L2_P(:,1)), project_point(P1_L2_P(:,2)), P1_X];

%for second equation
P2_L1_P = transpose(getPoints(P2_L1));
P2_L2_P = transpose(getPoints(P2_L2));
P2_X = round(find_intersection(P2_L1_P(:,1),P2_L1_P(:,2),P2_L2_P(:,1),P2_L2_P(:,2)),2);

P2_L1_Project = [project_point(P2_L1_P(:,1)), project_point(P2_L1_P(:,2)), P2_X];
P2_L2_Project = [project_point(P2_L2_P(:,1)), project_point(P2_L2_P(:,2)), P2_X];

%for third equation
P3_L1_P = transpose(getPoints(P3_L1));
P3_L2_P = transpose(getPoints(P3_L2));
P3_X = round(find_intersection(P3_L1_P(:,1),P3_L1_P(:,2),P3_L2_P(:,1),P3_L2_P(:,2)),2);

P3_L1_Project = [project_point(P3_L1_P(:,1)), project_point(P3_L1_P(:,2)), P3_X];
P3_L2_Project = [project_point(P3_L2_P(:,1)), project_point(P3_L2_P(:,2)), P3_X];


lamda = (P3_X(3) - P1_X(3))/(P2_X(3) - P1_X(3));
Z = [0/0; 0/0; 0/0]; 

a = round(((1-lamda)*P1_X) + ((lamda)*P2_X),2);
if isequal(isnan(a),isnan(Z)) || isequal(a,P3_X)
    fprintf("\n collinear");
else
    fprintf("non collinear");
end

plot3(P1_L1_P(1,:), P1_L1_P(2,:), P1_L1_P(3,:), "-o", P1_L2_P(1,:), P1_L2_P(2,:), P1_L2_P(3,:), "-o", P1_L1_Project(1,:), P1_L1_Project(2,:), P1_L1_Project(3,:), "-o", P1_L2_Project(1,:), P1_L2_Project(2,:), P1_L2_Project(3,:), "-o");
legend({'L1', 'L2', 'projected L1', 'projected L2'});
figure;

plot3(P2_L1_P(1,:), P2_L1_P(2,:), P2_L1_P(3,:), "-o", P2_L2_P(1,:), P2_L2_P(2,:), P2_L2_P(3,:), "-o", P2_L1_Project(1,:), P2_L1_Project(2,:), P2_L1_Project(3,:), "-o", P2_L2_Project(1,:), P2_L2_Project(2,:), P2_L2_Project(3,:), "-o");
legend({'L3', 'L4', 'projected L3', 'projected L4'});
figure;

plot3(P3_L1_P(1,:), P3_L1_P(2,:), P3_L1_P(3,:), "-o", P3_L2_P(1,:), P3_L2_P(2,:), P3_L2_P(3,:), "-o", P3_L1_Project(1,:), P3_L1_Project(2,:), P3_L1_Project(3,:), "-o", P3_L2_Project(1,:), P3_L2_Project(2,:), P3_L2_Project(3,:), "-o");
legend({'L5', 'L6', 'projected L5', 'projected L6'});

function P = getPoints(P_L)
    P = [];
    for i = 0:2
        x = randi(10) + (i * 20);
        z = randi(10) - (i * 20);
        y = (0 - x*P_L(1) - z*P_L(3) - P_L(4))/P_L(2);
        X = [x, y, z, 1];
        if X*P_L == 0
            P = [P; x, y, z];
        end
    end
    
    if size(P,1) < 2
        for i = 0:1
            y = randi(10) + (i * 20);
            z = randi(10) - (i * 20);
            x = (0 - y*P_L(2) - z*P_L(3) - P_L(4))/P_L(1);
            X = [x, y, z, 1];
            if X*P_L == 0
                P = [P; x, y, z];
            end
        end
    end
    
    if size(P,1) < 2
        for i = 0:1
            x = randi(10) + (i * 20);
            y = randi(10) - (i * 20);
            z = (0 - x*P_L(1) - y*P_L(2) - P_L(4))/P_L(3);
            X = [x, y, z, 1];
            if X*P_L == 0
                P = [P; x, y, z];
            end
        end
    end
end
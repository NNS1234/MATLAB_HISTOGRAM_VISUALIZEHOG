function P_C = project_points(P_W, R, t)
    imgcenter = [50, 50, 0];                  % Image Center is given 50,50
    scalingfactor = diag([200, 200, 1, 1],0);    % Scaling with given alpha beta value of 200
    skew = 0;                              % Skew is given 0
    x = norm(imgcenter-t);                    
    K = [x, skew, imgcenter(1), 0; 0, x, imgcenter(2), 0; 0, 0, 1, 0]*scalingfactor; %here k is internal parameter
    R = [R, zeros(3,1); zeros(1,3), 1]; %Rotation matrices 3x3
    T = [eye(3), -t; zeros(1,3), 1]; % creating identity matrices for translation matric 3x1
    P_W = [P_W, ones(10,1)];
    X = K*R*T*(P_W.');
    P_C = X(1:2,:).';
    
end
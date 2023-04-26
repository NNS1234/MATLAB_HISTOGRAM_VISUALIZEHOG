function Q = project_point(P)
%following formula(1−λ)p+λq(1−λ)p+λq
Origin = [0; 0; 0];
lamda = 1/P(3);     % in the linear combination sum of the coefficients are 1 which keeps the resulting point on z=1
Q = (1-lamda)*Origin + lamda*P;

load('LeftcalibrationSession.mat');
leftcameraparams = calibrationSession.CameraParameters;
%intrinsic matrix
K_l = (leftcameraparams.IntrinsicMatrix)';
%doing rottion and translation for extrinsic value
R_l = zeros(3,3);
for i = 1:3
    for j = 1:3
        R_l(i,j) = mean(leftcameraparams.RotationMatrices(i,j,1:12));
    end
end

t_l = mean(leftcameraparams.TranslationVectors);

C_L = K_l*[R_l, (t_l)'];
disp("LEFT CAMERA INTRINSIC")
disp(K_l)

disp("LEFT CAMERA EXTRINSIC")
disp([R_l, (t_l)'])

load('rightcalibrationSession.mat');

rightcameraparams = calibrationSession.CameraParameters;

K_r = (rightcameraparams.IntrinsicMatrix)';

R_r = zeros(3,3);
for i = 1:3
    for j = 1:3
        R_r(i,j) = mean(rightcameraparams.RotationMatrices(i,j,1:12));
    end
end

t_r = mean(rightcameraparams.TranslationVectors);

C_R = K_r*[R_r,(t_r)'];

disp("RIGHT CAMERA INTRINSIC")
disp(K_r)

disp("RIGHT CAMERA EXTRINSIC")
disp([R_r, (t_r)'])


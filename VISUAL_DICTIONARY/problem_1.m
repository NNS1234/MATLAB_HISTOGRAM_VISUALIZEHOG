%nudrat saber
%1001733394
%run('C:\Users\12148\Desktop\assignment_6\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')
clc;
clear all;
close all;

 [confusion, accuracy] = classify_knn_tiny;
 figure;
 imagesc(confusion);
 title('KNN Tiny image Accuracy');

 disp('KNN_Tiny Accuracy');
 disp(accuracy);
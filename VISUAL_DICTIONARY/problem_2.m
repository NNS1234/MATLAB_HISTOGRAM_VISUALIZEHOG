%nudrat saber
%1001733394
%run('C:\Users\12148\Desktop\assignment_6\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')
clc;
clear all;
close all;


 [confusion, accuracy] = classify_knn_bow;
 figure;
 imagesc(confusion);
 title('KNN Bag of Words Accuracy');
 disp('KNNBoW Accuracy');
 disp(accuracy);
 


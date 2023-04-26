%nudrat saber
%1001733394
%run('C:\Users\12148\Desktop\assignment_6\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')
clc;
clear all;
close all;


 [confusion, accuracy] = classify_svm_bow;
 figure;
 imagesc(confusion);
 title('SVM Bag of Words Accuracy');
 disp('SVMBoW Accuracy');
 disp(accuracy);
 


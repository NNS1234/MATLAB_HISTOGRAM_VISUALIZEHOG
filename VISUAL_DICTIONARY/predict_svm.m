%nudrat saber
%1001733394
%https://www.mathworks.com/help/stats/fitcsvm.html
function [label_test_pred] = predict_svm(feature_train, label_train, feature_test) 

scores_all=[];
rng(1);
for i=1:15
    B=label_train==i;
    each_label=ones(length(label_train),1);
    each_label(B==0) = -1;

    SVM_model = fitcsvm(feature_train,each_label,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
   [label,score]=predict(SVM_model,feature_test);
   scores_all=[scores_all;score(:,2)'];
  
end
[M,I] = max(scores_all);
label_test_pred=I';

end








%nudrat saber
%1001733394
%reference :https://www.mathworks.com/help/stats/classificationknn.predict.html
function [label_test_pred]=predict_knn(feature_train,label_train, feature_test,k)
Mdl = fitcknn(feature_train,label_train,'NumNeighbors',k,'Standardize',1);

[label_test_pred] = predict(Mdl,feature_test);
end
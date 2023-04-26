%nudrat saber
%1001733394
function [confusion, accuracy] = classify_svm_bow 



%making training image 
file=fopen(".\scene_classification_dataset\train.txt");
end_of_file = fgetl(file);
train_class=[];
training_image_cell={};
index=1;
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    filename=".\scene_classification_dataset\";
    train_class=[train_class; convertCharsToStrings(cell{1})];
    I=imread(strcat(filename,cell{2}));
    training_image_cell{index}=I;
    index=index+1;
    end_of_file = fgetl(file);
end

fclose(file);

%making test image cell
file=fopen(".\scene_classification_dataset\test.txt");
end_of_file = fgetl(file);
test_class=[];
test_image_cell={};
index=1;
while ischar(end_of_file)
    cell = strsplit(end_of_file);
    filename=".\scene_classification_dataset\";
    test_class=[test_class; convertCharsToStrings(cell{1})];
    I=imread(strcat(filename,cell{2}));
    
    test_image_cell{index}=I;
    index=index+1;
    end_of_file = fgetl(file);
end

fclose(file);

%Building Visual Dictionary
dic_size=50;
[vocab] = build_visual_dictionary(training_image_cell, dic_size);

%getting feature_train and label_train
feature_train=[];

for i=1: size(training_image_cell,2)
    im=im2single(training_image_cell{i}) ; 
    [~, feature] = vl_dsift(im, 'fast', 'Step', 20, 'size', 10);
 
    feature=feature';
    [bow_feature] = compute_bow(feature, vocab);
    feature_train=[feature_train; bow_feature];
end

label_train=grp2idx(train_class);

%getting feature_test and label_test
feature_test=[];

for i=1: size(test_image_cell,2)
    im=im2single(test_image_cell{i});
     [~, feature] = vl_dsift(im, 'fast', 'Step', 20, 'size', 10);

    feature=feature';
    [bow_feature] =compute_bow(feature, vocab);
    feature_test=[feature_test; bow_feature];
end

label_test=grp2idx(test_class);


[label_test_pred] = predict_svm(feature_train, label_train, feature_test);
accuracy= sum(label_test_pred==label_test)*100/size(label_test,1);
confusion = confusionmat(label_test,label_test_pred);


end
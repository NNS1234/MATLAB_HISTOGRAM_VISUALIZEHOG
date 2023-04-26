%nudrat saber
%1001733394
function[confusion, accuracy]=classify_knn_tiny

file=fopen(".\scene_classification_dataset\train.txt");
end_of_file = fgetl(file);
train_class=[];
feature_train=[];
output_size=[16 16];

while ischar(end_of_file)
    cell = strsplit(end_of_file);
    train_class=[train_class; convertCharsToStrings(cell{1})];
    filename=".\scene_classification_dataset\";
    I=imread(strcat(filename,cell{2}));
    feature= get_tiny_image(I, output_size);
    feature_train=[feature_train; feature'];
    end_of_file = fgetl(file);
end

fclose(file);
label_train=grp2idx(train_class);

file=fopen(".\scene_classification_dataset\test.txt");
end_of_file = fgetl(file);
test_class=[];
feature_test=[];
output_size=[16 16];

while ischar(end_of_file)
    cell = strsplit(end_of_file);
    test_class=[test_class; convertCharsToStrings(cell{1})];
    filename=".\scene_classification_dataset\";
    I=imread(strcat(filename,cell{2}));
    feature= get_tiny_image(I, output_size);
    feature_test=[feature_test; feature'];

    end_of_file = fgetl(file);
end

fclose(file);
label_test=grp2idx(test_class);

k=5;
[label_test_pred] =predict_knn(feature_train, label_train, feature_test, k);

accuracy= sum(label_test_pred==label_test)*100/size(label_test,1);

confusion = confusionmat(label_test,label_test_pred);
end
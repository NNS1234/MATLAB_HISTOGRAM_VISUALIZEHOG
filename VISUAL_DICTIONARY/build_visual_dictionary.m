%nudrat saber
%1001733394
function [vocab] = build_visual_dictionary(training_image_cell, dic_size)
pool=[];

SIFT_train_image={};
for i=1: size(training_image_cell,2)
    I=training_image_cell{1,i};
    [frames,features] = vl_dsift(single(I),'fast','step',20,'size',10);
    pool=[pool;features'];
    SIFT_train_image{end+1}=features';
end


rng(1);   % For reproducibility
pool=double(pool);
[~,vocab] = kmeans(pool,dic_size, 'MaxIter',1000 );

end

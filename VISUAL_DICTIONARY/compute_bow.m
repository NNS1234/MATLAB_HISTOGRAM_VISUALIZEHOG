%nudrat saber
%1001733394
%reference : https://www.mathworks.com/help/textanalytics/ref/bagofwords.html
function [bow_feature]=compute_bow(feature,vocab)
Idx = knnsearch(double(vocab),double(feature));
histo=histcounts(Idx,'BinLimits',[1, size(vocab,1)], 'BinMethod','integers');
bow_feature=histo/norm(histo);
end
filenames = {'LireBenchmarkColorHisto','HOG_100TFIDF2','RGB_100TFIDF2','SIFT_100HFTFIDF'};
for i = 1:length(filenames)
   load(sprintf('%s.mat',filenames{i}));
   fprintf(1,'%s\n',filenames{i});
   trueVector = labels(:,1);
   rankMatrix = labels(:,2:end);
   apScoreVec = avgPrecisionAtK(trueVector,rankMatrix,50);
   map = mean(apScoreVec);
   fprintf(1,'MAP@50: %1.6f\n',map);
   f = figure;
   hist(apScoreVec,100);
   xlabel('Average Precision@50');
   ylabel('Frequency');
   title('Histogram of AP@50');
   saveas(f,sprintf('HistAP50_%s',filenames{i}),'jpg');
   close all;
   for j = 0:1:9
       map = mean(apScoreVec(trueVector==j));
       fprintf(1,'MAP@50(label %i): %1.6f\n',j,map);
   end
   recallScoreVec = recallAtK(trueVector,rankMatrix,50);
   recall = mean(recallScoreVec);
   fprintf(1,'Mean Recall@50: %1.6f\n',recall);
   f = figure;
   hist(recallScoreVec,100);
   xlabel('Recall@50');
   ylabel('Frequency');
   title('Histogram of Recall@50');
   saveas(f,sprintf('HistRecall50_%s',filenames{i}),'jpg');
   close all;
   mrrScoreVec = mrr(trueVector,rankMatrix);
   fprintf(1,'MRR: %1.6f\n',mean(mrrScoreVec));
   topTen = sum(mrrScoreVec>=0.1);
   topThirty = sum((mrrScoreVec<0.1 & mrrScoreVec>=(1/30)));
   f = figure;
   pie([topTen topThirty length(mrrScoreVec)-topTen-topThirty]);
   colormap jet
  % title('Pie Chart: Ranks of First Occurence');
   saveas(f,sprintf('MRR_PieChart_%s',filenames{i}),'jpg');
   close all;
   clearvars -except filenames i
end
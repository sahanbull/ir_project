%% dataMergeHOG: this function merges the data as required in HOG processed dataset
function [corpus,qs] = dataMergeRGB()

	% load the row data
	load('dataRGBHist.mat');
	
	% make the corpus
	corpus = [X1;X2;X3;X4;X5];
	% make the queries
	qs = [test]; 

	save('processed.mat','corpus','qs');
end
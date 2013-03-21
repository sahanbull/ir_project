%% dataMergeHOG: this function merges the data as required in HOG processed dataset
function [corpus,qs] = dataMergeHOG()

	% load the row data
	load('dataHOG.mat');
	
	% make the corpus
	corpus = [X1;X2;X3;X4;X5];
	% make the queries
	qs = [test]; 

	save('processedHOG.mat','corpus','qs');
end
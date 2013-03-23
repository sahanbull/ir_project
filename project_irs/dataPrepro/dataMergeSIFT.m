%% dataMergeHOG: this function merges the data as required in SIFT processed dataset
function [corpus,qs] = dataMergeSIFT()
	% load the row data
	load('fileName.mat');
	
	% make the corpus
	corpus = [X1;X2;X3;X4;X5];
	% make the queries
	qs = [test]; 

	save('processed.mat','corpus','qs');
end
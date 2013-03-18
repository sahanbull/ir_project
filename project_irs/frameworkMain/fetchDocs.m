%% fetchDocs: this function fetches the documents in a matrix 
function [docs] = fetchDocs(docList)
	% load the file with corpus:: changed later
	load('testDummyData.mat');

	% pick the ones that are relevant
	docs = comparers(docList,:);
end
%% fetchDocs: this function fetches the documents in a matrix 
function [docs,classes] = fetchDocs(docList)
	% load the file with corpus:: changed later
	load('processed.mat');

	% pick the ones that are relevant
	docs = corpus(docList,:);

	% picks the relevant classes of the docs
	classes = classCorpus(docList,1);
end
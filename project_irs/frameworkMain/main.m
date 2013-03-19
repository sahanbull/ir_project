%% main: main function that starts and triggers everything
function [results] = main(q)

	load('testDummyData.mat');


	% transform the image to a vector with wanted feacures only.
	% will be replaced by the real function later
	relQ = testThresh(q,0.3)

	% get what feaures are significant in this queary
	features = find(relQ);

	% reduces the query to relevant features
	relQ = relQ(1,features);

	% picks the document list with all these fueatures 
	relDocsList = findDocSet(features);
	% pics relevant docs
		% at one point /// you need to bring the classes of rel Docs as well
	relDocs = fetchDocs(relDocsList);

	% reduces the relevant docs to relevant features 
	redRelDocs = relDocs(:,features);

	% get the ranks back
	ranks = similarityCheck(1,relQ,redRelDocs,2);

	results = relDocs(ranks,:);
end

% a dummy function that will be replaced by the real function later
function [thrQ] = testThresh(q,thr)
	valid = find(q>thr);
	thrQ = zeros(size(q));
	thrQ(1,valid) = q(1,valid);
end
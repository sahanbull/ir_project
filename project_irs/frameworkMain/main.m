%% main: main function that starts and triggers everything
% input parameters
	% q 		: query
	% simType	: similarity measuring approach
	% noRanked	: number of ranked results expected
function [results] = main(q,simType,noRanked)

	load('testDummyData.mat');

	% transform the image to a vector with wanted features only.
	% will be replaced by the real function later
	relQ = testThresh(q,0.3);

	% get what feaures are significant in this queary
	features = find(relQ);

	% reduces the query to relevant features
	relQ = relQ(1,features);

	% picks the document list with all these fueatures 
	relDocsList = findDocSet(features);

	% picks relevant docs and their respective judged classes 
	[relDocs,relClasses] = fetchDocs(relDocsList);

	% get the ranks back
	ranks = similarityCheck(simType,relQ,relDocs,features,noRanked)

	rankedDocs = relDocs(ranks,:);
	rankedclasses = relClasses(ranks,:);

	results = 0
end

% a dummy function that will be replaced by the real function later
function [thrQ] = testThresh(q,thr)
	valid = find(q>thr);
	thrQ = zeros(size(q));
	thrQ(1,valid) = q(1,valid);
end
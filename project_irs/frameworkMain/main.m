%% main: main function that starts and triggers everything
% input parameters
	% q 		: query
	% simType	: similarity measuring approach
	% noRanked	: number of ranked results expected
function main(qs,simType,noRanked)

	load('testDummyData.mat');

	% to store the mean average precision
	MAP = 0.0;
	% foreach query
	for(i=1:size(qs,1))

		q = qs(i,:);

		% transform the image to a vector with wanted features only.
		% will be replaced by the real function later
		relQ = testThresh(q,0.3);

		% picks the class of the query
		qClass = queryClass(i);

		% get what feaures are significant in this queary
		features = find(relQ);

		% reduces the query to relevant features
		relQ = relQ(1,features);

		% picks the document list with all these fueatures 
		relDocsList = findDocSet(features);

		% picks relevant docs and their respective judged classes 
		[relDocs,relClasses] = fetchDocs(relDocsList);

		% get the ranks back
		ranks = similarityCheck(simType,relQ,relDocs,features,noRanked);

		rankedDocs = relDocs(ranks,:);
		rankedClasses = relClasses(ranks,:);

		% compute average precision for the query result
		AP = averagePrecision(qClass,rankedClasses);
		fprintf('\n Averege Precision for query\t\t %i is \t\t %f',i,AP)
		MAP = MAP + AP;
	end

	MAP = meanAveragePrecision(MAP,size(qs,1));	

	fprintf('\n\n-- Mean Averege Precision of this model is \t\t %f', MAP)
	fprintf('\n')
end

% a dummy function that will be replaced by the real function later
function [thrQ] = testThresh(q,thr)
	valid = find(q>thr);
	thrQ = zeros(size(q));
	thrQ(1,valid) = q(1,valid);
end
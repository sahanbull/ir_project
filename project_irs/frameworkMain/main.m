%% main: main function that starts and triggers everything
% input parameters
	% q 		: query
	% simType	: similarity measuring approach
	% noRanked	: number of ranked results expected
	% thresh 	: the threshold value
function [times,labels] = main(simType,noRanked,thresh)

	load('processed.mat');

	% size(corpus)
	% size(qs)

	% to record successful queries
	successQs = ones(1,size(qs,1));

	% to store the average precision
	APs = zeros(1,size(qs,1));
	% to record times
	times = zeros(1,size(qs,1));

	% to store the labels
	% rows to store results for each query
	% coulums to store 
	labels = ones(size(qs,1),noRanked+1)*10;


	% foreach query
	for(i=1:20)%size(qs,1))
		tStart = tic;
		q = qs(i,:);
	
		% transform the image to a vector with wanted features only.
		% reduce the dimensions
		relQ = testThresh(q,thresh);
	
		% picks the class of the query
		qClass = queryClass(i);

		% get what feaures are significant in this queary
		features = find(relQ);

		% reduces the query to relevant features
		relQ = relQ(1,features);

		% *** uncomment the following line to use full set of features *** 
		% ALSO REFER TO QUERY REDUCTION IN evalFunc->similarityCheck() function
		% to adjust document feature space
		% relQ = q;

		% if no features were extracted
		if (size(features,2) == 0)

			labels(i,1) = qClass;

			% mark query as failed
			successQs(1,i) = 0;

			tEnd = toc(tStart);

			times(1,i) = tEnd;


			fprintf('\n No features for query\t\t %i',i);
			continue;
		end

		% picks the document list with all these fueatures 
		relDocsList = findANDDocSet(features);
		if (size(relDocsList,2) == 0)
			relDocsList = findORDocSet(features);
		end
		
		% if no documents are there having an AND match
		if (size(relDocsList,2) == 0)

			labels(i,1) = qClass;

			% mark query as failed
			successQs(1,i) = 0;

			tEnd = toc(tStart);
			% APs(1,i) = AP;
			times(1,i) = tEnd;


			fprintf('\n No results for query\t\t %i',i);
			continue;
		end

		% picks relevant docs and their respective judged classes 
		[relDocs,relClasses] = fetchDocs(relDocsList);

		% get the ranks back
		ranks = similarityCheck(simType,relQ,relDocs,features,noRanked);

		rankedDocs = relDocs(ranks,:);
		rankedClasses = relClasses(ranks,:);

		labels(i,1) = qClass;
		labels(i,2:length(rankedClasses)+1) = rankedClasses(1:length(rankedClasses),1);

		% compute average precision for the query result
		AP = averagePrecision(qClass,rankedClasses);
		tEnd = toc(tStart);
		APs(1,i) = AP;
		times(1,i) = tEnd;



		fprintf('\n Completed query\t\t %i with average precision : %f',i,AP)
	end
	save('resultsData.mat','times','labels','successQs');
	 MAP = meanAveragePrecision(APs);	

	fprintf('\n\n-- Mean Averege Precision of this model is \t\t %f', MAP)
	fprintf('\n')
	% APs
	% labels
	% times

end

% a dummy function that will be replaced by the real function later
function [thrQ] = testThresh(q,thr)
	valid = find(q>thr);
	thrQ = zeros(size(q));
	thrQ(1,valid) = q(1,valid);
end
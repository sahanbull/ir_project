%% similarityCheck: This function checks how similar a query image and a sent in image is
function [ranks] = similarityCheck(sim,query,relDocs,features,noRanks)

	% reduces the relevant docs to relevant features 
	
	comparers = relDocs(:,features);

	% *** uncomment this line to use the full set of features ***
	% ALSO REFER TO QUERY REDUCTION IN frameworkMain->main() function
	% to adjust query feature space
	% comparers = relDocs;


	% query
	% comparers
	% normalize the query visual words
	query = query./norm(query);
	
	% length of relevant documents
	numComparers = size(comparers,1);

	% to store the scores
	scores = zeros(numComparers,1);
	if (sim == 2 || sim == 3)
		% needs IDFs of the features
		Idfs = getIdfs(features);
	end
	% foreach comparing candidate
	for (i=1:numComparers)
		% one candidate document
		comparer = 	comparers(i,:);

		% normalize the comparer document visual words
		comparer = comparer./norm(comparer);

		if (sim == 1) % Vector Space Model
			scores(i,1) = simEuclidean(query,comparer);
		elseif (sim == 2) % vanilla TFIDF Model
			% you dont need the query to get TFIDF score
			scores(i,1) = simTFIDF(comparer,Idfs);
		elseif(sim == 3) % enganced TF IDF Model
			% weight and compare the similarity. So we need query as well
			scores(i,1) = simEnhTFIDF(query,comparer,Idfs);
		end
	end

	limit = noRanks;

	if(limit>size(scores,1))
		limit = size(scores,1);
	end

	% sort the scores descending to get the positions
	[scores ranks] = sort(scores,'descend');
	% scores
	% ranks
	% pick top noRanks no. of ranks
	ranks = ranks(1:limit,1);
end



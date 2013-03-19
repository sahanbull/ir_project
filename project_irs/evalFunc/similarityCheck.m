%% similarityCheck: This function checks how similar a query image and a sent in image is
function [ranks] = similarityCheck(sim,query,relDocs,features,noRanks)

	% reduces the relevant docs to relevant features 
	comparers = relDocs(:,features);
	
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
	
		if (sim == 1) % Vector Space Model
			scores(i,1) = simEuclidean(query,comparers(i,:));
		elseif (sim == 2) % vanilla TFIDF Model
			% you dont need the query to get TFIDF score
			scores(i,1) = simTFIDF(comparers(i,:),Idfs);
		elseif(sim == 3) % enganced TF IDF Model
			% weight and compare the similarity. So we need query as well
			scores(i,1) = simEnhTFIDF(query,comparers(i,:),Idfs);
		end
	end

	% sort the scores descending to get the positions
	[scores ranks] = sort(scores,'descend');
	% scores
	% ranks
	% pick top noRanks no. of ranks
	ranks = ranks(1:noRanks,1);
end



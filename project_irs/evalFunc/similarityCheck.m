%% similarityCheck: This function checks how similar a query image and a sent in image is
function [ranks] = similarityCheck(sim,query,relDocs,features,noRanks)

	% reduces the relevant docs to relevant features 
	comparers = relDocs(:,features);
	
	% length of relevant documents
	numComparers = size(comparers,1);

	% to store the scores
	scores = zeros(numComparers,1);

	% foreach comparing candidate
	for (i=1:numComparers)
	
		if (sim == 1)
			scores(i,1) = simEuclidean(query,comparers(i,:));
		elseif (sim == 2)
			scores(i,1) = simTFIDF(query,comparers(i,:));
		else
			fprintf('somthing is needed here');	
		end
	end

	% sort the scores descending to get the positions
	[scores ranks] = sort(scores,'descend');
	% scores
	% ranks
	% pick top noRanks no. of ranks
	ranks = ranks(1:noRanks,1);
end



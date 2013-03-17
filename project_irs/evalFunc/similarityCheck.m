%% similarityCheck: This function checks how similar a query image and a sent in image is
function [ranks] = similarityCheck(sim,query,comparers,noRanks)
	% to store the scores
	scores = zeros(length(comparers),1);
	
	% foreach comparing candidate
	for (i=1:length(comparers))
	
		if (sim == 1)
			scores(i,1) = simEuclidean(query,comparers(i,:));
		elseif (sim == 2)
			scores(i,1) = simTFIDF(query,comparers(i,:));
		else
			fprintf('somthing is needed here');	
		end

		% sort the scores descending to get the positions
		[ranks scores] = sort(scores,'descend');

		% pick top noRanks no. of ranks
		ranks = ranks(1:noRanks,1);
end



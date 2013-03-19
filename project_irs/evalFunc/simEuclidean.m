%% scoreEuc: this function computes score using euclidian distance between two vectors
function [score] = simEuclidean(query,comparer)
	% closest has to have higher score.. hence, inverse
	score = 1/(norm(query-comparer));
end

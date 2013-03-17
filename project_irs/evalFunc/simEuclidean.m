%% scoreEuc: this function computes score using euclidian distance between two vectors
function [score] = simEuclidean(query,comparer)
	score = norm(query-comparer);
end

%% meanAveragePrecision: this funciton computes the mean average precision
function [MAP] = meanAveragePrecision(map)
	% average over number of queries
	MAP = mean(map);
end	
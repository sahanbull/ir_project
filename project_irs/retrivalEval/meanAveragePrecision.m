%% meanAveragePrecision: this funciton computes the mean average precision
function [MAP] = meanAveragePrecision(map,qs)
	% average over number of queries
	MAP = map/qs;
end	
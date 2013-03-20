%% averagePrecision: this function calculates the average precsion for the query
function [AP] = averagePrecision(queryCl,resultsCl)
	% resultsCl
	% queryCl

	% pick the locations of the relevant returns
	relResults = find(resultsCl==queryCl);
	% 1 over total number of docs at each relevant return 
	% devide that value by the total relavent documents in the result
	relResults2 = 1./(relResults.*length(relResults));

	% number of rel document per each correct location
	corrects = (1:length(relResults));

	% average precision- vector multiplication 
	% (sumproduct of: # relevant x 1/# all docs at that point / # total relevant)
	AP = (corrects*relResults2);

end
%% averagePrecision: this function calculates the average precsion for the query
function [AP] = averagePrecision(queryCl,resultsCl)
	% resultsCl
	% queryCl

	% pick the locations of the relevant returns
	relResults = find(resultsCl==queryCl);

	AP = 0.0; % initiate Average precision
	correct = 0; % to store # of correct returns
	
	% foreach correct location
	for(i=1:length(relResults))
		correct = correct + 1;
		% average precision = former average precision + # correct / # total till now
		% and # total till now = location of the correct one
		AP = AP + correct./relResults(i,1);
	end
	% to devide by # relavnt documents in the result
	AP = AP./correct;	
end
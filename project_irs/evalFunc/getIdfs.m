%% getIdfs: this function picks the IDF values required for a perticular query
function [Idfs] = getIdfs(features)
	load('processedHOG.mat');

	% fetch the required IDFs
	Idfs = idfs(features,1);

	% *** uncomment the following line to use full set of features ***
	% ALSO REFER TO QUERY REDUCTION IN evalFunc->similarityCheck() function
	% to adjust document feature space
	Idfs = idfs(:,1);
end
%% getIdfs: this function picks the IDF values required for a perticular query
function [Idfs] = getIdfs(features)
	load('testDummyData.mat');

	% fetch the required IDFs
	Idfs = idfs(features,1);
end
%% queryClass: this class picks the class of the designated query
function [qCl] = queryClass(i)

	load('testDummyData.mat');

	% picks the query class
	qCl = classQ;
end
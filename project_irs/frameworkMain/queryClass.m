%% queryClass: this class picks the class of the designated query
function [qCl] = queryClass(i)

	% loads the data
	load('processed.mat');

	% picks the query label
	qCl = classQ(i,1);
end
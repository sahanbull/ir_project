%% countDF: this function returns the list of document frequency for each word in a feature set
function [df] = countDF()
	load('testDummyData.mat');

	l = length(IDF);
	df = zeros(l,1);
	
	% foreach following feature in the current query
	for(i=1:l)
		% eleminate the docs in the corpus that dont have all of them
		df(i,1) = length(IDF{1,i});
	end

end
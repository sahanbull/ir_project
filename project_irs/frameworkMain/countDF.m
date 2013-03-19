%% countDF: this function returns the list of document frequency for each word in a feature set
function [idfs] = countDF()
	load('testDummyData.mat');

	l = length(IDF);
	idfs = zeros(l,1);

	% % start with first feature doc list 
	docList = IDF{1,1}; % assign to union set
	idfs(1,1) = length(IDF{1,1}); % count the df
	
	% foreach following feature 
	for(i=2:l)
		% eleminates duplicate entries and takes union
		docList = union(docList,IDF{1,i});
		idfs(i,1) = length(IDF{1,i});
	end

	N = length(docList); % number of total docs in the collection

	idfs = log10(N./idfs); % compute IDF scores
end
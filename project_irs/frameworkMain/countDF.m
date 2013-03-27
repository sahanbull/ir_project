%% countDF: this function returns the list of document frequency for each word in a feature set
function [idfs] = countDF()
	load('processed.mat');

	l = length(InvDocIndex);
	idfs = zeros(l,1);

	% % start with first feature doc list 
	docList = InvDocIndex{1,1}; % assign to union set
	idfs(1,1) = length(InvDocIndex{1,1}); % count the df
	
	% foreach following feature 
	for(i=2:l)
		% eleminates duplicate entries and takes union
		docList = union(docList,InvDocIndex{i,1});
		idfs(i,1) = length(InvDocIndex{i,1});
	end

	N = length(docList) % number of total docs in the collection

	idfs = log10(N./(1+idfs)); % compute IDF scores
end
%% findDocSet: finds the document set that has all the feaures asked for
function [docList] = findANDDocSet(features)
	% load the file with corpus:: changed later
	load('processed.mat');

	% start with first feature doc list 
	docList = InvDocIndex{features(1,1),1};
	
	% foreach following feature in the current query
	for(i=2:length(features))
		% eleminate the docs in the corpus that dont have all of them
		docList = union(docList,InvDocIndex{features(1,i),1});
	end
end
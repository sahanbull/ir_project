%% findDocSet: finds the document set that has all the feaures asked for
function [docList] = findDocSet(features)
	% load the file with corpus:: changed later
	load('testDummyData.mat');

	% start with first feature doc list 
	docList = IDF{1,features(1,1)}
	
	% foreach following feature in the current query
	for(i=2:length(features))
		% eleminate the docs in the corpus that dont have all of them
		docList = intersect(docList,IDF{1,features(1,i)});
	end
end
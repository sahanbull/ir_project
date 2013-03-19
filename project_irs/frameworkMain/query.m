%% query: generates a test query a buncha corpus to check my stuff.q
function query()		
	queryDum = rand(1,10);

	comparers = rand(20,10);

	thr = 0.1;

	IDF = cell(1,10);

	for(i=1:10)
		IDF{1,i} = (find(comparers(:,i)>thr))';
	end

	% set up IDF values for each visual term
	l = length(IDF);
	idfs = zeros(l,1);

	% start with first feature (visual term) in the doc list 
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


	test = randint(size(comparers,1)+1,1,[1 3]);

	classQ = test(length(test),1);
	classCorpus = test(1:length(test)-1,1);

	save('testDummyData.mat','queryDum','comparers','IDF','thr','idfs','classQ','classCorpus');

end

%% query: generates a test query a buncha corpus to check my stuff.q
function query()		
	queryDum = rand(1,10);

	comparers = rand(20,10);

	thr = 0.3;

	IDF = cell(1,10);

	for(i=1:10)
		IDF{1,i} = (find(comparers(:,i)>thr))';
	end

	save('testDummyData.mat','queryDum','comparers','IDF','thr');

end

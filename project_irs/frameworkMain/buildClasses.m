%% buildClasses: this function builds test classification for the testing data
function [classQ, classScorpus] = buildClasses()
		
	load('testDummyData.mat');

	test = randint(size(comparers,1)+1,1,[1 3]);

	classQ = test(length(test),1);
	classScorpus = test(1:length(test)-1,1);
end
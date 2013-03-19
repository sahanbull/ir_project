%% simTFIDF: this function evaluates score for TFIDF model for each query and comparer
function [score] = simTFIDF(comparer,Idfs)
	% comparer
	% Idfs

	% TFIDF is the vector product of comparer doc and Idfs
	score = comparer*Idfs;
end

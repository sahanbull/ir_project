%% simEnhTFIDF: this function uses cosine similarity : Weighted TFIDF
function [score] = simEnhTFIDF(query,comparer,Idfs)

	% compute TFIDF of every visual word in query
	q = query.*Idfs';
	% compute TRIDF of every visual word in document
	d = comparer'.*Idfs; 

	% score is sum product of two .. inversed to keep score scale
	score = 1./q*d;
end
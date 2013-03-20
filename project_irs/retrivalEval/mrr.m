function mrrScore = mrr(correctLabelVec, rankMatrix)
    [nTestImg nRank] = size(rankMatrix);
    mrrScoreVec = zeros(nTestImg,1);
    for i = 1:nTestImg
       for j = 1:nRank
           if(rankMatrix(i,j)==correctLabelVec(i))
               mrrScoreVec(i) = 1/j;
               break;
           end
       end
    end
    mrrScore = mean(mrrScoreVec);
end
function recallScoreVec = recallAtK(labelVec,rankMatrix,k)
    rankMatrix = rankMatrix(:,1:k);
    logicMatrix = (repmat(labelVec,1,k)==rankMatrix);
    recallScoreVec = sum(logicMatrix,2)./5000;
end
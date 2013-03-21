function mapScore = mapAtK(correctLabelVec,rankMatrix,k)
    scoreVec = avgPrecisionAtK(correctLabelVec,rankMatrix,k);
    mapScore = mean(scoreVec);
end

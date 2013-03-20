function scoreVec = mapAtK(correctLabelVec, rankMatrix, k)
    [nTestImg dummy] = size(correctLabelVec);
    [nTestImgDummy nRank] = size(rankMatrix);
    assert(nTestImg==nTestImgDummy,'nTestImg!=nTestImgDummy');
    logicMatrix = (repmat(correctLabelVec,1,k) == rankMatrix(:,1:k));
    resultVec = find((logicMatrix == 1)');
    scoreVec = zeros(nTestImg,1);
    j = 1;
    numHits = 0;
    for i = 1:length(resultVec)
        if ((resultVec(i)<=(j*k)) && (resultVec(i)>((j-1)*k)))
            numHits = numHits + 1;
            rank = mod(resultVec(i),k);
            if rank == 0
                rank = k;
            end
            scoreVec(j) = scoreVec(j) + numHits/rank;
        else
            numHits = 1;
            j = j+1;
            rank = mod(resultVec(i),k);
            if rank == 0
                rank = k;
            end
            scoreVec(j) = scoreVec(j) + numHits/rank;
        end
    end
    scoreVec = scoreVec./k;
end

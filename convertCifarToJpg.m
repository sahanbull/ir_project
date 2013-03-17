setup;
rootDir = 'cifar10_jpg';
cmd = sprintf('mkdir %s',rootDir);
eval(cmd);
nBatch = size(cifarData);
nBatch = nBatch(1);
nClass = 10;
classImgCount = zeros(nClass,1);
for batch = 1:nBatch
    cmd = sprintf('mkdir %s/batch_%i',rootDir,batch);
    eval(cmd);
    nImages = size(cifarData{batch,1});
    nImages = nImages(1);
    for img = 1:nImages
        fprintf(1,'Converting %i/%i of batch %i\n',img,nImages,batch);
        nFigure = figure;
        displayImg(cifarData{batch,1}(img,:));
        label = cifarData{batch,2}(img);
        classImgCount(label+1) = classImgCount(label+1)+1;
        cmd = sprintf('export_fig %s/batch_%i/label%i_img%i.jpg -jpg',rootDir,batch,label,classImgCount(label+1));
        eval(cmd);
        cmd = sprintf('close %i',nFigure);
        eval(cmd);
    end
end

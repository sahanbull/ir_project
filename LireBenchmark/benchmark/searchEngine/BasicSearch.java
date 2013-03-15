package searchEngine;

import net.semanticmetadata.lire.DocumentBuilder;
import net.semanticmetadata.lire.DocumentBuilderFactory;
import net.semanticmetadata.lire.ImageSearchHits;
import net.semanticmetadata.lire.ImageSearcher;
import net.semanticmetadata.lire.ImageSearcherFactory;
import net.semanticmetadata.lire.impl.ChainedDocumentBuilder;
import net.semanticmetadata.lire.impl.VisualWordsImageSearcher;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.store.FSDirectory;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.rmi.UnexpectedException;
import java.util.ArrayList;
import java.util.Collections;

public class BasicSearch {
    private static String seperator;
	private ArrayList<TestImg> testImgList;
	private ArrayList<IndexReader> indexReaderList;
	private ImageSearcher searcher;
    private final static Integer nRetrieve = new Integer(1000); // retrieve 1000 images
    
	public String indexDirectory;
	public String testSetDirectory;
	public String feature;
	public String actualFeature;
    
    private ImageSearcher getSearcher(String featureName){
    	int maximumHits = nRetrieve;
    	switch(featureName){
    	case "AutoColorCorrelogram": actualFeature = "AutoColorCorrelogram";return ImageSearcherFactory.createAutoColorCorrelogramImageSearcher(maximumHits);
    	case "ScalableColor": actualFeature = "ScalableColor";return ImageSearcherFactory.createScalableColorImageSearcher(maximumHits);
    	case "CEDD": actualFeature = "CEDD";return ImageSearcherFactory.createCEDDImageSearcher(maximumHits);
    	case "ColorHistogram": actualFeature = "ColorHistogram";return ImageSearcherFactory.createColorHistogramImageSearcher(maximumHits);
    	case "ColorLayout": actualFeature = "ColorLayout";return ImageSearcherFactory.createColorLayoutImageSearcher(maximumHits);
    	case "Tamura": actualFeature = "Tamura";return ImageSearcherFactory.createTamuraImageSearcher(maximumHits);
    	case "EdgeHistogram": actualFeature = "EdgeHistogram";return ImageSearcherFactory.createEdgeHistogramImageSearcher(maximumHits);
    	case "FCTH": actualFeature = "FCTH";return ImageSearcherFactory.createFCTHImageSearcher(maximumHits);
    	case "Gabor": actualFeature = "Gabor";return ImageSearcherFactory.createGaborImageSearcher(maximumHits);
    	case "JCD": actualFeature = "JCD";return ImageSearcherFactory.createJCDImageSearcher(maximumHits);
    	case "JpegCoefficientHistogram": actualFeature = "JpegCoefficientHistogram";return ImageSearcherFactory.createJpegCoefficientHistogramImageSearcher(maximumHits);
    	default: actualFeature = "ColorHistogram";return ImageSearcherFactory.createColorHistogramImageSearcher(maximumHits);
    	}
    }
    
    private ArrayList<TestImg> getTestImgList(String dir) throws Exception{
    	String directory = dir.endsWith(seperator)?(dir):(dir+seperator);
    	ArrayList<TestImg> testImgList = new ArrayList<TestImg>();
    	File dirFileObj = new File(directory);
    	for(File jpgFileObj:dirFileObj.listFiles()){
    		testImgList.add(new TestImg(directory+jpgFileObj.getName()));
    	}
    	return testImgList;
    }
    
    private ArrayList<IndexReader> getIndexReaderList(String dir) throws IOException{
    	ArrayList<IndexReader> indexReaderList = new ArrayList<IndexReader>();
    	String directory = dir.endsWith(seperator)?(dir):(dir+seperator);
    	File dirFileObj = new File(directory);
    	File[] subDirFileObjArray = dirFileObj.listFiles();
    	for(File subDirFileObj:subDirFileObjArray){
    		indexReaderList.add(IndexReader.open(FSDirectory.open(new File(directory+subDirFileObj.getName()))));
    	}
    	return indexReaderList;
    }
    
    public ArrayList<ArrayList<String>> runBenchmark() throws IOException{
    	System.out.println("Running benchmark...");
    	System.out.println(" -> Feature: "+actualFeature);
    	
    	ArrayList<ArrayList<String>> rankTable = new ArrayList<ArrayList<String>>();
    	ImageSearchHits hits = null;
    	int j = 0;
    	for(TestImg queryImg:testImgList){
    		System.out.println(" -> Benchmarking test image "+(++j)+" out of "+testImgList.size());
    		ArrayList<RetrievedImg> retrievedList = new ArrayList<RetrievedImg>();
    		for(IndexReader reader:indexReaderList){
    			hits = searcher.search(queryImg.imageBuffer, reader);
    			for(int i=0;i<hits.length();i++){
    				retrievedList.add(new RetrievedImg(hits.doc(i),hits.score(i)));
    			}
    		}
    		Collections.sort(retrievedList);
    		ArrayList<String> labelList = new ArrayList<String>();
    		labelList.add(queryImg.trueLabel);
    		for(RetrievedImg img:retrievedList){
    			labelList.add(img.label);
    		}
    		rankTable.add(labelList);
    	}
    	return rankTable;
    }
    
    public BasicSearch(String useFeature, String indexDir, String testSetDir){
    	seperator = (System.getProperty("os.name").toLowerCase().contains("win"))?("\\"):("/");
    	indexDirectory = indexDir.endsWith(seperator)?(indexDir):(indexDir+seperator);
    	testSetDirectory = testSetDir.endsWith(seperator)?(testSetDir):(testSetDir+seperator);
    	feature = useFeature;
    	try {
    		testImgList = getTestImgList(testSetDirectory);
    		indexReaderList = getIndexReaderList(indexDirectory);
    		searcher = getSearcher(feature);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}

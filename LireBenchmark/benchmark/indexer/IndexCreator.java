package indexer;

import net.semanticmetadata.lire.DocumentBuilder;
import net.semanticmetadata.lire.DocumentBuilderFactory;
import net.semanticmetadata.lire.impl.ChainedDocumentBuilder;
import net.semanticmetadata.lire.utils.FileUtils;
import net.semanticmetadata.lire.utils.LuceneUtils;

import org.apache.lucene.analysis.core.SimpleAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.FSDirectory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class IndexCreator {
 
    private static DocumentBuilder getDocumentBuilder() {
        ChainedDocumentBuilder result = new ChainedDocumentBuilder();
        result.addBuilder(DocumentBuilderFactory.getAutoColorCorrelogramDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getScalableColorBuilder());
        result.addBuilder(DocumentBuilderFactory.getCEDDDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getColorHistogramDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getColorLayoutBuilder());
        result.addBuilder(DocumentBuilderFactory.getTamuraDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getEdgeHistogramBuilder());
        result.addBuilder(DocumentBuilderFactory.getFCTHDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getGaborDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getJCDDocumentBuilder());
        result.addBuilder(DocumentBuilderFactory.getJpegCoefficientHistogramDocumentBuilder());
        return result;
    }
    
    public static void createIndex(String rootPath, HashMap<String,ArrayList<String>> imgDirTree) throws IOException, InterruptedException {
    	Object[] subDirArray = imgDirTree.keySet().toArray();
    	
    	Integer nImgFiles = new Integer(0);
    	for(Object subDirNameObj:subDirArray){
    		String subDirName = subDirNameObj.toString();
    		nImgFiles += imgDirTree.get((String)subDirName).size();
    	}
    	
    	Integer i = new Integer(0);
        ChainedDocumentBuilder builder = (ChainedDocumentBuilder) getDocumentBuilder();
        for(Object subDirNameObj:subDirArray){
        	String subDirName = subDirNameObj.toString();
        	IndexWriter iw = LuceneUtils.createIndexWriter(rootPath + "index_"+subDirName, true);
        	ArrayList<String> jpgFileList = imgDirTree.get(subDirName);
        	Iterator<String> jpgFileItr = jpgFileList.iterator();
        	while(jpgFileItr.hasNext()){
        		String jpgFileName = jpgFileItr.next();
        		String jpgFullPath = rootPath+subDirName+"/"+jpgFileName;
        		System.out.println("Indexing "+ (++i) +" out of "+nImgFiles+": "+jpgFullPath);
        		try{
        			Document doc = builder.createDocument(new FileInputStream(jpgFullPath), jpgFileName);
        			iw.addDocument(doc);
        		}catch(UnsupportedOperationException e){
        			String eMsg = e.getMessage();
        			String cmd = new String("convert ");
        			cmd = cmd + jpgFullPath + " -colorspace RGB -type truecolor " + jpgFullPath;
        			if(eMsg.matches(".*Color space not supported.*")){
        				System.out.print(" -> Indexing failed! Trying to convert image to RGB...");
        				Runtime rt = Runtime.getRuntime();
        				rt.exec(cmd);
        				System.out.println("OK!");
        				//TODO: ugly hack, but it works!
        				Thread.sleep(2000);
        				System.out.print(" -> Attempting to index the converted image...");
        				Document doc = builder.createDocument(new FileInputStream(jpgFullPath), jpgFileName);
        				System.out.println("OK!");
        				iw.addDocument(doc);
        			}else{
        				throw new UnsupportedOperationException(eMsg);
        			}
        		}
        	}
        	iw.close();
        }
    } 
    
    // Assume the directory is only 1 level deep (i.e.: rootDir->subDir->images)
    private static HashMap<String,ArrayList<String>> getImgFileNames(String root){
    	HashMap<String,ArrayList<String>> dirTree = new HashMap<String,ArrayList<String>>();
    	File rootDir = new File(root);
    	for(File subDir:rootDir.listFiles()){
    		String subDirNameStr = subDir.getName();
    		if(!subDirNameStr.startsWith("batch_")){
    			continue;
    		}
    		ArrayList<String> jpgFileList = new ArrayList<String>();
    		for(File jpgFile:subDir.listFiles()){
    			if(jpgFile.getName().endsWith(".jpg")){
    				jpgFileList.add(jpgFile.getName());
    			}
    		}
    		dirTree.put(subDirNameStr, jpgFileList);
    	}
    	return dirTree;
    }
    
    
    public static void main(String[] args) throws IOException{
    	//String imgDataDir = "/home/jonang/csmlInfoRetrieval/projGitHub/cifar10_jpg/";
    	String imgDataDir = args[0];
    	HashMap<String,ArrayList<String>> imgDirTree = getImgFileNames(imgDataDir);
    	try {
			createIndex(imgDataDir,imgDirTree);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    

}

package searchEngine;

import java.io.IOException;
import java.util.ArrayList;

import searchEngine.BasicSearch;

public class TestBasicSearch {
	public static void main(String args[]) throws IOException{
		String feature = "AutoColorCorrelogram";
		String indexDir = "/home/jonang/csmlInfoRetrieval/projGitHub/cifar10_jpg/index";
		String testSetDir = "/home/jonang/csmlInfoRetrieval/projGitHub/cifar10_jpg/test";
		BasicSearch searchObj = new BasicSearch(feature, indexDir, testSetDir);
		ArrayList<ArrayList<String>> rankTable = searchObj.runBenchmark();
		for(ArrayList<String> list:rankTable){
			for(String label:list){
				System.out.print(label+", ");
			}
			System.out.println("");
		}
	}
}

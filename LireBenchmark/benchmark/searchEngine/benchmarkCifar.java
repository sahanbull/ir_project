package searchEngine;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.rmi.UnexpectedException;
import java.util.ArrayList;

public class benchmarkCifar {
	public static void main(String args[]) throws Exception{
		if(args.length!=3){
			System.out.println("Features:\nAutoColorCorrelogram\nScalableColor\nCEDD\nColorHistogram\nColorLayout\nTamura\nEdgeHistogram\nFCTH\nGabor\nJCD\nJpegCoefficientHistogram");
			System.out.println("3 input arguments needed! [feature] [index dir] [test img dir]");
			System.exit(1);
		}
		String feature = args[0];
		String indexDir = args[1];
		String testSetDir = args[2];
		File file = new File("cifarBenchmarkResult.csv");
		file.createNewFile();
		FileWriter fw = new FileWriter(file.getAbsoluteFile());
		BufferedWriter bw = new BufferedWriter(fw);
		BasicSearch searchObj = new BasicSearch(feature, indexDir, testSetDir);
		ArrayList<ArrayList<String>> rankTable = searchObj.runBenchmark();
		for(ArrayList<String> list:rankTable){
			for(String label:list){
				bw.write(label+", ");
			}
			bw.write("\n");
		}
		bw.close();
	}
}

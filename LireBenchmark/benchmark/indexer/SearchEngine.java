package indexer;

import net.semanticmetadata.lire.DocumentBuilder;
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

public class SearchEngine {
    private String[] testFiles = new String[]{"img01.JPG", "img02.JPG", 
		"img03.JPG", "img04.JPG", "img05.JPG"};
    private String testFilesPath = "./src/test/resources/images/";
    private String indexPath = "test-index-small";
 
    public void testSearch() throws IOException {
	// Opening an IndexReader (Lucene v3.0+)
        IndexReader reader = IndexReader.open(FSDirectory.open(new File(indexPath)));
	// Creating an ImageSearcher
        ImageSearcher searcher = ImageSearcherFactory.createCEDDImageSearcher(50);
	// Reading the sample image, which is our "query"
        FileInputStream imageStream = new FileInputStream(testFilesPath + testFiles[0]);
        BufferedImage bimg = ImageIO.read(imageStream);
	// Search for similar images
        ImageSearchHits hits = null;
	hits = searcher.search(bimg, reader);
	// print out results
        for (int i = 0; i < 4; i++) {
            System.out.println(hits.score(i) + ": " + 
				hits.doc(i).getField(DocumentBuilder.FIELD_NAME_IDENTIFIER).stringValue());
        }
    }
}

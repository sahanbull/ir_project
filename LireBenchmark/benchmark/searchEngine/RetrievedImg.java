package searchEngine;

import java.rmi.UnexpectedException;

import net.semanticmetadata.lire.DocumentBuilder;

import org.apache.lucene.document.Document;

public class RetrievedImg implements Comparable<RetrievedImg>{
	public float score;
	public String label;

	public int compareTo(RetrievedImg anotherInstance){
		return (this.score>=anotherInstance.score)?1:-1;
	}
	
	public RetrievedImg(Document doc,float imgScore) throws UnexpectedException{
		this.score = imgScore;
		String docName = doc.getField(DocumentBuilder.FIELD_NAME_IDENTIFIER).stringValue();
		if(!docName.startsWith("label")){throw new UnexpectedException("Unknown File Name in Retrieval Set! ("+docName+")");}
		this.label = docName.substring(5, 6);
	}
}

package searchEngine;

import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.rmi.UnexpectedException;

import javax.imageio.ImageIO;

public class TestImg {
	public String location;
	public String trueLabel;
	public BufferedImage imageBuffer;
	private static String seperator = (System.getProperty("os.name").toLowerCase().contains("win"))?("\\"):("/");
	public TestImg(String loc) throws Exception{
		this.location = loc;
		this.imageBuffer = ImageIO.read(new FileInputStream(loc));
		String[] temp = loc.split(seperator);
		String imgFileName = temp[temp.length-1];
		if(imgFileName.contains("label")){
			this.trueLabel = imgFileName.substring(5, 6);
		}else{
			throw new UnexpectedException("Test image's file name does not contain label info. ("+imgFileName+")");
		}
	}
}
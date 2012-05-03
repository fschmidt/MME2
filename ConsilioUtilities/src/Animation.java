import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;


public class Animation {
	private String name;
	private List<String> fileNames;
	private int numberOfFrames;
	private int animationDelay;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<String> getFileNames() {
		return fileNames;
	}
	public int getNumberOfFrames() {
		return numberOfFrames;
	}
	public void setNumberOfFrames(int numberOfFrames) {
		this.numberOfFrames = numberOfFrames;
	}
	public int getAnimationDelay() {
		return animationDelay;
	}
	public void setAnimationDelay(int animationDelay) {
		this.animationDelay = animationDelay;
	}
	public void addFileName(String fileName) {
		if(fileNames == null){
			fileNames = new LinkedList<String>();
		}
		fileNames.add(fileName);
	}
}

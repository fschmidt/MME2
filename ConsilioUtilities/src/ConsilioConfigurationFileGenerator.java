import java.io.File;
import java.io.FileFilter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;

public class ConsilioConfigurationFileGenerator {
	private static final String LINE = "---------------------------------------------";
	public static final String BASEPATH = System.getProperty("user.home") + "/pieces/";
	public static final String TARGETPATH = System.getProperty("user.home")
			+ "/test/";

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		createBoardConfigurationFile();
		FileGenerator f = new FileGenerator();
//		f.createNewFolderLayout();
		f.createSpriteConfigurationFiles();
	}

	private static void createBoardConfigurationFile() {
//		BoardData bd = new BoardData();
//		bd.addPiece("queen", "a1", "ne");
//
//		JsonParser.createJson(new File(BASEPATH + "boardData.json"), bd,
//				BoardData.class);
		
		
	}
}

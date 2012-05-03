import java.io.File;
import java.io.FileFilter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

public class FileGenerator {

	private static final String LINE = "---------------------------------------------";
	public static final String TARGETPATH = System.getProperty("user.home")
			+ "/test/";

	public void createSpriteConfigurationFiles() {
		String basepath = ConsilioConfigurationFileGenerator.BASEPATH;
		File baseDirectory = new File(basepath);
		File[] folders = baseDirectory.listFiles();

		for (File file : folders) {
			
			String name = file.getName();
			SpriteData sd = new SpriteData(name,name + "AnimationData.json", name + ".png", 55, 65, new Attributes());

			
			
			File newFile = new File(TARGETPATH + sd.getName() + ".json");
			JsonParser.createJson(newFile, sd, SpriteData.class);

		}
	}

	
	public void createNewFolderLayout() {
		String basepath = ConsilioConfigurationFileGenerator.BASEPATH;
		
		File baseDirectory = new File(basepath);
		File[] folders = baseDirectory.listFiles();

		for (File file : folders) {

			LinkedList<File> images = new LinkedList<File>(Arrays.asList(file
					.listFiles(new FileFilter() {

						@Override
						public boolean accept(File f) {
							return f.getName().endsWith(".png");
						}
					})));

			HashMap<String, List<File>> animations = new HashMap<String, List<File>>();

			while (!images.isEmpty()) {
				File f = images.pop();
				String animName = f.getName().substring(0,
						f.getName().length() - 8);
				if (!animations.containsKey(animName)) {
					animations.put(animName, new LinkedList<File>());
				}
				animations.get(animName).add(f);
			}
			
			File newDirectory = new File(TARGETPATH + file.getName());
			newDirectory.mkdir();
			
			for (String key : animations.keySet()) {
				File animDir = new File(newDirectory.getAbsolutePath() + "/" + key);
				animDir.mkdir();
				String targetPath = animDir.getAbsolutePath();
				for(File f:animations.get(key)){
					f.renameTo(new File(targetPath + "/" + f.getName()));
				}
			}
		}
	}

}

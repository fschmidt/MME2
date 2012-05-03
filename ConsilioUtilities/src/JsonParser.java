
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;

import com.google.gson.Gson;

/**
 * This class provides a static method to parse JSON data from a {@link Reader}
 * object into an object of the given Type.
 * 
 * @author Frank Schmidt
 * 
 */
public final class JsonParser {
    private JsonParser() {
    }

    /**
     * Parses JSON data from a {@link Reader} into an object of the given Type
     * 
     * @param reader
     *            The source of the json String
     * @param classOfT
     *            The Type of the desired class
     * @return An object of the given Type
     */
    public static <T> T getJson(Reader reader, Class<T> classOfT) {
        Gson gson = new Gson();
        return gson.fromJson(reader, classOfT);
    }
    
    public static <T> void createJson(File destination, Object source, Class<T> classOfT){
    	try {
			FileWriter fw = new FileWriter(destination);
			Gson gson = new Gson();
			gson.toJson(source, classOfT, fw);
			fw.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
}

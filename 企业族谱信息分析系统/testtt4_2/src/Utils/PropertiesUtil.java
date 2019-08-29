package Utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertiesUtil {
	
	public static String getValue(String key) {
		Properties prop = new Properties();
		InputStream in = new PropertiesUtil().getClass().getResourceAsStream("/platform.properties");
		try {
			prop.load(in);
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		return (String)prop.get(key);
	}
}

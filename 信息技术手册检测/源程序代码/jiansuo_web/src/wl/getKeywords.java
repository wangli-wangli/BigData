package wl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class getKeywords {
	public static List<String> keywords(String name,String explain1) {
        String keyword=null;
        String abstractt=null;
        List<String> returnn=new ArrayList<String>();
    	try {
			String[] ars = new String[] { "python", "F:\\Python_Document\\abstract\\getAbstract.py",name,explain1};
			Process proc = Runtime.getRuntime().exec(ars);// 执行py文件
			BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
			String line = null;
			while ((line = in.readLine()) != null) {
				returnn.add(line);
			}
			in.close();
			proc.waitFor();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
         return returnn;

    }

}

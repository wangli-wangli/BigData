package wl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.python.core.PyFunction;

import org.python.core.PyInteger;

import org.python.core.PyObject;
import org.python.core.PyString;
import org.python.util.PythonInterpreter;

 

public class classify {
    public static String classify(String explain1) {
        String cla=null;
    	try {
			String[] ars = new String[] { "python", "F:\\Python_Document\\abstract\\classify.py",explain1};
			Process proc = Runtime.getRuntime().exec(ars);// 执行py文件

			BufferedReader in = new BufferedReader(new InputStreamReader(proc.getInputStream()));
			String line = null;
			while ((line = in.readLine()) != null) {
				cla=line;
			}
			in.close();
			proc.waitFor();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
         return cla;

    }

}
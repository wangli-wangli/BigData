package zuoye1_2;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class readFile {

	public static List<String> toArrayByInputStreamReader1() {

		ArrayList<String> arrayList = new ArrayList<>();
		try {
			File file = new File("F:\\������\\����ҵ\\�ִʺ���ļ�\\data5_xinxi.txt");
			InputStreamReader inputReader = new InputStreamReader(new FileInputStream(file),"utf-8");
			BufferedReader bf = new BufferedReader(inputReader); // ���ж�ȡ�ַ���
			String str;
			int i=0;
			while ((str = bf.readLine()) != null) {
				String[] arr=str.split("\t");
				arrayList.add(arr[0]);
			}
			
			bf.close();
			inputReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} // ��ArrayList�д洢���ַ������д���
		
		return arrayList;
	}

	

	/*public static void main(String[] args) {
		System.out.println(readFile.toArrayByInputStreamReader1());
	}*/

}

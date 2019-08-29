package testt2;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public  class readFile {
	/**
	 * 以行为单位读取文件，常用于读面向行的格式化文件
	 */
	public  String[][] readFileByLines(String fileName) {
		File file = new File(fileName);
		BufferedReader reader = null;
		String data[][]=new String[2][10];
		try {
			System.out.println("以行为单位读取文件内容，一次读一整行：");
			reader = new BufferedReader(new FileReader(file));
			String tempString = null;
			
			// 一次读入一行，直到读入null为文件结束
			for (int i = 0; i < 10; i++) {
				tempString = reader.readLine();
				// 显示行号
				String arr[] = tempString.split("\t");
				System.out.println(arr[0] + ": " + arr[1]);
				data[0][i]=arr[0];
				data[1][i]=arr[1];
				
			}
			reader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (reader != null) {
				try {
					reader.close();
				} catch (IOException e1) {
				}
			}
		}
		return data;
	}
	
	/*public static void main(String[] args) {
		readFileByLines("/home/hadoop/Documents/file2.txt");
	}*/

}

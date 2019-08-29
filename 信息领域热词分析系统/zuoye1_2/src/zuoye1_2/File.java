package zuoye1_2;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;

public class File {

	  public static void WriteStringToFile2(List<mean>  models) {

	        try {

	            FileWriter fw = new FileWriter("F:\\大数据\\大作业\\词语意思\\data6_xinxi.txt", true);

	            BufferedWriter bw = new BufferedWriter(fw);
                for(mean model:models) {
	            bw.append(model.getWord());

	            bw.write("\t");// 往已有的文件上添加字符串

	            bw.write(model.getMeann());

	            //bw.write("\t");
	            //bw.write(model.getAuthor());
	            bw.write("\r\n");
                }

	            bw.close();

	            fw.close();

	        } catch (Exception e) {

	            // TODO Auto-generated catch block

	            e.printStackTrace();

	        }

	    }
	  
	/*  public static void main(String[] args) {
		  List<String> array=readFile.toArrayByInputStreamReader1();
		  List<mean> array2=new ArrayList<mean>();
		  for(String arr:array) {
			  //MingciPangProcessor.shuru(arr);
			  array2.add( MingciPangProcessor.mean1);
			  
		  }
		  System.out.println("爬取完毕！");
		  File.WriteStringToFile2(array2);
	  }*/
	  
	  


}

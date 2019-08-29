package zuoye1;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.List;

public class File {

	  public static void WriteStringToFile2(List<JavaBokeModel>  models) {

	        try {

	            FileWriter fw = new FileWriter("F:\\大数据\\大作业\\爬取到的数据\\data1_xinxi.txt", true);

	            BufferedWriter bw = new BufferedWriter(fw);
                for(JavaBokeModel model:models) {
	            bw.append(model.getTitle());

	            bw.write("\t");// 往已有的文件上添加字符串

	            bw.write(model.getLinke());

	            bw.write("\t");
	            bw.write(model.getAuthor());
	            bw.write("\r\n");
                }

	            bw.close();

	            fw.close();

	        } catch (Exception e) {

	            // TODO Auto-generated catch block

	            e.printStackTrace();

	        }

	    }


}

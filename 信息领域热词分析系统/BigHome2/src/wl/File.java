package wl;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class File {
	static int count=1; 
	static int c=0;
   static String[] q= {"一","二","三","四","五","六","七"};
 
	  public static void WriteStringToFile2(List<mean>  means,String type,String name) {

	        try {
	        	
	            FileWriter fw = new FileWriter(name, true);
	            BufferedWriter bw = new BufferedWriter(fw);
	            bw.append(q[c]+"."+type);//类别
              	bw.write("\n");
                for(mean model:means) {
                String word=model.getWord();//标题
	            bw.write(count+"."+model.getWord());
	            bw.write("\n");
	            bw.write("   ");
	            bw.write(model.getMeann());
	            bw.write("\r\n");
	            count++;
                }

	            bw.close();

	            fw.close();

	        } catch (Exception e) {

	            // TODO Auto-generated catch block

	            e.printStackTrace();

	        }

	    }
	  
	  
	  public static void down() {
		  c=0;
		  String[] type= {"程序人生","大数据","运维","编程语言","区块链","架构","人工智能"};
		  Date day=new Date();    
		  SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");   
		  String name="C:\\Users\\lenovo\\Desktop\\热词解释"+df.format(day)+".docx";
		  mulu(name);
		  for(int i=0;i<type.length;i++) {
			  count=1;
			  List<mean> words=dao.find_allwords1(type[i]);
			  WriteStringToFile2(words,type[i],name);
			  c++;
		  }
		  
				  
	  }
	  
	  public static void mulu(String name) {
       try {
	        	
	            FileWriter fw = new FileWriter(name, true);
	            BufferedWriter bw = new BufferedWriter(fw);
	            bw.append("                          信息领域热词解释");//类别
              	bw.write("\n");
              	bw.write("\n");
              	bw.write("\n");
	            bw.write("一.程序人生....................................................................1");
	            bw.write("\n");
	            bw.write("二.大数据......................................................................2");
	            bw.write("\n");
	            bw.write("三.运维........................................................................2");
	            bw.write("\n");
	            bw.write("四.编程语言....................................................................3");
	            bw.write("\n");
	            bw.write("五.区块链......................................................................4");
	            bw.write("\n");
	            bw.write("六.架构....................................................................... 4");
	            bw.write("\n");
	            bw.write("六.人工智能....................................................................5");
	            bw.write("\n");
	            bw.write("\n");
	            bw.write("\n");
	            bw.write("\n");
	            bw.write("\n");
	            bw.write("\n");
	            bw.close();

	            fw.close();

	        } catch (Exception e) {

	            // TODO Auto-generated catch block

	            e.printStackTrace();

	        }
		  
	  }
	  
	  


}

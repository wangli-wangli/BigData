package zuoye1_2;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import us.codecraft.webmagic.Spider;


public class bianli {
	public static void main(String[] args) {
		long startTime,endTime;
		startTime=new Date().getTime();
		
	    List listUrl=new ArrayList<String>();
	   	 List<String> titles=new ArrayList<String>();
	   	 for(String title:titles) {	
	   		Spider create=Spider.create(new MingciPangProcessor());
		    create.addUrl("https://baike.baidu.com/item/"+title).thread(5).run();
	   	 }
		endTime=new Date().getTime();
		System.out.println("ÓÃÊ±Îª£º"+(endTime-startTime)/1000+"s");
	
	}
	
}

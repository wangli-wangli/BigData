package zuoye1;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

public class BlogPageProcessor implements PageProcessor {

	private static Connection conn = null;

	private static PreparedStatement ps = null;
	// 标题和链接获取

	private static String TITLEQUERY = "div.post_item_body h3 a.titlelnk";

	// 作者

	private static String AUTHORQUERY = "div.post_item_foot a.lightblue ";

	
     //初始化带爬取网页地址
     private static List<String> urls() {
    	 List listUrl=new ArrayList<String>();
    	 for(int i=171;i<=200;i++) {
    		 listUrl.add("http://www.cnblogs.com/"+i);	 
    	 }
    	 listUrl.toArray(new String[listUrl.size()]);
    	 return listUrl;
     }

     //jsoup根据html字符串和语法来获取内容
     private static String selectDocumentText(String htmlText,String Query) {
    	 Document doc=Jsoup.parse(htmlText);
    	 String select=doc.select(Query).text();
    	 return select;
     }
     
     //jsoup根据html字符串和语法获取链接地址
     private static String selectDocumentLink(String htmlText,String Query) {
    	 Document doc=Jsoup.parse(htmlText);
    	 String select=doc.select(Query).attr("href");
    	 return select;
     }
     
	@Override
	public Site getSite() {
		return Site.me().setSleepTime(1000).setRetryTimes(10);
	}

	
	//编写抽取逻辑
	@Override
	public void process(Page page) {
		
		page.addTargetRequests(urls());
		//定义如何抽取页面信息
		
		List<String> htmls=page.getHtml().xpath("//div[@class='post_item']/html()").all();
		
		List<JavaBokeModel> javaBokes=new ArrayList<JavaBokeModel>();
		for(String html:htmls) {
			JavaBokeModel javaBoke=new JavaBokeModel();
		//标题和链接
			String title=selectDocumentText(html,TITLEQUERY);
			
			String linke=selectDocumentLink(html,TITLEQUERY);
	    //作者和作者主页
			String author=selectDocumentText(html,AUTHORQUERY);
			
		//简介
			
			//System.out.println(title);
			javaBoke.setTitle(title);
			javaBoke.setAuthor(author);
			
			javaBoke.setLinke(linke);
		
			javaBokes.add(javaBoke);
		    
		}
		
		File.WriteStringToFile2(javaBokes);
		

	}
	
	public static void main(String[] args) {
		long startTime,endTime;
		DBUtil.getConnection();
		startTime=new Date().getTime();
		Spider create=Spider.create(new BlogPageProcessor());
	    create.addUrl("http://www.cnblogs.com/").thread(5).run();
		try {
			ps.close();
			conn.close();
		}catch(Exception e) {
			
		}
		endTime=new Date().getTime();
		System.out.println("用时为："+(endTime-startTime)/1000+"s");
	
	}

}

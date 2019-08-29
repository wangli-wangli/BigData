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
	// ��������ӻ�ȡ

	private static String TITLEQUERY = "div.post_item_body h3 a.titlelnk";

	// ����

	private static String AUTHORQUERY = "div.post_item_foot a.lightblue ";

	
     //��ʼ������ȡ��ҳ��ַ
     private static List<String> urls() {
    	 List listUrl=new ArrayList<String>();
    	 for(int i=171;i<=200;i++) {
    		 listUrl.add("http://www.cnblogs.com/"+i);	 
    	 }
    	 listUrl.toArray(new String[listUrl.size()]);
    	 return listUrl;
     }

     //jsoup����html�ַ������﷨����ȡ����
     private static String selectDocumentText(String htmlText,String Query) {
    	 Document doc=Jsoup.parse(htmlText);
    	 String select=doc.select(Query).text();
    	 return select;
     }
     
     //jsoup����html�ַ������﷨��ȡ���ӵ�ַ
     private static String selectDocumentLink(String htmlText,String Query) {
    	 Document doc=Jsoup.parse(htmlText);
    	 String select=doc.select(Query).attr("href");
    	 return select;
     }
     
	@Override
	public Site getSite() {
		return Site.me().setSleepTime(1000).setRetryTimes(10);
	}

	
	//��д��ȡ�߼�
	@Override
	public void process(Page page) {
		
		page.addTargetRequests(urls());
		//������γ�ȡҳ����Ϣ
		
		List<String> htmls=page.getHtml().xpath("//div[@class='post_item']/html()").all();
		
		List<JavaBokeModel> javaBokes=new ArrayList<JavaBokeModel>();
		for(String html:htmls) {
			JavaBokeModel javaBoke=new JavaBokeModel();
		//���������
			String title=selectDocumentText(html,TITLEQUERY);
			
			String linke=selectDocumentLink(html,TITLEQUERY);
	    //���ߺ�������ҳ
			String author=selectDocumentText(html,AUTHORQUERY);
			
		//���
			
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
		System.out.println("��ʱΪ��"+(endTime-startTime)/1000+"s");
	
	}

}

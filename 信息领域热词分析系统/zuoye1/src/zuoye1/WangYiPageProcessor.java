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

public class WangYiPageProcessor implements PageProcessor {

	private static Connection conn = null;

	private static PreparedStatement ps = null;
	// ��������ӻ�ȡ

	private static String TITLEQUERY = "a";
	private static String TITLEQUERY2 = " h3 a";
	// ����
	private static String AUTHORQUERY = "div.fl a.source ";
	

	
     //��ʼ������ȡ��ҳ��ַ
     private static List<String> urls() {
    	 List<String> listUrl=new ArrayList<String>();
    	 String[] type=new String[]{"fashion","sports","money","tech","sjz.house","auto","jiankang","travel","gongyi","art"};
    	 for(int i=0;i<type.length;i++) {
             String url2="http://"+type[i]+".163.com/";
    		 listUrl.add(url2);	
    	 }
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
		String path1="//div[@class='topnews']//ul[@class='topnews_nlist']//li/html()";
		List<String> htmls=page.getHtml().xpath("//div[@class='topnews']//ul[@class='topnews_nlist']//li/html()").all();
		htmls.addAll(page.getHtml().xpath("//div[@class='scroll_comment_bd']//ul[@class='scroll_ul lf_comment_lists']//li/html()").all());
		
		//System.out.println(htmls);
		List<JavaBokeModel> javaBokes=new ArrayList<JavaBokeModel>();
		for(String html:htmls) {
			
			JavaBokeModel javaBoke=new JavaBokeModel();
		//���������
			String title=selectDocumentText(html,TITLEQUERY);
			
			String linke=selectDocumentLink(html,TITLEQUERY);
	    //���ߺ�������ҳ
			String author=selectDocumentText(html,AUTHORQUERY);
			
		//���
			
			System.out.println(title+"   "+linke+"   "+author);
			javaBoke.setTitle(title);
			javaBoke.setAuthor(author);
			
			javaBoke.setLinke(linke);
		
			javaBokes.add(javaBoke);
		    
		}
		
		//File.WriteStringToFile2(javaBokes);
		

	}
	
	public static void main(String[] args) {
		long startTime,endTime;
		DBUtil.getConnection();
		startTime=new Date().getTime();
		Spider create=Spider.create(new WangYiPageProcessor());
	    create.addUrl("http://ent.163.com/").thread(5).run();
		try {
			ps.close();
			conn.close();
		}catch(Exception e) {
			
		}
		endTime=new Date().getTime();
		System.out.println("��ʱΪ��"+(endTime-startTime)/1000+"s");
	
	}

}

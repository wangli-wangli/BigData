package wl;

import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

public class select  implements PageProcessor{

	static  public mean mean2=new mean();

	@Override
	public Site getSite() {
		return Site.me().setSleepTime(1000).setRetryTimes(10);
	}
	
	  private static String selectDocumentText(String htmlText) {
		   	 Document doc=Jsoup.parse(htmlText);
		   	 String select=doc.text();
		   	 return select;
		    }

	@Override
	public void process(Page page) {
	
		//定义如何抽取页面信息
		List<String> htmls=page.getHtml().xpath("//div[@class='lemma-summary']/html()").all();
		for(String html:htmls) {
		mean2.setMeann(selectDocumentText(html));
		}
		
	}
	
	public  void shuru(String word) {
		mean2.setWord(word);
		long startTime,endTime;
		startTime=new Date().getTime();
		Spider create=Spider.create(new select());
		 String strr="https://baike.baidu.com/item/"+word;
	     create.addUrl(strr).thread(1).run();
		 endTime=new Date().getTime();
		 System.out.println("用时为："+(endTime-startTime)/1000+"s");
	   }

}

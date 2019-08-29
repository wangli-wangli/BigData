package zuoye1_2;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;


public class MingciPangProcessor implements PageProcessor{

	public static List<String> titles;
	
	public static List<mean> mean2=new ArrayList<mean>();
	public static int i=0;
	public static List<String> words=new ArrayList<String>();
	@Override
	public Site getSite() {
		return Site.me().setSleepTime(1000).setRetryTimes(10);
	}

	 //jsoup����html�ַ������﷨����ȡ����
    private static String selectDocumentText(String htmlText) {
   	 Document doc=Jsoup.parse(htmlText);
   	 String select=doc.text();
   	 return select;
    }
    
    //��ʼ������ȡ��ҳ��ַ
    private static List<String> urls() {
   	 List listUrl=new ArrayList<String>();
   	 titles=readFile.toArrayByInputStreamReader1();
   	 
   	 for(String title:titles) {
   		 listUrl.add("https://baike.baidu.com/item/"+title);
   		 words.add(title);
   		 
   	 }
   	 listUrl.toArray(new String[listUrl.size()]);
   	 return listUrl;
    }
    
	@Override
	public void process(Page page) {
		
		page.addTargetRequest(urls().get(i));
		//������γ�ȡҳ����Ϣ
		List<String> htmls=page.getHtml().xpath("//div[@class='lemma-summary']/html()").all();
		for(String html:htmls) {
		String mean=selectDocumentText(html);
		String word=words.get(i);
		System.out.println(word+":"+mean);
		mean mean1=new mean();
		mean1.setMeann(mean);
		mean1.setWord(word);
		mean2.add(mean1);
		}
		
		i=i+1;
		
	}
	public static void main(String[] args) {
	long startTime,endTime;
	startTime=new Date().getTime();
	Spider create=Spider.create(new MingciPangProcessor());
	 words.add("��Ϣ");
	 String strr="https://baike.baidu.com/item/��Ϣ";
     create.addUrl(strr).thread(5).run();
	 endTime=new Date().getTime();
	 File.WriteStringToFile2(mean2);
	 System.out.println("��ʱΪ��"+(endTime-startTime)/1000+"s");

   }
}

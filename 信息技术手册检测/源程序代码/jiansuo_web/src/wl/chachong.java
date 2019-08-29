package wl;
import java.util.ArrayList;

import java.util.Date;
import java.util.List;

import org.assertj.core.util.Collections;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

public class chachong implements PageProcessor {
	static String chaxun = null;
	static String url = null;

	public static List<String> main1(String explain,String keywords) {
		    List<String> chaoxi=new ArrayList<String>();
			String[] kk =keywords.split("  ");
			List<String> ks=new ArrayList<String>();
			for (int i=0; i<kk.length; i++) {
		        if (!kk[i].equals("")) {
		            ks.add(kk[i]);
		        }
		    }
			for (String k:ks) {//将百度百科爬取到的意思和原文解释进行对比
				shuru(k);
				if(chaxun==null) {
					continue;
				}
				List<String> chongfus = duibi(explain, chaxun);
				int count = 0;// 抄袭的总字数
				if (chongfus != null) {// 有重复的字符
					for (String chongfu : chongfus) {
						if (chongfu.length() > 7) {// 知网规定重复超过7个算是抄袭
							chaoxi.add(chongfu);
							count = count + chongfu.length();
						}
					}
				}
				if (count > 0) {
					System.out.println("抄袭句子");
					for (String cx : chaoxi) {
						System.out.println(cx);
					}
				}
				
			}
		return chaoxi;
	}

	public static List<String> duibi(String explain, String chaxun) {

		List<String> chongfus = new ArrayList<String>();
		String chongfu = "";
		boolean lianxu = false;
		for (int i = 0; i < explain.length(); i++) {
			for (int j = 0; j < chaxun.length(); j++) {
				if (i >= explain.length() || j >= chaxun.length()) {
					break;
				}
				if (explain.charAt(i) == chaxun.charAt(j)) {//如果有重复的字符
					if ((lianxu == false) && (!chongfu.equals(""))) {// 上一句重复的话
						chongfus.add(chongfu);
						chongfu = "";
					}
					chongfu = chongfu + explain.charAt(i);
					lianxu = true;

					i++;
				} else {
					lianxu = false;
				}

			}
		}
		chongfus.add(chongfu);
		return chongfus;

	}

	@Override
	public Site getSite() {
		return Site.me().setSleepTime(1000).setRetryTimes(10);
	}

	private static String selectDocumentText(String htmlText) {
		Document doc = Jsoup.parse(htmlText);
		String select = doc.text();
		return select;
	}

	@Override
	public void process(Page page) {

		// 定义如何抽取页面信息
		List<String> htmls = page.getHtml().xpath("//div[@class='lemma-summary']/html()").all();
		for (String html : htmls) {
			chaxun = selectDocumentText(html);
		}

	}

	public static void shuru(String word) {
		long startTime, endTime;
		startTime = new Date().getTime();
		Spider create = Spider.create(new chachong());
		String strr = "https://baike.baidu.com/item/" + word;
		url = strr;
		create.addUrl(strr).thread(1).run();
		endTime = new Date().getTime();
		System.out.println("用时为：" + (endTime - startTime) / 1000 + "s");
	}

}

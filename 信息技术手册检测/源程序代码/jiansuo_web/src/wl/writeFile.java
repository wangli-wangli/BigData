package wl;

import java.awt.Color;
import java.io.FileOutputStream;
import java.text.DecimalFormat;
import java.util.List;

import com.lowagie.text.Chapter;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

public class writeFile {
	private static int normal = Font.NORMAL; // 正常字体
	private static Color black = new Color(0, 0, 0); // 黑色
	private static Color red = new Color(255, 0, 0); // 红色
	private int bold = Font.BOLD; // 粗体
	private Color blue = new Color(0, 0, 255); // 蓝色
	private float setting = 20; // 首行缩进参数
	 static int count=0;//用红色标注的字体个数
	 static int cop_count=0;//用红色标注的片段个数
	 static int sum=0;//总字数

	public static void downloads() throws Exception {
		writeFile pdfDemo = new writeFile();
		pdfDemo.writePdf("C:\\Users\\lenovo\\Desktop\\信息技术手册检测报告.pdf");
		System.out.println("写入完成！");
	}

	public static Document createDoc(String filename) throws Exception {

		Document document = new Document(PageSize.A4, 50, 50, 50, 50);
		PdfWriter.getInstance(document, new FileOutputStream(filename));
		return document;
	}

	public void writePdf(String filename) throws Exception {
		Document document = createDoc(filename); // 打开文档
		document.open(); // 文档里写入
		Chunk chunk1 = new Chunk(convertChunkToChinese("信息技术手册检测报告", 20, bold, black));
		document.add(chunk1);
		document.add(new Paragraph("\n"));
		Paragraph pp = new Paragraph(convertParToChinese("检测范围：◎百度词条", 9, normal, black));
		document.add(pp);
		Paragraph pp1 = new Paragraph(convertParToChinese("颜色标注说", 9, normal, black));
		document.add(pp1);
		Paragraph pp2 = new Paragraph();
		pp2.add(new Phrase(convertParToChinese("口", 9, normal, red)));
		pp2.add(new Phrase(convertParToChinese("：复写片段(相似或疑似重)", 9, normal, black)));
		document.add(pp2);
		List<citiao> cs = DBUtil.load_all();
		for (citiao c : cs) {
			Paragraph chapterTitle = new Paragraph("\n\n");
			Paragraph p0 = new Paragraph(convertParToChinese(c.getId() + "." + c.getName(), 14, bold, black));
			chapterTitle.add(p0);
			Paragraph p3 = new Paragraph(convertParToChinese("类别：" + c.getClasss(), 9, normal, blue));
			chapterTitle.add(p3);
			Paragraph p = new Paragraph(convertParToChinese("摘要：" + c.getAbstracts(), 9, normal, blue));
			chapterTitle.add(p);
			Paragraph p1 = new Paragraph(convertParToChinese("关键词：" + c.getKeywords(), 9, normal, blue));
			chapterTitle.add(p1);
			Paragraph p2 = returnExpain(c.getId(), c.getExplain());// 解释
			chapterTitle.add(p2);
			document.add(chapterTitle);
		}
		document.add(new Paragraph("\n\n"));
		document.add(new Paragraph(convertParToChinese("检测结论：",22, normal, black)));
		Paragraph a1=new Paragraph();
		a1.add(new Phrase(convertParToChinese("全文相似度：", 9, normal, black)));
		sum();
		DecimalFormat decimalFormat=new DecimalFormat(".00");//构造方法的字符格式这里如果小数不足2位,会以0补足.
		String p=decimalFormat.format((float)100*count/sum);
		System.out.println(p);
		a1.add(new Phrase(convertParToChinese(p+"%", 9, normal, red)));
		document.add(a1);
		document.add(new Paragraph(convertParToChinese("总相似片段：" +cop_count, 9, normal, black)));
		document.close();
	}

	public static Paragraph returnExpain(int yuan_id, String explain) throws Exception {
		List<copy> copys = DBUtil.load_id(yuan_id);
		Paragraph a = new Paragraph();
		String word = "";
		int j = 0;

		if (copys.size() != 0) {
			copy c = copys.get(j);
			j++;
			for (int i = 0; i < explain.length(); i++) {
				if (i < c.getStart_position()) {
					word = word + explain.charAt(i);
				} else if (i == c.getStart_position()) {
					if (word != "") {// 抄袭语句前面的语句
						a.add(new Phrase(convertParToChinese2(word, 12, normal, black)));
						word = "";
					}	
					word = word + explain.charAt(i);
				} else if (i == c.getLast_position()) {
					word = word + explain.charAt(i);
					if (word != "") {// 抄袭语句前面的语句
						cop_count++;
						count=count+word.length();
						a.add(new Phrase(convertParToChinese2(word, 12, normal, red)));
						word = "";
						if (j < copys.size()) {
							c = copys.get(j);
							j++;
						}
					}
				}else if (i == explain.length()-1) {
					word = word + explain.charAt(i);
					a.add(new Phrase(convertParToChinese2(word, 12, normal, black)));
				}else if(i>explain.length()){
					word = word + explain.charAt(i);
				}else if(i>c.getStart_position()&&i<c.getLast_position()) {
					word = word + explain.charAt(i);
				}else if(i>c.getLast_position()) {
					word = word + explain.charAt(i);
				}

			}
		} else {
			a = new Paragraph(convertParToChinese(explain, 12, normal, black));
		}
		return a;

	}
	
	public static void sum() {
		List<citiao> citiaos=DBUtil.load_all();
		for(citiao c:citiaos) {
			sum=sum+c.getExplain().length();
		}
		
	}
	
	public static Paragraph convertParToChinese(String text, int fontsize, int fontStyle, Color color)
			throws Exception {
		BaseFont baseFontChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
		Font fontChinese = new Font(baseFontChinese, fontsize, fontStyle, color);
		Paragraph graph = new Paragraph(text, fontChinese);
		return graph;
	}

	public static Phrase convertParToChinese2(String text, int fontsize, int fontStyle, Color color) throws Exception {
		BaseFont baseFontChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
		Font fontChinese = new Font(baseFontChinese, fontsize, fontStyle, color);
		Phrase graph = new Phrase(text, fontChinese);
		return graph;
	}

	public static Chunk convertChunkToChinese(String text, int fontsize, int fontStyle, Color color) throws Exception {
		BaseFont baseFontChinese = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);
		Font fontChinese = new Font(baseFontChinese, fontsize, fontStyle, color);
		Chunk graph = new Chunk(text, fontChinese);
		return graph;
	}
}

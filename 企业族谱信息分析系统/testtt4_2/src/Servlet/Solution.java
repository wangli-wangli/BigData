package Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.jcraft.jsch.Session;

import Bean.Company;
import Bean.Gud;
import Utils.UserDao;

/**
 * Servlet implementation class Solution
 */
@WebServlet("/Solution")
public class Solution extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Solution() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String method = request.getParameter("action");
		if(method.equals("search")) {
			String cname = request.getParameter("content");
			if(cname!=null) {
			List<Company> list =UserDao.getCompany(cname);
			request.setAttribute("infolist",list);
			request.getRequestDispatcher("Search2.jsp").forward(request,response);
			}
			else {
				request.setAttribute("infolist",null);
				request.getRequestDispatcher("Search2.jsp").forward(request,response);
			}
		}else if(method.equals("gud")) {
			String cname = request.getParameter("content");
	
			List<Gud> list = UserDao.getGudList(cname);
			String m = "疑似实际控制人:";
			String str = "";
			double ma = 0;
			for(Gud temp:list) {
				if(temp.getGmoney()>ma) {
					ma = temp.getGmoney();
					str = temp.getGname()+"-----"+temp.getGpercent()+"------>"+cname;
				}
			}
			if(str==null) {
				str="无";
			}
			m+=str;
			System.out.println("cname:"+cname);
			request.setAttribute("list",list);
			request.setAttribute("m",m);
			request.setAttribute("cname",cname);
			request.getRequestDispatcher("Gud.jsp").forward(request,response);
		}else if(method.equals("zupu")) {//t3
			String cname = request.getParameter("content");
			
			List<Gud>list1 = UserDao.getGudList(cname);
			List<Company> list2 = UserDao.getBGud(cname);
			
			JSONObject json = new JSONObject();
			
			List<JSONObject>data = new ArrayList<>();
			List<JSONObject>categories = new ArrayList<>();
			List<JSONObject>links = new ArrayList<>();
			
			
			JSONObject o = new JSONObject();
			o.put("name",cname);
			o.put("draggable",true);
			o.put("symbolSize",new int[] {50,50});
			o.put("itemStyle",new JSONObject().put("color","#000"));
			o.put("category","投资");
			
			data.add(o);
			
			JSONObject o1 = new JSONObject();
			o1.put("name","股东");
			o1.put("draggable",true);
			o1.put("symbolSize",new int[] {50,50});
			o1.put("itemStyle",new JSONObject().put("color","#000"));
			o1.put("category","投资");
			
			data.add(o1);
			
			JSONObject o2 = new JSONObject();
			o2.put("name","再投");
			o2.put("draggable",true);
			o2.put("symbolSize",new int[] {50,50});
			o2.put("itemStyle",new JSONObject().put("color","#000"));
			o2.put("category","投资");
			
			data.add(o2);
			
			JSONObject jb3 = new JSONObject();
			jb3.put("name","投资");
			
			JSONObject jb4 = new JSONObject();
			jb4.put("name","1");
			
			categories.add(jb3);
			categories.add(jb4);
			
			JSONObject oj1 = new JSONObject();
			oj1.put("target",cname);
			oj1.put("source","再投");
			oj1.put("category","投资");
			
			links.add(oj1);
			
			JSONObject oj2 = new JSONObject();
			oj2.put("target",cname);
			oj2.put("source","股东");
			oj2.put("category","投资");
			
			links.add(oj2);
			
			for(Gud temp1:list1) {
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getGname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","1");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target","股东");
				oo2.put("source",temp1.getGname());
				oo2.put("category","1");
				links.add(oo2);
			}
			
			for(Company temp1:list2) {
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getCname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target","再投");
				oo2.put("source",temp1.getCname());
				oo2.put("category","");
				links.add(oo2);
			}
			
			json.put("data",data);
			json.put("links",links);
			json.put("categories", categories);
			
			response.setCharacterEncoding("utf-8");
			
			response.getWriter().write(json.toJSONString());
		}else if(method.equals("qit")) {//t4
			String cname = request.getParameter("content");
			List<Gud>list1 = UserDao.getGudList(cname);
			List<Company>list2 = UserDao.getBGud(cname);
			List<Gud>list3 = UserDao.getY(cname);
			List<Company>list4 = UserDao.getChild(cname);
			
			
			JSONObject json = new JSONObject();
			
			List<JSONObject>data = new ArrayList<>();
			List<JSONObject>categories = new ArrayList<>();
			List<JSONObject>links = new ArrayList<>();
			
			
			JSONObject o = new JSONObject();
			o.put("name",cname);
			o.put("draggable",true);
			o.put("symbolSize",new int[] {50,50});
			o.put("itemStyle",new JSONObject().put("color","#000"));
			o.put("category","1投资");
			
			data.add(o);
			
			
			
			JSONObject o3 = new JSONObject();
			o3.put("name","子公司");
			o3.put("draggable",true);
			o3.put("symbolSize",new int[] {50,50});
			o3.put("itemStyle",new JSONObject().put("color","#000"));
			o3.put("category","从属");
			
			data.add(o3);
			
			JSONObject o4 = new JSONObject();
			o4.put("name","成员");
			o4.put("draggable",true);
			o4.put("symbolSize",new int[] {50,50});
			o4.put("itemStyle",new JSONObject().put("color","#000"));
			o4.put("category","管理");
			
			data.add(o4);
			
			JSONObject o1 = new JSONObject();
			o1.put("name","股东");
			o1.put("draggable",true);
			o1.put("symbolSize",new int[] {50,50});
			o1.put("itemStyle",new JSONObject().put("color","#000"));
			o1.put("category","1投资");
			
			data.add(o1);
			
			JSONObject o2 = new JSONObject();
			o2.put("name","再投");
			o2.put("draggable",true);
			o2.put("symbolSize",new int[] {50,50});
			o2.put("itemStyle",new JSONObject().put("color","#000"));
			o2.put("category","1投资");
			
			data.add(o2);
			
			
			JSONObject jb3 = new JSONObject();
			jb3.put("name","1投资");
			
			categories.add(jb3);
			
			JSONObject jb4 = new JSONObject();
			jb4.put("name","从属");
			
			categories.add(jb4);
			
			
			JSONObject jb5 = new JSONObject();
			jb5.put("name","管理");
			
			categories.add(jb5);
			
			JSONObject oj1 = new JSONObject();
			oj1.put("target","再投");
			oj1.put("source",cname);
			oj1.put("category","1");
			
			links.add(oj1);
			
			JSONObject oj2 = new JSONObject();
			oj2.put("target","股东");
			oj2.put("source",cname);
			oj2.put("category","1");
			
			links.add(oj2);
			
			JSONObject oj3 = new JSONObject();
			oj3.put("target","子公司");
			oj3.put("source",cname);
			oj3.put("category","2");
			
			links.add(oj3);
			
			JSONObject oj4 = new JSONObject();
			oj4.put("target","成员");
			oj4.put("source",cname);
			oj4.put("category","2");
			
			links.add(oj4);
			
			for(Gud temp1:list1) {
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getGname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getGname());
				oo2.put("source","股东");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Company temp1:list2) {
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getCname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getCname());
				oo2.put("source","再投");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Gud temp1:list3) {
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getGname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getGname());  //
				oo2.put("source","成员");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Company temp1:list4) {
				System.out.println(("t4:"+temp1.getCname()));
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getCname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getCname());//
				oo2.put("source","子公司");
				oo2.put("category","");
				links.add(oo2);
			}
			
			
			json.put("data",data);
			json.put("links",links);
			json.put("categories", categories);
			
			response.setCharacterEncoding("utf-8");
			//System.out.println(json.toJSONString());
			response.getWriter().write(json.toJSONString());
		}else if(method.equals("yin")) {//t5
			String cname = request.getParameter("content");
			List<Gud>list1 = UserDao.getGudList(cname);
			List<Company>list2 = UserDao.getBGud(cname);
			List<Gud>list3 = UserDao.getY(cname);
			List<Company>list4 = UserDao.getChild(cname);
			
			JSONObject json = new JSONObject();
			
			List<JSONObject>data = new ArrayList<>();
			List<JSONObject>categories = new ArrayList<>();
			List<JSONObject>links = new ArrayList<>();
			
			
			JSONObject o = new JSONObject();
			o.put("name",cname);
			o.put("draggable",true);
			o.put("symbolSize",new int[] {50,50});
			o.put("itemStyle",new JSONObject().put("color","#000"));
			o.put("category","1投资");
			
			data.add(o);
			
			
			
			JSONObject o3 = new JSONObject();
			o3.put("name","子公司");
			o3.put("draggable",true);
			o3.put("symbolSize",new int[] {50,50});
			o3.put("itemStyle",new JSONObject().put("color","#000"));
			o3.put("category","从属");
			
			data.add(o3);
			
			JSONObject o4 = new JSONObject();
			o4.put("name","成员");
			o4.put("draggable",true);
			o4.put("symbolSize",new int[] {50,50});
			o4.put("itemStyle",new JSONObject().put("color","#000"));
			o4.put("category","管理");
			
			data.add(o4);
			
			JSONObject o1 = new JSONObject();
			o1.put("name","乔华清");
			o1.put("draggable",true);
			o1.put("symbolSize",new int[] {50,50});
			o1.put("itemStyle",new JSONObject().put("color","#000"));
			o1.put("category","1投资");
			
			data.add(o1);
			
			JSONObject o2 = new JSONObject();
			o2.put("name","陈贵");
			o2.put("draggable",true);
			o2.put("symbolSize",new int[] {50,50});
			o2.put("itemStyle",new JSONObject().put("color","#000"));
			o2.put("category","1投资");
			
			data.add(o2);
			
			
			JSONObject jb3 = new JSONObject();
			jb3.put("name","1投资");
			
			categories.add(jb3);
			
			JSONObject jb4 = new JSONObject();
			jb4.put("name","从属");
			
			categories.add(jb4);
			
			
			JSONObject jb5 = new JSONObject();
			jb5.put("name","管理");
			
			categories.add(jb5);
			
			JSONObject oj1 = new JSONObject();
			oj1.put("target","陈贵");
			oj1.put("source",cname);
			oj1.put("category","1");
			
			links.add(oj1);
			
			JSONObject oj2 = new JSONObject();
			oj2.put("target","乔华清");
			oj2.put("source",cname);
			oj2.put("category","1");
			
			links.add(oj2);
			
			JSONObject oj3 = new JSONObject();
			oj3.put("target","子公司");
			oj3.put("source",cname);
			oj3.put("category","2");
			
			links.add(oj3);
			
			JSONObject oj4 = new JSONObject();
			oj4.put("target","成员");
			oj4.put("source",cname);
			oj4.put("category","2");
			
			links.add(oj4);
			
			for(Gud temp1:list1) {
				System.out.println("t5-1:"+temp1.getGname());
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getGname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#00F"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getGname());
				oo2.put("source","乔华清");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Company temp1:list2) {
				System.out.println("t5-2:"+temp1.getCname());
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getCname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#0FF"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getCname()); //
				oo2.put("source","陈贵");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Gud temp1:list3) {
				System.out.println("t5-3:"+temp1.getGname());
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getGname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","#000"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getGname());  //
				oo2.put("source","成员");
				oo2.put("category","");
				links.add(oo2);
			}
			
			for(Company temp1:list4) {
				System.out.println("t5-4:"+temp1.getCname());
				JSONObject oo = new JSONObject();
				oo.put("name",temp1.getCname());
				oo.put("draggable",true);
				oo.put("symbolSize",new int[] {50,50});
				oo.put("itemStyle",new JSONObject().put("color","AA0"));
				oo.put("category","");
				data.add(oo);
				JSONObject oo2 = new JSONObject();
				oo2.put("target",temp1.getCname());//
				oo2.put("source","子公司");
				oo2.put("category","");
				links.add(oo2);
			}
			
			
			json.put("data",data);
			json.put("links",links);
			json.put("categories", categories);
			
			response.setCharacterEncoding("utf-8");
			//System.out.println(json.toJSONString());
			response.getWriter().write(json.toJSONString());
		}
	}

}

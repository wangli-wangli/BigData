package com.Servlet;
import com.alibaba.fastjson.JSONObject;
import com.dao.KeyDao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class wordServlet
 * @WebServlet("/wordServlet")
 */

public class wordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public wordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");//定义content的字符格式
		String content = request.getParameter("content");//定义content
		//System.out.println("获取到的内容:"+content);
		JSONObject json = new JSONObject();//定义一个json
		KeyDao wordDao = new KeyDao();//调用方法
        String explain = wordDao.loadKeyCon(content);//
        json.put("explain",explain);//相当于定义一个json的属性，属性值是爬取出来的explain
        response.setCharacterEncoding("utf-8");//字符串的格式
        response.getWriter().write(json.toJSONString());//往回传

	}

}

<%@ page import="java.util.*"%>
<%@ page import="Bean.Gud"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<frameset rows="800" frameborder="yes" border="0"
	framespacing="1">
	<%
	String cname=(String)request.getAttribute("cname");
	List<Gud> list=(List<Gud>)request.getAttribute("list");
	String m=(String)request.getAttribute("m");
	request.setAttribute("list",list);
	request.setAttribute("m",m);
	request.setAttribute("cname",cname);
	%>
	<frame src="Gud.jsp" />

</html>
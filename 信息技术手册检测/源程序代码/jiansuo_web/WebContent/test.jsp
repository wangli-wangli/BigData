<%@ page import="wl.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String explain="其中，一维码和二维码的区别是：一维条码仅在一个方向上（一般是水平方向）存储信息，其垂直方向的高度常为了便于阅读器读取信息，但二维条码在垂直和水平方向均记载着数据";
String classs=classify.classify(explain);
%>
<%=classs %>
</body>
</html>
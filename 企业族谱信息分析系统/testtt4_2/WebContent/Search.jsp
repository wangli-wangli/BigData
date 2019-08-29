<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Bean.Company"%>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<title>搜索</title>

</head>
<style type="text/css">
 table {
	border-collapse: collapse;
}

table, td, th {
	border: 2px solid #777;
	font-size:25px;
} 
</style>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>

</script>
<body>
<br>
<br>
<br>
<br>
<br>
<br>
<br><br>

	<form action="Solution?action=search" method="post">
		<p align="center">
			<input type="text" name="content" style="width: 50%; height: 70px;" /><input
				type="submit" style="width: 10%; height: 70px;font-size:25px;" value="搜索" />
		</p>
	</form>
	<%
		List<Company> infos = (List) request.getAttribute("infolist");
		if (infos != null) {
			for (Company info : infos) {
	%>
	<br><br>
	<table width="70%" align="center">
		<tr>
			<th>企业名称</th>
			<td colspan="3"><%=info.getCname()%></td>
		</tr>
		<tr>
			<th>电话</th>
			<td><%=info.getCtelno()%></td>
			<th>地址</th>
			<td><%=info.getCaddr()%></td>
		</tr>
		<tr>
			<th width="20%">注册资本</th>
			<td width="30%"><%=info.getCmoney()%></td>
			<th width="20%">法人代表</th>
			<td width="30%"><%=info.getCstand()%></td>
		</tr>
		<tr>
			<th>成立日期</th>
			<td><%=info.getCdate()%></td>
			<th>企业类型</th>
			<td><%=info.getCkind()%></td>
		</tr>
		<tr>
			<th>统一社会信用代码</th>
			<td><%=info.getCsno()%></td>
			<th>登记机关</th>
			<td><%=info.getClogin()%></td>
		</tr>
		<tr>
			<th>经营范围</th>
			<td colspan="3"><%=info.getCfield()%></td>
		</tr>
		<tr>
			<td><a href="Solution?action=gud&content=<%=info.getCname()%>">查看股权结构</a></td>
			<td><a href="t3.jsp?content=<%=info.getCname()%>">查看投资族谱</a></td>
			<td><a href="t4.jsp?content=<%=info.getCname()%>">查看企业族谱</a></td>
			<td><a href="t5.jsp?content=<%=info.getCname()%>">查看更多疑似关系</a></td>
		</tr>
	</table>
	<br>
	<br>
	<br>
	<br>
	<%
		}
	%>
	

	<%
		}
	%>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

</body>
</html>
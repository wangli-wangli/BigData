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
body {
	background-color: #ecf5f8;
}

table {
	align: center;
	border-collapse: collapse;
	width: 100%;
}

table, td, th {
	border: 5px solid #EEE;
	font-size: 20px;
}

.kuang {
	margin-left: 120px;
	width: 80%;
	border-color: #BCF;
	border-style: solid;
	border-width: 10px;
	background-color: white;
}

#searchTxt {
	border-style: solid; /*  此步是必须的  */
	border-color: #33f;
	width: 50%;
	height: 70px;
	border-width: 3px;
	font-size: 25px;
}

input:focus {
	outline: none;
} /*  focus 标记*/


</style>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>

<body>
	<!-- logo -->
	<img src="logo.png" style="margin-top: 0; margin-left: 0"
		width="450px;">
	<!-- 登录 -->
	<script type="text/javascript" src="login.js"></script>
	<link type="text/css" rel="stylesheet" href="login.css" />
	<div style="background-color: #ABF;">
	<a class="nav-login"  link="blue" id="chao" href="javascript:;" style="margin-left:1300px;font-size:20px;color:blue">登录</a>
	
	</div>
	<div class="login-form">
		<div class="login-header">
			<a href="javascript:;" title="关闭" class="login-close close">×</a>
			<h3 align="center" style="font-size:30px;color:#33f">用户登录</h3>
		</div>
		<div>
			<h2><div style="background-color: #33f"></div></h2>
					<p align="center" style="font-size:25px;"><label>用户名：</label><input type="text" style="width:170px;height:30px;font-size:25px;" id="uname"
						name="uname" autocomplete="off" spellcheck="false"></p>
				
					<p align="center" style="font-size:25px;"><label>密码：</label><input type="password" style="width:170px;height:30px;font-size:25px;"  id="upwd"
						name="upwd" autocomplete="off" spellcheck="false"></p>
				
					<p align="center"><button onclick="Login()" style="width:120px; height: 40px; font-size: 25px; background-color: #33f; color: white">登录</button></p>
				
		</div>
	</div>
	
	<div class="login-form-mask"></div>

	<!-- 登录完- -->
	<br>
	<br>
	<br>
	<form action="Solution?action=search" method="post">
		<p align="center">
			<input type="text" name="content" id="searchTxt" /><input
				type="submit"
				style="width: 10%; height: 70px; font-size: 25px; background-color: #33f; color: white"
				value="搜索" />
		</p>
	</form>
	<%
		List<Company> infos = (List) request.getAttribute("infolist");
		if (infos != null) {
			for (Company info : infos) {
	%>
	<br>
	<br>
	<div class="kuang">
		<table>
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
	</div>
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
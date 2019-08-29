<!-- basicForm_input.jsp -->
<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.FindIterable"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="org.bson.types.ObjectId"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息</title>
<!-- 选择所在市县的下拉框 -->
<script src="jquery-3.2.1.js" type="text/javascript"></script>
<script type="text/javascript" src="city.js"></script>
<!-- 服务的主要国民经济行业 -->
<script type="text/javascript" src="service_occupation.js"></script>
<script src="jquery-1.10.2.min.js"></script>
<!-- 共建单位 -->
<script src="jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="user_unit.js"></script>
<!-- 检查输入框不能为空 -->
<script type="text/javascript" src="basicForm.js"></script>
</head>
<body>
	<h2>基本信息</h2>
<%
String id=request.getParameter("id");
ServerAddress serverAddress = new ServerAddress("localhost", 27017);
ArrayList<ServerAddress> addrs = new ArrayList<ServerAddress>();
addrs.add(serverAddress);

 MongoCredential credential =MongoCredential.createCredential("root", "admin",
			"wangli".toCharArray()); 
ArrayList<MongoCredential> credentials = new ArrayList<MongoCredential>();
credentials.add(credential);

MongoClient mongoClient = new MongoClient(addrs, credentials);

MongoDatabase mongoDatabase = mongoClient.getDatabase("test");
System.out.println("Connect to database successfully");
 MongoCollection<org.bson.Document> collection=mongoDatabase.getCollection("platform");
 System.out.println("Collect mycol selection is successful");
 FindIterable<Document> findIterable;
findIterable=collection.find(new Document("_id", new ObjectId(id)));
 MongoCursor<Document> mongoCursor=findIterable.iterator();
 while(mongoCursor.hasNext()) {
	 Document aa=mongoCursor.next();
%>

	<form action="basicForm.jsp" method="post" onsubmit="return check()">

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="20%">平台名称</td>
				<td bgcolor="white" width="30%"><%=aa.getString("平台名称") %></td>
				<td bgcolor="white" width="20%">平台编号</td>
				<td bgcolor="white" width="30%"><%= aa.getString("平台编号")%></td>
			</tr>
			<tr>
				<td bgcolor="white">批准年月</td>
				<td bgcolor="white"><%=aa.getString("批准年月") %></td>
				<td bgcolor="white">批准文号</td>
				<td bgcolor="white"><%=aa.getString("批准文号") %></td>
			</tr>
			<tr>
				<td bgcolor="white">技术领域</td>
				<td bgcolor="white" colspan="3"><%=aa.getString("技术领域") %></td>
			</tr>
			<tr>
				
				<td bgcolor="white">平台级别</td>
				<td bgcolor="white"><%=aa.getString("国家级别") %></td>
				<td bgcolor="white">所在市县</td>
				<td bgcolor="white"><%=aa.getString("所在市县") %></td>
			</tr>
		</table>
		<%
		String platform_Textuser = aa.getString("平台形态");
		int first = platform_Textuser.indexOf("&");
		int second = platform_Textuser.indexOf('&', first + 1);
		int third = platform_Textuser.indexOf('&', second + 1);
		String Textuser1 = platform_Textuser.substring(0, first);
		String Textuser2 = platform_Textuser.substring(first + 1, second);
		String Textuser3 = platform_Textuser.substring(second + 1, third);
		String Textuser4 = platform_Textuser.substring(third + 1, platform_Textuser.length());
		if (Textuser1.equals("null")) {
			Textuser1 = "";
		}
		if (Textuser3.equals("是")) {
			Textuser3 = "京津冀共建";
		} else {
			Textuser3 = "";
		}
		
		%>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="15%" rowspan="2">平台组织形态</td>
				<td bgcolor="white" rowspan="2" width="20%"><%=Textuser1 %></td>
				<td bgcolor="white" rowspan="2" width="25%"><%=Textuser2 %>
				</td>
				<td bgcolor="white" colspan="2"><%=Textuser4 %>
				</td>
			</tr>
			<tr>
				<td bgcolor="white" width="20%" height="50%">京津冀共建</td>
				<td bgcolor="white" width="20%" height="50%"><%=Textuser3 %></td>
			</tr>
		</table>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="20%">服务的主要国民经济行业</td>
				<td bgcolor="white" colspan="3">
				<%=aa.getString("经济行业1")%><%=aa.getString("经济行业2")%><%=aa.getString("经济行业3")%>
			</tr>
			<!-- 所属学科 -->
             <script type="text/javascript" src="platform_subject.js"></script> 
			<tr>
				<td bgcolor="white">所属的主要学科</td>
				<td bgcolor="white" colspan="3"><%=aa.getString("主要学科1")%></td>
			</tr>
			<tr>
				<td bgcolor="white" width="20%">依托单位名称</td>
				<td bgcolor="white" width="30%"><%=aa.getString("依托单位")%></td>
				<td bgcolor="white" width="20%">依托单位组织机构代码(社会信用代码)</td>
				<td bgcolor="white" width="30%"><%=aa.getString("依托单位组织机构代码") %></td>
			</tr>
			<tr>
				<td bgcolor="white">依托单位法人代表姓名</td>
				<td bgcolor="white"><%=aa.getString("依托单位组织机构代码") %></td>
				<td bgcolor="white">办公电话</td>
				<td bgcolor="white"><%=aa.getString("办公电话") %></td>
			</tr>
			<tr>
				<td bgcolor="white">依托单位类型</td>
				<td bgcolor="white" colspan="3"><%=aa.getString("依托单位类型") %></td>
			</tr>
			<tr>
				<td bgcolor="white">共建单位</td>
				<td bgcolor="white" colspan="3">
				<%=aa.getString("共建单位") %>
				</td>
			</tr>
		</table>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<col style="width: 4%" />
			<tr>
				<td bgcolor="white" rowspan="3" width="12%">平台主任(院长)</td>
				<td bgcolor="white">姓名</td>
				<td bgcolor="white"><%=aa.getString("主任姓名") %></td>
				<td bgcolor="white">性别</td>
				<td bgcolor="white"><%=aa.getString("主任性别") %></td>
				<td bgcolor="white">出生年月</td>
				<td bgcolor="white"><%=aa.getString("主任出生年月") %>
				</td>
				<td bgcolor="white">职称</td>
				<td bgcolor="white"><%=aa.getString("主任职称") %></td>
			</tr>
			<tr>
				<td bgcolor="white">所学专业</td>
				<td bgcolor="white" colspan="2"><%=aa.getString("主任所学专业") %></td>
				<td bgcolor="white">学历</td>
				<td bgcolor="white" colspan="2"><%=aa.getString("主任学历") %></td>
				<td bgcolor="white">学位</td>
				<td bgcolor="white"><%=aa.getString("主任学位") %></td>

			</tr>
			<tr>
				<td bgcolor="white">办公电话</td>
				<td bgcolor="white" colspan="2"><%=aa.getString("主任办公电话")  %></td>
				<td bgcolor="white">手机</td>
				<td bgcolor="white" colspan="2"><%=aa.getString("主任手机")  %></td>
				<td bgcolor="white">E-mail</td>
				<td bgcolor="white"><%=aa.getString("主任E-mail")  %></td>

			</tr>
			<tr>
				<td bgcolor="white">平台网站名称</td>
				<td bgcolor="white" colspan="4"><%=aa.getString("平台网站名称")  %></td>
				<td bgcolor="white">网址</td>
				<td bgcolor="white" colspan="3"><%=aa.getString("网址")  %></td>

			</tr>
			<tr>
				<td bgcolor="white">平台通讯地址</td>
				<td bgcolor="white" colspan="4"><%=aa.getString("平台通讯地址")  %></td>
				<td bgcolor="white">邮编</td>
				<td bgcolor="white" colspan="3"><%=aa.getString("邮编")  %></td>

			</tr>

		</table>
	</form>
	
<%} %>
</body>
</html>
<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.FindIterable"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
table {
	border-collapse: collapse;
}

table, td, th {
	border: 2px solid blue;
	align: center;
}

.nav ul li {
	float: left;
	list-style: none;
	display: inline-block;
	padding: 0px 57px;
	   
}
/* a{text-decoration:none;} */
a:link {
	color: orange;
}

a:visited {
	color: #F70;
}

a:hover {
	color: blue;
}

a:active {
	color: red;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息</title>
</head>

<body>
	<p>
	<div
		style="color: blue; font-size: 60px; text-align: center; font-family: 华文行楷">基本信息</div>
	</p>

	<%
	String[] platform_levels = request.getParameterValues("platform_level");
	String platform_level="";
	if(platform_levels!=null){
		for(int i=0;i<platform_levels.length;i++)
		{
			platform_level=platform_level+"&"+platform_levels[i];
		}
	}
	
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
	 if (platform_level == ""|| "".equals(platform_level)) {
		 findIterable=collection.find();
		}
	 else{
		
		 findIterable=collection.find(new Document("国家级别",platform_level));
	 }
	
	 MongoCursor<Document> mongoCursor=findIterable.iterator();
	
		String[] color = { "#FFF", "#FFF", "#FFF", "#FFF", "#FFF" };
		
	%>

	
		<table>
			<tr>
				<form action="requireForm.jsp" method="post">
					<td bgcolor="white" colspan="4">选择<span style="color: blue">平台级别</span>
					</td>
					<td colspan="9" bgcolor="white"><input type="checkbox"
					name="platform_level" value="国家级" id="platform_level"
					 />国家级 <input
					type="checkbox" name="platform_level" value="省级" id="platform_level"
					 />省级</td>
					<td bgcolor="white"><input type="submit" value="查询"></td>
				</form>
			</tr>
			<tr>
				<form action="shanchu.jsp" method="post">
					<td bgcolor="white" colspan="4">依托单位类型</td>
					<td bgcolor="white" colspan="9"> 
					<input type="radio"
					name="support_type" value="企业" id="support_type" checked/>企业 <input
					type="radio" name="support_type" value="科研机构" id="support_type" />科研机构
					<input type="radio" name="support_type" value="高等院校"
					id="support_type" />高等院校 <input type="radio" name="support_type"
					value="检测机构" id="support_type" />检测机构 <input type="radio"
					name="support_type" value="医疗机构" id="support_type" />医疗机构 <input
					type="radio" name="support_type" value="政府机构" id="support_type" />政府机构
					<input type="radio" name="support_type" value="社团组织"
					id="support_type" />社团组织 <input type="radio" name="support_type"
					value="其他" id="support_type" />其他
					</td>
					<td bgcolor="white" > <input type="submit" value="删除"></td>
				</form>
			</tr>
			</table>
			<br/>
			<table>
			<tr>
			  <th >序号</th> 
                <th  >详细信息</th> 
				<th >名称</th>
				<th >编号</th>
				<th >级别</th>
				<th  colspan="4">组织形态</th>
				<th colspan="3">所属学科</th>
				<th >所在市县</th>
				<th >技术领域</th>
				<th colspan="3">服务的主要国民经济行业</th>
				<th >网站名称</th>
				<th >网址</th>
				<th >通讯地址</th>
				<th >邮编</th>
				

			<%
			int i=0;
			 while(mongoCursor.hasNext()) {
				 Document aa=mongoCursor.next();
				 String id=aa.get("_id").toString();
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
			<tr>
                <td ><%=i+1%></td>
                <td ><a href="findBasicForm.jsp?id=<%=id%>">查看</a>
                <a href="findBasicForm.jsp?id=<%=id%>">修改</a>
                <a href="findBasicForm.jsp?id=<%=id%>">删除</a></td>
				<td ><%=aa.getString("平台名称")%></td>
				<td ><%=aa.getString("平台编号")%></td>
				<td ><%=aa.getString("国家级别")%></td>
				<td ><%=Textuser1 %></td>
				<td ><%=Textuser2%></td>
				<td ><%=Textuser3%></td>
				<td ><%=Textuser4%></td>
				<td ><%=aa.getString("主要学科1")%></td>
				<td ><%=aa.getString("主要学科2")%></td>
				<td ><%=aa.getString("主要学科3")%></td>
				<td ><%=aa.getString("所在市县")%></td>
				<td ><%=aa.getString("技术领域")%></td>
				<td ><%=aa.getString("经济行业1")%></td>
				<td ><%=aa.getString("经济行业2")%></td>
				<td ><%=aa.getString("经济行业3")%></td>
			
				<td ><%=aa.getString("平台网站名称")%></td>
			
				<td ><%=aa.getString("网址")%></td>
				<td ><%=aa.getString("平台通讯地址")%></td>
				<td ><%=aa.getString("邮编")%></td>
				
			</tr>
			<%
				}
			%>

		</table>
	
</body>

</html>
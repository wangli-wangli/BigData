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
	<h2>基本信息</h2>
	<form action="basicForm.jsp" method="post" onsubmit="return check()">

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="20%">平台名称</td>
				<td bgcolor="white" width="30%"><input type="text" size="50"
					name="platform_name" id="platform_name" value=""
					 /></td>
				<td bgcolor="white" width="20%">平台编号</td>
				<td bgcolor="white" width="30%"><input type="text" size="50"
					name="platform_number" value="" id="platform_number"
					 /></td>
			</tr>
			<tr>
				<td bgcolor="white">批准年月</td>
				<td bgcolor="white"><input type="text" size="50" value=""
					name="authorize_date" value=""
					id="authorize_date"  /></td>
				<td bgcolor="white">批准文号</td>
				<td bgcolor="white"><input type="text" size="50"
					name="authorize_number" value=""
					id="authorize_number" ></td>
			</tr>
			<tr>
				<td bgcolor="white">技术领域</td>
				<td bgcolor="white" colspan="3"><input type="text" size="115"
					name="technology_field" value=""
					id="technology_field" /></td>
			</tr>
			<tr>
				
				<td bgcolor="white">平台级别</td>
				<td bgcolor="white"><input type="checkbox"
					name="platform_level" value="国家级" id="platform_level"
					 />国家级 <input
					type="checkbox" name="platform_level" value="省级" id="platform_level"
					 />省级</td>
				<td bgcolor="white">所在市县</td>
				<td bgcolor="white"><select id="shi" name="shi">
						<option ></option>
						
				</select> 市<select  id="xian" name="xian">
						<option ></option>
				</select>县</td>
			</tr>
		</table>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="15%" rowspan="2">平台组织形态</td>
				<td bgcolor="white" rowspan="2" width="20%"><input
					type="checkbox" name="platform_Texture_1" value="内设机构相对独立(无法人资格)"
					id="platform_Texture_1" />内设机构相对独立(无法人资格)
				<td bgcolor="white" rowspan="2" width="25%"><input
					type="radio" name="platform_Texture_2" value="独立法人"
					id="platform_Texture_2" checked/>独立法人 <input type="radio"
					name="platform_Texture_2" value="企业法人" id="platform_Texture_2" />企业法人
					<br /> <input type="radio" name="platform_Texture_2" value="事业法人"
					id="platform_Texture_2" />事业法人 <input type="radio"
					name="platform_Texture_2" value="社团法人" id="platform_Texture_2" />社团法人
				</td>
				<td bgcolor="white" colspan="2"><input type="radio"
					name="platform_Texture_4" value="多单位联合共建" id="platform_Texture_4" checked/>多单位联合共建 <input
					type="radio" name="platform_Texture_4" value="依托单位独自建设" id="platform_Texture_4" />依托单位独自建设
				</td>
			</tr>
			<tr>
				<td bgcolor="white" width="20%" height="50%">京津冀共建</td>
				<td bgcolor="white" width="20%" height="50%"><input
					type="radio" name="platform_Texture_3" value="是"
					id="platform_Texture_3" checked/>是 <input type="radio"
					name="platform_Texture_3" value="否" id="platform_Texture_3" />否</td>
			</tr>
		</table>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<tr>
				<td bgcolor="white" width="20%">服务的主要国民经济行业</td>
				<td bgcolor="white" colspan="3"><select id="selBig" name="selBig">
						<option></option>
				</select> 行业<select id="selMiddle" name="selMiddle">
						<option></option>
				</select>行业 <select id="selSmall" name="selSmall">
						<option></option>
				</select>行业</td>
			</tr>
			<!-- 所属学科 -->
             <script type="text/javascript" src="platform_subject.js"></script> 
			<tr>
				<td bgcolor="white">所属的主要学科</td>
				<td bgcolor="white" colspan="3"><select id="Big_subject" name="Big_subject">
						<option></option>
				</select>学科 <select id="Middle_subject"  name="Middle_subject">
						<option></option>
				</select>学科 <select id="Small_subject" name="Small_subject">
						<option></option>
				</select>学科</td>
			</tr>
			<tr>
				<td bgcolor="white" width="20%">依托单位名称</td>
				<td bgcolor="white" width="30%"><input type="text" size="50"
					name="support_name" value="" id="support_name" /></td>
				<td bgcolor="white" width="20%">依托单位组织机构代码(社会信用代码)</td>
				<td bgcolor="white" width="30%"><input type="text" size="50"
					name="support_number" value="" id="support_number" /></td>
			</tr>
			<tr>
				<td bgcolor="white">依托单位法人代表姓名</td>
				<td bgcolor="white"><input type="text" size="50"
					name="legalperson_name" value="" id="legalperson_name" /></td>
				<td bgcolor="white">办公电话</td>
				<td bgcolor="white"><input type="text" size="50"
					name="support_phone" value="" id="support_phone" /></td>
			</tr>
			<tr>
				<td bgcolor="white">依托单位类型</td>
				<td bgcolor="white" colspan="3"><input type="radio"
					name="support_type" value="企业" id="support_type" checked/>企业 <input
					type="radio" name="support_type" value="科研机构" id="support_type" />科研机构
					<input type="radio" name="support_type" value="高等院校"
					id="support_type" />高等院校 <input type="radio" name="support_type"
					value="检测机构" id="support_type" />检测机构 <input type="radio"
					name="support_type" value="医疗机构" id="support_type" />医疗机构 <input
					type="radio" name="support_type" value="政府机构" id="support_type" />政府机构
					<input type="radio" name="support_type" value="社团组织"
					id="support_type" />社团组织 <input type="radio" name="support_type"
					value="其他" id="support_type" />其他</td>
			</tr>
			<tr>
				<td bgcolor="white">共建单位</td>
				<td bgcolor="white" colspan="3"><ol>
						<li><input type="text" value="" name="user_unit"
							id="user_unit" size="70" /></li>
					</ol></td>
			</tr>
		</table>

		<table align="center" border="1px" background="image/123.jpg"
			width="75%">
			<col style="width: 4%" />
			<tr>
				<td bgcolor="white" rowspan="3" width="12%">平台主任(院长)</td>
				<td bgcolor="white">姓名</td>
				<td bgcolor="white"><input type="text" colspan="3"
					name="director_name" id="director_name" /></td>
				<td bgcolor="white">性别</td>
				<td bgcolor="white"><input type="radio" name="director_sex"
					value="男" id="director_sex" checked />男 <input type="radio"
					name="director_sex" value="女" id="director_sex" />女</td>
				<td bgcolor="white">出生年月</td>
				<td bgcolor="white"><input type="date" size="20"  name="director_birthday" id="director_birthday"/>
				</td>
				<td bgcolor="white">职称</td>
				<td bgcolor="white"><input type="text" name="job_title"
					value="" id="job_title" /></td>
			</tr>
			<tr>
				<td bgcolor="white">所学专业</td>
				<td bgcolor="white" colspan="2"><input type="text"
					name="director_professional" value="" id="director_professional" /></td>
				<td bgcolor="white">学历</td>
				<td bgcolor="white" colspan="2"><input type="text"
					name="education_background" value="" id="education_background" /></td>
				<td bgcolor="white">学位</td>
				<td bgcolor="white"><input type="text" name="degree" value=""
					id="degree" /></td>

			</tr>
			<tr>
				<td bgcolor="white">办公电话</td>
				<td bgcolor="white" colspan="2"><input type="text"
					name="office_phone" value="" id="office_phone" /></td>
				<td bgcolor="white">手机</td>
				<td bgcolor="white" colspan="2"><input type="text"
					name="director_phone" value="" id="director_phone" /></td>
				<td bgcolor="white">E-mail</td>
				<td bgcolor="white"><input type="text" name="director_Email"
					value="" id="director_Email" /></td>

			</tr>
			<tr>
				<td bgcolor="white">平台网站名称</td>
				<td bgcolor="white" colspan="4"><input type="text"
					name="platform_webname" value="" id="platform_webname" /></td>
				<td bgcolor="white">网址</td>
				<td bgcolor="white" colspan="3"><input type="text"
					name="platform_weburl" value="" id="platform_weburl" /></td>

			</tr>
			<tr>
				<td bgcolor="white">平台通讯地址</td>
				<td bgcolor="white" colspan="4"><input type="text"
					name="contactAddress"  id="contactAddress" /></td>
				<td bgcolor="white">邮编</td>
				<td bgcolor="white" colspan="3"><input type="text"
					name="platform_postcode" value="" id="platform_postcode" /></td>

			</tr>
    <%} %>
		</table>
		<div style="padding-left:500px;"><input type="reset" name="Reset"
			style="color: white; background: #FF8800; width: 79px; height: 35px;"
			value="重填" /> <input type="submit" name="Submit"
			style="color: white; background: #00FF00; width: 79px; height: 35px;"
			value="提交" /></div>
	</form>
	

</body>
</html>
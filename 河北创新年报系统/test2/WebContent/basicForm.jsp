<!-- basicForm.jsp -->
<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本信息</title>
</head>
<body>
	<%
		
	
			//获得当前时间作为platform_id
			Date now=new Date();
			SimpleDateFormat dateFormat=new SimpleDateFormat("yyyyMMddHHmmss");
			String platform_id=dateFormat.format(now);
			
		String[] platform_levels = request.getParameterValues("platform_level");
		String platform_level="";
		for(int i=0;i<platform_levels.length;i++)
		{
			platform_level=platform_level+"&"+platform_levels[i];
		}
		
		String shi = request.getParameter("shi");
		String xian = request.getParameter("xian");
		String platform_address = shi + xian;
		String platform_Texture_1 = request.getParameter("platform_Texture_1");
		String platform_texture_2 = request.getParameter("platform_Texture_2");
		String platform_texture_4 = request.getParameter("platform_Texture_4");
		String platform_texture_3 = request.getParameter("platform_Texture_3");
		String platform_texture = platform_Texture_1 +"&"+platform_texture_2 +"&"+platform_texture_3+"&"+ platform_texture_4;
		String selBig = request.getParameter("selBig");
		String selMiddle = request.getParameter("selMiddle");
		String selSmall = request.getParameter("selSmall");
		String Big_subject = request.getParameter("Big_subject");
		String Middle_subject = request.getParameter("Middle_subject");
		String Small_subject = request.getParameter("Small_subject");
		String support_name = request.getParameter("support_name");
		String support_number = request.getParameter("support_number");
		String legalperson_name = request.getParameter("legalperson_name");
		String support_phone = request.getParameter("support_phone");
		String support_type = request.getParameter("support_type");
		String user_units = request.getParameter("user_unit");
		String platform_name=request.getParameter("platform_name");
		String platform_number=request.getParameter("platform_number");
		String authorize_number=request.getParameter("authorize_number");
		String  authorize_date=request.getParameter("authorize_date");
		String technology_field=request.getParameter("technology_field");
		String director_name = request.getParameter("director_name");
		String director_sex = request.getParameter("director_sex");
		String director_birthday = request.getParameter("director_birthday");
		String job_title = request.getParameter("job_title");
		String director_professional = request.getParameter("director_professional");
		String education_background = request.getParameter("education_background");
		String degree = request.getParameter("degree");
		String office_phone = request.getParameter("office_phone");
		String director_phone = request.getParameter("director_phone");
		String director_Email = request.getParameter("director_Email");
		String platform_webname = request.getParameter("platform_webname");
		String platform_weburl = request.getParameter("platform_weburl");
		String contactAddress = request.getParameter("contactAddress");
		String platform_postcode = request.getParameter("platform_postcode");
		
		
		
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

		Document document=new Document("平台名称",platform_name).
		append("平台编号",platform_number).append("批准年月",authorize_date)
		.append("批准文号", authorize_number).append("技术领域", technology_field)
		.append("国家级别",platform_level).append("所在市县", platform_address)
		.append("平台形态", platform_texture)
		.append("经济行业1",selBig).append("经济行业2", selMiddle)
		.append("经济行业3", selSmall).append("平台形态", platform_texture)
		.append("主要学科1", Big_subject).append("主要学科2", Middle_subject)
		.append("主要学科3", Small_subject).append("依托单位", support_name)
		.append("依托单位组织机构代码", support_number).append("依托单位法人", legalperson_name)
		.append("办公电话", support_phone).append("依托单位类型", support_type)
		.append("共建单位",user_units).append("主任姓名", director_name)
		.append("主任性别", director_sex).append("主任出生年月", director_birthday)
		.append("主任职称", job_title).append("主任所学专业", director_professional)
		.append("主任学历", education_background).append("主任学位", degree)
		.append("主任办公电话", office_phone).append("主任手机", director_phone)
		.append("主任E-mail", director_Email).append("平台网站名称", platform_webname)
		.append("网址", platform_weburl).append("平台通讯地址", contactAddress)
		.append("邮编", platform_postcode);
		
		
		List<Document> documents=new ArrayList<Document>();
		documents.add(document);
		collection.insertMany(documents);
		System.out.println("Document insert successfully!");
	
	%>
	添加成功！
	<a href="requireForm.jsp">查看文档</a>	
	
</body>
</html>
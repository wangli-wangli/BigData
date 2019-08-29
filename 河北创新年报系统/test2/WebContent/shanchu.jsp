<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.*"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.model.Filters"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

String support_type = request.getParameter("support_type");

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

 //删除所有符合要求的文档
collection.deleteMany(Filters.eq("依托单位类型",support_type));
//检索查看结果
FindIterable<Document> findIterable=collection.find();
MongoCursor<Document> mongoCursor=findIterable.iterator();
%>
<<jsp:forward page="requireForm.jsp"></jsp:forward>	
</body>
</html>
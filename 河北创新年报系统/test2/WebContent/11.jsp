<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
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
String name=request.getParameter("name");
String neirong=request.getParameter("neirong");
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

MongoCollection<org.bson.Document> collection=mongoDatabase.getCollection("mycol");
System.out.println("Collect mycol selection is successful");

Document document=new Document("name",name).
append("neirong",neirong);
List<Document> documents=new ArrayList<Document>();
documents.add(document);
collection.insertMany(documents);
System.out.println("Document insert successfully!");
%>
插入成功！

<a href="chakanwendang.jsp">查看文档</a>
</body>
</html>
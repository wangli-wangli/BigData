<%@page import="com.mongodb.*"%>
<%@page import="org.bson.Document"%>
<%@page import="java.util.*"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.FindIterable"%>
<%@page import="com.mongodb.client.MongoCursor"%>
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
 
 FindIterable<Document> findIterable=collection.find();
 MongoCursor<Document> mongoCursor=findIterable.iterator();
 while(mongoCursor.hasNext()) {
	 System.out.println(mongoCursor.next());
     Document aa=mongoCursor.next();
     String name=aa.getString("name");
     String neirong=aa.getString("neirong");
%>
文件名：
<%=name %> &nbsp;&nbsp;&nbsp;&nbsp;|  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
内容：
<%=neirong %><br/>
<%} %>

</body>
</html>
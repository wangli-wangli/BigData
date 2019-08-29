<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="Bean.Gud"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在此处插入标题</title>
<script src="jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	var i = 0
	$(document).ready(function() {
		$(".flip2").click(function() {
			i++;
			$(".panel").slideToggle("slow");
			if (i % 2 == 1) {
				document.getElementById("anniu").value = "-";
			} else {
				document.getElementById("anniu").value = "+";
			}
		});
	});
</script>

<style type="text/css">
body {
	background-color: #ecf5f8;
}

div.panel, p.flip {
	align: center;
	padding: 5px;
	margin-left: 5cm;
	text-align: left;
	/* background:#e5eecc; */
	border: solid 1px #c3c3c3;
	width: 70%;
}

div.panel {
	display: none;
}

.kuang {
	margin-left: 120px;
	width: 80%;
	border-color: #BCF;
	border-style: solid;
	border-width: 10px;
	background-color: white;
}
</style>
</head>
<body>
	<%
		String cname = (String) request.getAttribute("cname");
		System.out.println("Gud:" + cname);
	%>
	<img src="logo.png" style="margin-top: 0; margin-left: 0"
		width="450px;">

	<!-- 登录 -->
	<script type="text/javascript" src="login.js"></script>
	<link type="text/css" rel="stylesheet" href="login.css" />
	<div style="background-color: #ABF;">
		<br> <a
			style="color: black; margin-left: 50px; margin-right: 50px; font-size: 20px; text-decoration: none;"
			href="Search2.jsp">首页</a> <a
			style="color: black; margin-left: 50px; margin-right: 50px; font-size: 20px; text-decoration: none;"
			href="t3.jsp?content=<%=cname%>">查看投资族谱</a> <a
			style="color: black; margin-left: 50px; margin-right: 50px; font-size: 20px; text-decoration: none;"
			href="t4.jsp?content=<%=cname%>">查看企业族谱</a> <a
			style="color: black; margin-left: 50px; margin-right: 50px; font-size: 20px; text-decoration: none;"
			href="t5.jsp?content=<%=cname%>">查看更多疑似关系</a>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="kuang">
	<%
	
	int i=0; 
	DecimalFormat df = new DecimalFormat("#.00");
	List<Gud> list=(List<Gud>)request.getAttribute("list");
	String max=list.get(0).getGname();double max_num=list.get(0).getGmoney();double sum=0;
	for(Gud in:list){
		if(max_num<in.getGmoney()){
			max_num=in.getGmoney();
			max=in.getGname();
		}
		sum=sum+in.getGmoney();
	}
	%>
		<p width="70%" align="center">
			<span style="font-size: 20px;">疑似控股人：<%=max %>-------<%=df.format(max_num*100/sum)%>%---><%=cname %></span>
		</p>
		<p width="70%" align="center">
			<input type="submit" value=" " style="background: pink">公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value=" " style="background: #e5eecc">最大股东&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="submit" value=" " style="background: wheat">其他股东&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>

		<p class="flip" style="background: pink">
			<input class="flip2" id="anniu" type="submit"
				style="background: transparent; border-width: 1px;" value="+"><span
				style="font-size: 20px; font-family: 黑体"><%=cname%></span>
		</p>
		
		<%
		
		for(Gud in:list){
			double p=in.getGmoney()*100/sum;
		   if(in.getGname().equals(max)){
		%>
		
			<div class="panel" style="background: #e5eecc">
			<%}
		   else{
		   %>
		   <div class="panel" style="background: wheat">
		   <%} %>
				<p>
					<b><span style="font-size: 20px; font-family: 黑体"><%=in.getGname() %></span></b><br>
					<span style="color: #7B7B7B">股份比例： </span><span
						style="color: #EA7500"><%=df.format(p) %>%</span>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span
						style="color: #7B7B7B">认缴金额： </span><span style="color: #EA7500"><%=in.getGmoney() %></span>
				 
				    <input type="hidden" id="name<%=i %>" value="<%=in.getGname() %>" > 
					 <input	type="hidden" id="money<%=i %>" value="<%=in.getGmoney() %>" >
					<%i++; %>
				</p>
			</div>
			<br>
			<br>

		<%} %>
		 
		<input type="hidden" id="count" value="<%=list.size()%>">
	

	<div id="container" style="height: 400px"></div>
	<script type="text/javascript" src="js/echarts.js"></script>
	<div id="main" style="width: 1200px; height: 400px;"></div>
	<script type="text/javascript">
	    var name1=new Array();
	    var money=new Array();
	     
	     
	    var count = document.getElementById("count").value;
	    for(var i=0;i<count;i++){
	    	 name1[i] = document.getElementById("name"+i).value;
	    	money[i] = document.getElementById("money"+i).value;
	    	//alert(name1[i]);
	    }
	    //alert(""+name1[0]+"  "+money[0]);
		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('container'));
		var app = {};
		option = null;
		// 指定图表的配置项和数据
		option = {
			backgroundColor : '#FFF',
			series : [ {
				name : '访问来源',
				type : 'pie',
				radius : '55%',
				data : [ {name : name1[0],value : money[0]},
					{name : name1[1],value : money[1]},
					{name : name1[2],value : money[2]},
					{name : name1[3],value : money[3]},
					{name : name1[4],value : money[4]},
					{name : name1[5],value : money[5]}
				],
				roseType : 'angle',
				label : {
					normal : {
						textStyle : {
							color : 'rgba(0, 0, 0, 1)'
						}
					}
				},
				labelLine : {
					normal : {
						lineStyle : {
							color : 'rgba(0, 0, 0, 1)'
						}
					}
				},
				itemStyle : {
					normal : {
						color : '#c23531',
						shadowBlur : 200,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		if (option && typeof option === "object") {
			myChart.setOption(option, true);
		}
	</script>
	</div>
</body>
</html>
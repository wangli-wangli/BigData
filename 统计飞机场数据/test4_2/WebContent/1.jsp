<%@page import="testt2.readFile" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>统计最繁忙的机场 Top10</title>
<script type="text/javascript" src="echarts.js"></script>
</head>
<body>
<%
readFile r=new readFile();
String[][] data=r.readFileByLines("/home/hadoop/Documents/file1.txt");
for(int i=0;i<10;i++){
%>
 <input type="hidden" id="1<%=i%>" value="<%=data[0][i]%>"/>
<input type="hidden" id="2<%=i%>" value="<%=data[1][i]%>"/> 
<%} %>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px; height: 400px;"></div>
 <script type="text/javascript">
 var data1=new Array();
 var data2=new Array();
 for(var i=0;i<10;i++){
	 data1[i]=document.getElementById("1"+i).value*1;
	 data2[i]=document.getElementById("2"+i).value;
 }
 
 
	// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('main'))
	// 指定图表的配置项和数据
	var option = {
		title : {
			text : '最繁忙的机场 Top10'
		},
		tooltip : {},
		legend : {
			data : [ '票数' ]
		},
		xAxis : {
			data :  [ data2[0], data2[1], data2[2], data2[3], data2[4], data2[5],data2[6],data2[7],data2[8],data2[9]] 
		},
		yAxis : {},
		series : [ {
			name : '机场',
			type : 'bar',
			data : [ data1[0], data1[1], data1[2], data1[3], data1[4], data1[5],data1[6],data1[7],data1[8],data1[9]] 
		} ]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
</script>

</body>
</html>
<%@page import="testt2.readFile" %>
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
readFile r=new readFile();
String[][] data=r.readFileByLines("/home/hadoop/Documents/file3.txt");
for(int i=0;i<10;i++){
%>
 <input type="hidden" id="1<%=i%>" value="<%=data[0][i]%>"/>
<input type="hidden" id="2<%=i%>" value="<%=data[1][i]%>"/> 
<%} %>
 <div id="container" style="height: 800px"></div>
<script type="text/javascript" src="echarts.js"></script>
   
 <div id="main" style="width: 100%;height:100%;"></div>
 <script type="text/javascript">
	var data1 = new Array();
	var data2 = new Array();
	for (var i = 0; i < 10; i++) {
		data1[i] = document.getElementById("1" + i).value * 1;
		data2[i] = document.getElementById("2" + i).value;
	}

    
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('container'));
        var app={};
        option =null;
        // 指定图表的配置项和数据
   option = {
		   title : {
				text : '某一天的各个机场的卖出数据 top10'
			},
    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : [ data2[0], data2[1], data2[2], data2[3], data2[4], data2[5],data2[6],data2[7],data2[8],data2[9]],
            axisTick: {
                alignWithLabel: true
            }
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'直接访问',
            type:'bar',
            barWidth: '60%',
            data:[data1[0], data1[1], data1[2], data1[3], data1[4], data1[5],data1[6],data1[7],data1[8],data1[9]]
        }
    ]
};
;
      if (option && typeof option === "object") {
    	    myChart.setOption(option, true);
    	}

    </script>

</body>
</html>
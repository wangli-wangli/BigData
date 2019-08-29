<%@page import="testt2.readFile"%>
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
		readFile r = new readFile();
		String[][] data = r.readFileByLines("/home/hadoop/Documents/file2.txt");
		for (int i = 0; i < 10; i++) {
	%>
	<input type="hidden" id="1<%=i%>" value="<%=data[0][i]%>" />
	<input type="hidden" id="2<%=i%>" value="<%=data[1][i]%>" />
	<%
		}
	%>
	<div id="container" style="height: 600px"></div>
	<script type="text/javascript" src="echarts.js"></script>

	<div id="main" style="width: 1200px; height: 800px;"></div>
	<script type="text/javascript">
		var data1 = new Array();
		var data2 = new Array();
		for (var i = 0; i < 10; i++) {
			data1[i] = document.getElementById("1" + i).value * 1;
			data2[i] = document.getElementById("2" + i).value;
		}

		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('container'));
		var app = {};
		option = null;
		// 指定图表的配置项和数据
		option = {
			backgroundColor : '#FFF',
			 title: {
			        text: '最大的代理人 TOP10',
			        left: 'center',
			        top: 20,
			        textStyle: {
			            color: '#000'
			        }
			    },
			series : [ {
				name : '访问来源',
				type : 'pie',
				radius : '55%',
				data : [ {value : data1[0],name : data2[0]}, 
					{value : data1[1],name : data2[1]},
					{value : data1[2],name : data2[2]},
					{value : data1[3],name : data2[3]},
					{value : data1[4],name : data2[4]},
					{value : data1[5],name : data2[5]},
					{value : data1[6],name : data2[6]},
					{value : data1[7],name : data2[7]},
					{value : data1[8],name : data2[8]},
					{value : data1[9],name : data2[9]}
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


</body>
</html>
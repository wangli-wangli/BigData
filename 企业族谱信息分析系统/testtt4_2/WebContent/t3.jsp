<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>在此处插入标题</title>
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="js/echarts.min.js" ></script>
<style type="text/css">
body {
	background-color: #ecf5f8;
}
.kuang {
	margin-left: 120px;
	width: 80%;
	border-color: #BCF;
	border-style: solid;
	border-width: 10px;
	background-color: white;
	width: 80%;
	height: 800px;
}
</style>
</style>
</head>
<body>
<%
String cname=(String)request.getParameter("content");
System.out.println("t3:"+cname);
%>
<img src="logo.png" style="margin-top: 0; margin-left: 0"
		width="450px;">
		
	<!-- 登录 -->
	<script type="text/javascript" src="login.js"></script>
	<link type="text/css" rel="stylesheet" href="login.css" />
	<div style="background-color: #ABF;">
			<br>
		<a  style="color:black;margin-left:50px;margin-right:50px;font-size:20px; text-decoration: none;" href="Search2.jsp">首页</a>
		<a  style="color:black;margin-left:50px;margin-right:50px;font-size:20px; text-decoration: none;" href="Solution?action=gud&content=<%=cname%>">查看股权结构</a>
		<a  style="color:black;margin-left:50px;margin-right:50px;font-size:20px; text-decoration: none;" href="t4.jsp?content=<%=cname%>">查看企业族谱</a>
		<a  style="color:black;margin-left:50px;margin-right:50px;font-size:20px; text-decoration: none;" href="t5.jsp?content=<%=cname%>">查看更多疑似关系</a>
	</div>
	<br><br><br><br><br><br>
<div id="chart1" class="kuang" ></div>
<br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>
<script type="text/javascript">
var chart1 = echarts.init(document.getElementById("chart1"));
chart1.showLoading();
init();
function init(){
	var url = location.search; //获取url中"?"符后的字串
	   var theRequest = new Object();
	   if (url.indexOf("?") != -1) {
	      var str = url.substr(1);
	      strs = str.split("&");
	      for(var i = 0; i < strs.length; i ++) {
	         theRequest[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
	      }
	   }
	   var cc = theRequest['content'];
	$.ajaxSetup({ 
		cache: false 
		});
	$.ajax({
		type:'GET',
		url:'Solution',
		data:{
			action:'zupu',
			content:cc
		},
		success:function(json){
			//alert(json);
			chart1.hideLoading();
			var	option = {
					backgroundColor: '#ffffff',	// 背景颜色
				    title: {                    // 图表标题
				        text: "投资族谱",           // 标题文本
				        left : '3%',                    // 标题距离左侧边距
				        top : '3%',                     // 标题距顶部边距
						textStyle : {                       // 标题样式
							color : '#000',                     // 标题字体颜色
							fontSize : '30',                    // 标题字体大小
						}
				    },
				    tooltip: {                  // 提示框的配置
				        formatter: function(param) {
				            if (param.dataType === 'edge') {
				                //return param.data.category + ': ' + param.data.target;
				                return param.data.target;
				            }
				            //return param.data.category + ': ' + param.data.name;
				            return param.data.name;
				        }
				    },
				    
				    series: [{
				        type: "graph",          // 系列类型:关系图
				        top: '10%',             // 图表距离容器顶部的距离
				        roam: true,             // 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移，可以设置成 'scale' 或者 'move'。设置成 true 为都开启
				        focusNodeAdjacency: true,   // 是否在鼠标移到节点上的时候突出显示节点以及节点的边和邻接节点。[ default: false ]
				                force: {                // 力引导布局相关的配置项，力引导布局是模拟弹簧电荷模型在每两个节点之间添加一个斥力，每条边的两个节点之间添加一个引力，每次迭代节点会在各个斥力和引力的作用下移动位置，多次迭代后节点会静止在一个受力平衡的位置，达到整个模型的能量最小化。
				                                // 力引导布局的结果有良好的对称性和局部聚合性，也比较美观。
				            repulsion: 1000,            // [ default: 50 ]节点之间的斥力因子(关系对象之间的距离)。支持设置成数组表达斥力的范围，此时不同大小的值会线性映射到不同的斥力。值越大则斥力越大
				            edgeLength: [150, 100]      // [ default: 30 ]边的两个节点之间的距离(关系对象连接线两端对象的距离,会根据关系对象值得大小来判断距离的大小)，
				                                        // 这个距离也会受 repulsion。支持设置成数组表达边长的范围，此时不同大小的值会线性映射到不同的长度。值越小则长度越长。如下示例:
				                                        // 值最大的边长度会趋向于 10，值最小的边长度会趋向于 50      edgeLength: [10, 50]
				        },
				        layout: "force",            // 图的布局。[ default: 'none' ]
				                                    // 'none' 不采用任何布局，使用节点中提供的 x， y 作为节点的位置。
				                                    // 'circular' 采用环形布局;'force' 采用力引导布局.
				        // 标记的图形
				        //symbol: "path://M19.300,3.300 L253.300,3.300 C262.136,3.300 269.300,10.463 269.300,19.300 L269.300,21.300 C269.300,30.137 262.136,37.300 253.300,37.300 L19.300,37.300 C10.463,37.300 3.300,30.137 3.300,21.300 L3.300,19.300 C3.300,10.463 10.463,3.300 19.300,3.300 Z",
				        symbol: 'circle',
				        lineStyle: {            // 关系边的公用线条样式。其中 lineStyle.color 支持设置为'source'或者'target'特殊值，此时边会自动取源节点或目标节点的颜色作为自己的颜色。
				            normal: {
				                color: '#000',          // 线的颜色[ default: '#aaa' ]
				                width: 1,               // 线宽[ default: 1 ]
				                type: 'solid',          // 线的类型[ default: solid ]   'dashed'    'dotted'
				                opacity: 0.5,           // 图形透明度。支持从 0 到 1 的数字，为 0 时不绘制该图形。[ default: 0.5 ]
				                curveness: 0            // 边的曲度，支持从 0 到 1 的值，值越大曲度越大。[ default: 0 ]
				            }
				        },
				        label: {                // 关系对象上的标签
				            normal: {
				                show: true,                 // 是否显示标签
				                position: "inside",         // 标签位置:'top''left''right''bottom''inside''insideLeft''insideRight''insideTop''insideBottom''insideTopLeft''insideBottomLeft''insideTopRight''insideBottomRight'
				                textStyle: {                // 文本样式
				                    fontSize: 16
				                }
				            }
				        },
				        edgeLabel: {                // 连接两个关系对象的线上的标签
				            normal: {
				                show: true,
				                textStyle: {                
				                    fontSize: 14
				                },
				                formatter: function(param) {        // 标签内容
				                    return param.data.category;
				                }
				            }
				        },
				        data:json.data,
				        categories:json.categories,
				        links:json.links
				    }],
				    
				    animationEasingUpdate: "quinticInOut",          // 数据更新动画的缓动效果。[ default: cubicOut ]    "quinticInOut"
				    animationDurationUpdate: 100                    // 数据更新动画的时长。[ default: 300 ]
				};
			chart1.setOption(option);
		},
		dataType:'json'
	});
}
</script>
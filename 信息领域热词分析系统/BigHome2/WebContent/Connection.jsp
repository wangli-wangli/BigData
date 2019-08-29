<%@ page import="wl.*"%>
<%@ page import="com.model.Key"%>
<%@ page import="com.dao.KeyDao"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.model.Key"%>
<%@ page import="com.dao.KeyDao"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>联系图</title>
<script src="js/echarts.js"></script>
<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/animate.min.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/main.css">
<script type="text/javascript">
function bj(){
	alert("下载成功！");
}

</script>
</head>
<body>
	<%
		String word = request.getParameter("name");
		String mean3;
		if (word == null) {
			word = "";
			mean3 = "";
		} else {
			mean3 = dao.find_mean(word);
		}
	%>
	<header id="header">

	<div class="container">
		<div class="row align-items-center justify-content-between d-flex">
			<div id="logo">
				<a href=""><img src="img/logo.png" alt="" title="" /></a>
				<div style="position: absolute; right: 3px; top: 20px">
				<a href="index.jsp" style="color:white" >搜索</a>&nbsp;&nbsp;&nbsp;
				<%
					KeyDao keyDaoI=new KeyDao();
					List<String> typeIndex=null; 
					typeIndex=keyDaoI.loadKeyType();
		        	int ni=typeIndex.size();
		        	String []ti=new String[ni];
		        	typeIndex.toArray(ti);
		        	for(int i=0;i<ni;i++)
		        	{
					%>
					<a href="chengXuRenSheng.jsp?word=<%= ti[i]%>" style="color:white" ><%= ti[i]%></a>&nbsp;&nbsp;&nbsp;
					<%} %>
					<a href="Connection.jsp" style="color:#f77" >联系图</a>&nbsp;&nbsp;&nbsp;
					<a href="temp.jsp" style="color:#f77">词云</a>
				</div>
			</div>
		</div>
	</div>
	</header>
	<section class="home-banner-area relative">
	<div class="container">
		<div
			class="row fullscreen d-flex align-items-center justify-content-center">
			<div class="banner-content col-lg-8 col-md-12">
				<div class="panel panel-default">
					<div class="panel-body"
						style="width: auto; height: 500px; margin-top: 2cm">
						<div id="chart1" style="width: 100%; height: 100%"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div align="center">
		<img src="img/rocket.png" alt="">
	</div>
	</section>
	<!-- End Banner Area -->
	<% if(!"".equals(word)&&word!=null&&!"".equals(mean3)&&mean3!=null){%>
	<!-- Start About Area -->
	<section class="about-area section-gap">
		<div class="container">
			<div class="row align-items-center justify-content-center">
				<div class="col-lg-5 col-md-6 about-left">
					<img class="img-fluid" src="img/about.jpg" alt="">
				</div>
				<div class="offset-lg-1 col-lg-6 offset-md-0 col-md-12 about-right">
					<h1>
						<%=word %>
					</h1>
					<div class="wow fadeIn" data-wow-duration="1s">
						<p>
							<%=mean3 %>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End About Area -->
<%} %>

<!-- Start Footer Area -->
	<footer class="footer-area section-gap">
	<div class="container">
		<div class="col-lg-4 col-md-6 single-footer-widget">
			<p class="footer-text m-0 col-lg-8 col-md-12">
				Copyright &copy;
				<script>
					document.write(new Date().getFullYear());
				</script>
			</p>
		</div>
	</div>
	</footer>
	<!-- End Footer Area -->
	<div id="back-top">
		<a title="Go to Top" href="#"></a>
	</div>
	<!-- ####################### End Scroll to Top Area ####################### -->

	<script src="js/vendor/jquery-2.2.4.min.js"></script>

	<script src="js/vendor/bootstrap.min.js"></script>

	<script src="js/easing.min.js"></script>
	<script src="js/hoverIntent.js"></script>
	<script src="js/superfish.min.js"></script>
	<script src="js/jquery.ajaxchimp.min.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/owl-carousel-thumb.min.js"></script>
	<script src="js/jquery.sticky.js"></script>
	<script src="js/jquery.nice-select.min.js"></script>
	<script src="js/parallax.min.js"></script>
	<script src="js/waypoints.min.js"></script>
	<script src="js/wow.min.js"></script>
	<script src="js/jquery.counterup.min.js"></script>
	<script src="js/mail-script.js"></script>
	<script src="js/main.js"></script>
</body>
</html>
<script type="text/javascript">
var chart1 = echarts.init(document.getElementById("chart1"));
chart1.showLoading();
init();
<%KeyDao keyDaoC = new KeyDao();
			List<String> types = null;%>
function init(){
	
			chart1.hideLoading();
			var	option = {
					backgroundColor: '#ffffff',	// 背景颜色
				    title: {                    // 图表标题
				        text: "热词关系",           // 标题文本
				        //left : '3%',                    // 标题距离左侧边距
				        //top : '3%',                     // 标题距顶部边距
						textStyle : {                       // 标题样式
							color : '#3174c7',                     // 标题字体颜色
							fontSize : '24',                    // 标题字体大小
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
				            repulsion: 80,            // [ default: 50 ]节点之间的斥力因子(关系对象之间的距离)。支持设置成数组表达斥力的范围，此时不同大小的值会线性映射到不同的斥力。值越大则斥力越大
				            edgeLength: [100, 50]      // [ default: 30 ]边的两个节点之间的距离(关系对象连接线两端对象的距离,会根据关系对象值得大小来判断距离的大小)，
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
				                color: 'grey',          // 线的颜色[ default: '#aaa' ]
				                width: 1,               // 线宽[ default: 1 ]
				                type: 'solid',          // 线的类型[ default: solid ]   'dashed'    'dotted'
				                opacity: 0.5,           // 图形透明度。支持从 0 到 1 的数字，为 0 时不绘制该图形。[ default: 0.5 ]
				                curveness: 0.2           // 边的曲度，支持从 0 到 1 的值，值越大曲度越大。[ default: 0 ]
				            }
				        },
				        label: {                // 关系对象上的标签
				            normal: {
				                show: true,                 // 是否显示标签
				                position: "inside",         // 标签位置:'top''left''right''bottom''inside''insideLeft''insideRight''insideTop''insideBottom''insideTopLeft''insideBottomLeft''insideTopRight''insideBottomRight'
				                textStyle: {                // 文本样式
				                    fontSize: 12
				                }
				            }
				        },
				        edgeLabel: {                // 连接两个关系对象的线上的标签
				            normal: {
				                show: true,
				                textStyle: {                
				                    fontSize: 8
				                },
				                formatter: function(param) {        // 标签内容
				                    return param.data.category;
				                }
				            }
				        },
				        data: [
				        	<%types = keyDaoC.loadKeyType();
			for (String type : types) {
				if (!"人工智能".equals(type)) {%>
				        		{
						            name: "<%=type%>",
						            draggable: true,// 节点是否可拖拽，只在使用力引导布局的时候有用。
						            symbolSize: [60, 60],
						            category: "<%=type%>"
						        }, 
				        		<%}
				//System.out.println("datas+"+type);
				List<Key> keysC = keyDaoC.loadKey(type);
				for (Key key : keysC) {%>
			            		{
						            name: "<%=key.getKey()%>",
						            draggable: true,// 节点是否可拖拽，只在使用力引导布局的时候有用。
						            symbolSize: [50, 50],
						            category: "<%=type%>"         // 数据项所在类目的 index。
						        }, 
						        <%}
			}%>
				       
				       ],
				        categories: [
				            	<%types = keyDaoC.loadKeyType();

			for (String type : types) {
				//System.out.println("cats+"+type);%>
				            		{name:'<%=type%>'},
				            		<%}%>
				        	],
				        links: [
				        	<%types = keyDaoC.loadKeyType();
			int nn = types.size();
			String[] ts = new String[nn];
			types.toArray(ts);
			int ns = nn - 1;
			for (int a = 0; a < ns; a++) {%>			        	
			        		{
		            			target:"<%=ts[a]%>", 
					            source: "<%=ts[a + 1]%>",
					            category:"连接"
					        }, 
					        <%}
			for (String type : types) {
				//System.out.println("links+" + type);
				List<Key> keysC = keyDaoC.loadKey(type);
				for (Key key : keysC) {
					//System.out.println("links+"+key.getKey());%>
			            		{
			            			target:"<%=key.getKey()%>", 
						            source: "<%=type%>",
						            category:""
						        }, 
						        <%}
			}%>			       			   
				        ]
				    }],
				    
				    animationEasingUpdate: "quinticInOut",          // 数据更新动画的缓动效果。[ default: cubicOut ]    "quinticInOut"
				    animationDurationUpdate: 100                    // 数据更新动画的时长。[ default: 300 ]
				};
				
				// 使用刚指定的配置项和数据显示图表
				chart1.setOption(option);
		}
		
chart1.on("click",function(param){  
	  var name=param.name;
	  window.location.href="Connection.jsp?name="+name;
	  });

</script>

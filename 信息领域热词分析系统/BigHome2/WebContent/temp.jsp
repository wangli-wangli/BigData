<%@ page import="wl.*"%>
<%@ page import="com.model.Key"%>
<%@ page import="com.dao.KeyDao"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>词云</title>
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
<script src="cloudJs/echarts.min.js"></script>
<script src="cloudJs/echarts-wordcloud.min.js"></script>
</head>
<body>
	<%
		String word = request.getParameter("name");
		String mean3;
		if (word == null) {
			word = "";
			mean3 = "";
		} else {
			mean3 =dao.find_mean(word);
		}
	%>

	<!-- Start Header Area -->
	<header id="header">
	
		<div class="container">
			<div class="row align-items-center justify-content-between d-flex">
				<div id="logo">
					<a href=""><img src="img/logo.png" alt="" title="" /></a>
					<div style="position:absolute;right:3px;top:20px">
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
					<a href="Connection.jsp" style="color:#f77" >联系图</a>
					<a href="temp.jsp" style="color:#f77">词云</a>
					</div>
				</div>		
			</div>
		</div>
	</header>
	<!-- End Header Area -->
	
	<!-- Start Banner Area -->
	<section class="home-banner-area relative">
	<div class="container">
		<div
			class="row fullscreen d-flex align-items-center justify-content-center">
			<div class="banner-content col-lg-8 col-md-12">
					<div class="panel panel-default">
				<div style="width: 450px; height: 450px;background-color:white;margin-left:100px;margin-top:1.5cm;" >
					<div id="worldCloud" style="width: 100%; height: 100%"></div>
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



	<!-- End Courses Area -->


<%
		KeyDao keyDao = new KeyDao();
		List<Key> keys = keyDao.loadKey();
	%>

	<script type="text/javascript"> 		 		 	
var worldCloudcharts=echarts.init(document.getElementById('worldCloud')); 
var worldCloudoption = { 			 
		title: { 			     
			text: '热词TOP50', 	
			x: 'center', 	
			textStyle: { 	
				fontSize: 50, 
				color:'#FFFFFF' 
				}  			 
}, 			   
tooltip: { 	
	show: true 			
	}, 			  
	series: [{ 
		name: '热词TOP50', 
		type: 'wordCloud', 
		sizeRange: [6, 66], 
		rotationRange: [-45, 90], 
		textPadding: 0, 	
		autoSize: { 	
			enable: true, 	
			minSize: 6 			 
			}, 			      
			textStyle: { 
				normal: { 	
					color: function() { 
						return 'rgb(' + [ 	
							Math.round(Math.random() * 160), 
							Math.round(Math.random() * 160), 	
							Math.round(Math.random() * 160) 	
							].join(',') + ')'; 			       
						} 			          
			}, 			           
			emphasis: { 	
				shadowBlur: 10, 	
				shadowColor: '#333' 	
				} 			     
			}, 			      
			data: [
				<%int i = 0;
			for (Key key : keys) {%>
				{ 	
					name: "<%=key.getKey()%>", 	
					value: "<%=key.getNum()%>"
					<%i++;%>
					}
				<%if (i != keys.size()) {%>
						,
						<%}
			}%>
			] 	
			}] 	
	};  	
var JosnList = [];  	
JosnList.push(
		<%i = 0;
			for (Key key : keys) {%>
		{ 	
			name: "<%=key.getKey()%>", 	
			value: "<%=key.getNum()%>"
			<%i++;%>
			}
		<%if (i != keys.size()) {%>
				,
				<%}
			}%>

	); 
worldCloudoption.series[0].data = JosnList;  	
worldCloudcharts.setOption(worldCloudoption);
//添加点击事件（单击），还有其他鼠标事件和键盘事件等等
worldCloudcharts.on("click",function(param){  
	  var name=param.name;
	  window.location.href="temp.jsp?name="+name;
 	  });
</script>
	<!--点击按钮-->



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
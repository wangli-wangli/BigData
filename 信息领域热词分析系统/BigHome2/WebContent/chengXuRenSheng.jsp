<%@ page import="wl.*"%>
<%@ page import="java.util.List"%>
<%@ page import="com.model.Key" %>
<%@ page import="com.dao.KeyDao" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
	
	<title>程序人生</title>
	
	 <link rel="stylesheet" href="css/linearicons.css"> 
	 <link rel="stylesheet" href="css/font-awesome.min.css"> 
	<link rel="stylesheet" href="css/magnific-popup.css">
	<link rel="stylesheet" href="css/nice-select.css">
	<link rel="stylesheet" href="css/animate.min.css">
	<link rel="stylesheet" href="css/owl.carousel.css">
	<link rel="stylesheet" href="css/main.css"> 
</head>

<body>
<%
String word=request.getParameter("word");
String mm=dao.find_mean(word);
if(mm==null||"".equals(mm))
{
	select s = new select();
	s.shuru(word);
	mean mean1 = s.mean2;
	mm = mean1.getMeann();
	if(mm.equals("该词没有解释")){		
	}
	else{
	dao.addMean(word,mm);
	}
}
%>

	<!-- Start Header Area -->
	<header id="header">
	
		<div class="container">
			<div class="row align-items-center justify-content-between d-flex">
				<div id="logo">
					<a href="index.jsp"><img src="img/logo.png" alt="" title="" /></a>
					<div style="float:right;margin-right:3px">
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
	<section  class="banner-area relative"  >
	<div class="container">
			<div class="row align-items-center justify-content-between d-flex">
				<div id="logo">
					<a href="index.jsp"><img src="img/logo.png" alt="" title="" /></a>
				</div>
			</div>
		</div>
		 <div class="container">
			<div class="row d-flex align-items-center justify-content-center">
				<div class="about-content col-lg-12" style="margin-top:1.5cm">
					<h1 class="text-white">
						<%=word %>
					</h1>
					<p><%=mm %></p>
					<div class="link-nav">
						<span class="box">
							<a href="index.jsp">Home </a>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="rocket-img" >
			<img src="img/rocket.png" alt="">
		</div>
	</section>
	<!-- End Banner Area -->
	<!-- Start Faculty Area -->
	
	<section class="faculty-area section-gap" style="background-color:#bef">
		<br/>
			<br/>
		<%
		List<mean> means=dao.find_allwords1(word);
		for(mean m:means){
			
		%><div class="content" width="70%">
			
			<div class="row justify-content-center d-flex align-items-center">
				<div class="col-lg-3 col-md-6 col-sm-12 single-faculty">
					<div class="meta-text text-center">
						<h4><%=m.getWord() %></h4>
						<div class="info wow fadeIn" data-wow-duration="1s" data-wow-delay=".1s">
							<p>
								<%=m.getMeann()%>
							</p>
						</div>
						<div >
						<%
						List<url> urls=dao.find_allUrls2(m.getWord() );
						for(url u:urls){
						%>
							<a href="<%=u.getUrll() %>"><%=u.getTitle() %></a><br/>
						<%} %>
						</div>
					</div>
				</div>
			</div>
			</div>
			<br/>
			<br/>
			<br/>
			<%} %>
		
	</section>
	<!-- End Faculty Area -->
<!-- Start Footer Area -->
	<footer class="footer-area section-gap">
	
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
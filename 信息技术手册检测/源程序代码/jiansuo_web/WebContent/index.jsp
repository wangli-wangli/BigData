<%@ page import="wl.*"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>信息手册检索</title>

<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/animate.min.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<%
		String word = null;
		word = request.getParameter("wordd");
		if (word != null) {
			if (word.equals("") || ("".equals(word) || (word == null))) {
				word = null;
			}
		}
		String explain = null;
		String classs = null;
		String abstractt = null;
		String keywords = null;
		boolean is = false;
		if (request.getParameter("explain") != null) {
			explain = request.getParameter("explain");
			classs = classify.classify(explain.trim());
			List<String> returnn = getKeywords.keywords(word, explain.trim());
			keywords = returnn.get(0);
			abstractt = returnn.get(1);
			is = true;
		}
		List<citiao> citiaos = null;

		if (word != null) {
			citiaos = DBUtil.load_like(word);
			if (citiaos.size() == 0) {
				citiaos = null;
			}
		}
	%>
	<!-- Start Header Area -->
	<header id="header">

	<div class="container">
		<div class="row align-items-center justify-content-between d-flex">
			<div id="logo">
				<a href=""><img src="img/logo.png" alt="" title="" /></a>
				<div
					style="position: absolute; right: 3px; top: 20px; margin-right: 30px">
					<%
						List<String> cs1 = DBUtil.load_allClasss();
						int i = 0;
						for (String c : cs1) {
							if (i == (cs1.size() / 2) + 1) {
					%>
					<br />
					<%
						}
					%>
					<a href="index2.jsp?wordd=<%=c%>" style="color: white"><%=c%></a>&nbsp;&nbsp;&nbsp;
					<%
						i++;
						}
					%>

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
				<h1 class="wow fadeIn" data-wow-duration="4s">
					河北信息 <br>手册检索
				</h1>
				<div class="input-wrap">
					<form action="index.jsp" method="get"
						class="form-box d-flex justify-content-between">
						<input type="text" placeholder="请输入搜索内容" class="form-control"
							name="wordd" value="">
						<button type="submit" class="btn search-btn">Search</button>
					</form>
				</div>
				<h4 class="text-white">类别</h4>
				<div class="courses pt-20">
					<%
						List<String> cs = DBUtil.load_allClasss();
						for (String c : cs) {
					%>
					<a href="index2.jsp?wordd=<%=c%>" data-wow-duration="1s"
						data-wow-delay=".9s"
						class="primary-btn transparent mr-10 mb-10 wow fadeInDown"><%=c%></a>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<div align="center">
			<img src="img/rocket.png" alt="">
		</div>
	</section>
	<!-- End Banner Area -->
	<%
		if (word == null) {

		} else if ((citiaos != null) && (is == false)) {
	%>
	<!-- Start About Area -->
	<section class="faculty-area section-gap" style="background-color:#bef">
	<br />
	<br />
	<%
		for (citiao ci : citiaos) {//正常从数据库中查询
	%>
	<div class="content" width="70%" style="margin-top: 50px">
		<div class="row justify-content-center d-flex align-items-center">
			<div style="background-color: white">
				<p>
				<h4 align="center"><%=ci.getName()%></h4>
				</p>
				<div class="info wow fadeIn" data-wow-duration="1s"
					data-wow-delay=".1s">
					<p style="font-size: 11px; margin-left: 3cm">
						分类：<%=ci.getClasss()%><br /> 摘要：<%=ci.getAbstracts()%><br />
						关键词：<%=ci.getKeywords()%></p>
					<p style="color: black; margin-left: 2cm; margin-right: 2cm">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=ci.getExplain()%></p>
				</div>
				<div></div>

			</div>
		</div>
	</div>
	<%
		}
	%> </section>
	<%
		} else if ((citiaos == null) && (is == false)) {//数据库中没有，需要用户输入
	%>
	<section class="about-area section-gap">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-lg-5 col-md-6 about-left">
				<img class="img-fluid" src="img/about.jpg" alt="">
			</div>
			<div class="offset-lg-1 col-lg-6 offset-md-0 col-md-12 about-right">
				<h1>
					<%=word%>
				</h1>
				<div class="wow fadeIn" data-wow-duration="1s">
					<form action="index.jsp" method="get">
						<textarea name="explain" rows="7" cols="70" value=""
							placeholder="请输入详细内容或解答"></textarea>
						<!-- 输入解释 -->
						<input type="hidden" name="wordd" value="<%=word%>"> <input
							type="submit" value="提交"
							style="position: absolute; margin-top: 30px; right: 30px; width: 100px">
						<!-- 按钮 -->
					</form>
				</div>
			</div>
		</div>
	</div>
	</section>
	<%
		} else if (citiaos == null && (is == true)) {//展示用户输入后自动显示分类
	%>
	<section class="about-area section-gap">
	<div class="container">
		<div class="row align-items-center justify-content-center">
			<div class="col-lg-5 col-md-6 about-left">
				<img class="img-fluid" src="img/about.jpg" alt="">
			</div>
			<div class="offset-lg-1 col-lg-6 offset-md-0 col-md-12 about-right">
				<h1>
					<%=word%>
				</h1>
				<div class="info wow fadeIn" data-wow-duration="1s"
					data-wow-delay=".1s">
					<p style="font-size: 11px;">
						分类：<%=classs%><br />摘要：<%=abstractt%><br /> 关键词：<%=keywords%></p>
					<p style="color: black;">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<%=explain%></p>

				</div>
			</div>
		</div>
	</div>
	</section>

	<%
		}
	%>
	<!-- Start Footer Area -->
	<footer class="footer-area section-gap"> </footer>

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
<%@ page import="wl.*"%>
<%@ page import="com.model.Key"%>
<%@ page import="com.dao.*"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>热词分析</title>

<link rel="stylesheet" href="css/linearicons.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/nice-select.css">
<link rel="stylesheet" href="css/animate.min.css">
<link rel="stylesheet" href="css/owl.carousel.css">
<link rel="stylesheet" href="css/main.css">
<script type="text/javascript">
	function bj() {
		alert("下载成功！");
	}
</script>
</head>
<body>
	<%
		String word = request.getParameter("wordd");
		String mean3;
		String jieshi = request.getParameter("jieshi");
		String leibie = request.getParameter("leibie");
		String type = "";
		System.out.println("aa:"+word);
		if (word == null) {
			word = "";
			mean3 = "";
		} else {
			if (jieshi != null && !jieshi.equals("")) {
				dao.addMean(word, jieshi);
			}
			if (leibie != null && !leibie.equals("")) {
				dao.addleibe(word, leibie);
			}
			select s = new select();
			mean m1 = dao.find_mean2(word);
			mean3 = m1.getMeann();
			type = m1.getType();
			if (mean3.equals("")) {
				s.shuru(word);
				mean mean1 = s.mean2;
				mean3 = mean1.getMeann();
				if(!mean3.equals("该词没有解释")){//该词爬取到了意思
				dao.addMean(word, mean3);
				}
			}
		}
	%>

	<!-- Start Header Area -->
	<header id="header">

	<div class="container">
		<div class="row align-items-center justify-content-between d-flex">
			<div id="logo">
				<a href=""><img src="img/logo.png" alt="" title="" /></a>
				<div style="position: absolute; right: 3px; top: 20px">
					<%
						KeyDao keyDaoI = new KeyDao();
						List<String> typeIndex = null;
						typeIndex = keyDaoI.loadKeyType();
						int ni = typeIndex.size();
						String[] ti = new String[ni];
						typeIndex.toArray(ti);
						for (int i = 0; i < ni; i++) {
					%>
					<a href="chengXuRenSheng.jsp?word=<%=ti[i]%>" style="color: white"><%=ti[i]%></a>&nbsp;&nbsp;&nbsp;
					<%
						}
					%>
					<a href="Download.jsp" style="color: #f77" onclick="bj()">下载</a> <a
						href="Connection.jsp" style="color: #f77">联系图</a> <a
						href="temp.jsp" style="color: #f77">词云</a>
				</div>
			</div>
		</div>
	</div>
	</header>
	<!-- End Header Area -->
	<!-- End Header Area -->


	<!-- Start Banner Area -->
	<section class="home-banner-area relative">
	<div class="container">
		<div
			class="row fullscreen d-flex align-items-center justify-content-center">
			<div class="banner-content col-lg-8 col-md-12">
				<h1 class="wow fadeIn" data-wow-duration="4s">
					信息领域 <br>热词分析
				</h1>
				<div class="input-wrap">
					<form action="index.jsp" method="get"
						class="form-box d-flex justify-content-between">
						<input type="text" placeholder="请输入搜索内容" class="form-control"
							name="wordd">
						<button type="submit" class="btn search-btn">Search</button>
						<%
							select s = new select();
							mean mean1 = s.mean2;
							mean1.setMeann("该词没有解释");
							mean1.setWord("");
						%>
					</form>
				</div>
				<h4 class="text-white">热词</h4>

				<div class="courses pt-20">
					<%
						typeIndex = keyDaoI.loadKeyType();
						typeIndex.toArray(ti);
						for (int i = 0; i < ni / 2; i++) {
					%>
					<a href="chengXuRenSheng.jsp?word=<%=ti[i]%>"
						data-wow-duration="1s" data-wow-delay=".9s"
						class="primary-btn transparent mr-10 mb-10 wow fadeInDown"><%=ti[i]%></a>
					<%
						}
						for (int i = ni / 2; i < ni; i++) {
					%>
					<a href="chengXuRenSheng.jsp?word=<%=ti[i]%>"
						data-wow-duration="1s" data-wow-delay="1.8s"
						class="primary-btn transparent mr-10 mb-10 wow fadeInDown"><%=ti[i]%></a>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<div class="rocket-img">
			<img src="img/rocket.png" alt="">
		</div>
	</section>
	<!-- End Banner Area -->


	<%
		if (word!=null&&!word.equals("")) {
	%>
	<!-- Start About Area -->
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
					<%
						if (type.equals("") && mean3.equals("该词没有解释")) {//没有爬取到意思，数据库中也没有分类
					%>
					<p>
						<%=mean3%><br /> <br />
					<form action="index.jsp" method="get">
						<textarea name="jieshi" rows="7" cols="70" value=""
							placeholder="请输入热词解释"></textarea>
						<!-- 输入解释 -->
						<br /> <br /> <select name="leibie">
							<!-- 输入类别 -->
							<option value="">选择热词类别</option>
							<%
								typeIndex.toArray(ti);
										for (int i = 0; i < ni; i++) {
							%>
							<option value="<%=ti[i]%>"><%=ti[i]%></option>

							<%
								}
							%>
						</select> <input type="hidden" name="wordd" value="<%=word%>">
						<!-- 点击按钮，依旧查询这个词 -->
						<input type="submit" value="提交"
							style="position: absolute; right: 30px; width: 100px">
						<!-- 按钮 -->
					</form>
					</p>
					<%
						} else if (!type.equals("") && !mean3.equals("该词没有解释")) {//数据库中既有解释也有类别
					%>
					<p>
						<%=mean3%><br /> <br /> 类别：<%=type%>
					</p>
					<%
						}
						else if(type.equals("") && !mean3.equals("该词没有解释")){//爬取到了词语得意思，但是数据库中没有分类
					%>
					<p>
						<%=mean3%><br /> <br />
						<form action="index.jsp" method="get">
						<select name="leibie">
							<!-- 输入类别 -->
							<option value="">选择热词类别</option>
							<%
								typeIndex.toArray(ti);
										for (int i = 0; i < ni; i++) {
							%>
							<option value="<%=ti[i]%>"><%=ti[i]%></option>

							<%
								}
							%>
						</select> <input type="hidden" name="wordd" value="<%=word%>">
						<!-- 点击按钮，依旧查询这个词 -->
						<input type="submit" value="提交"
							style="position: absolute; right: 30px; width: 100px;">
						<!-- 按钮 -->
					</form>
						
				</p>
					
					<%} %>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- End About Area -->
	<%
		}
	%>






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
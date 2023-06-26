<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0  minimum-scale=1, maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<title>VIE: 아 오늘 영화 뭐 보지?</title>

<!--fontawesome추가  -->
<script src="https://kit.fontawesome.com/8dbcba5bdb.js" crossorigin="anonymous"></script>

<!-- 웹 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout_base.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery.smooth-scroll.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/rollmain.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.easing.js"></script>

<style>
* {
	text-align: center;
}
</style>
</head>
<body>

	<!---------- ----- ----->
	<ul class="skipnavi">
		<li><a href="#container">본문내용</a></li>
	</ul>
	<!-- wrap -->
	<div id="wrap">
		<!---------- ----- ----->
		<%@ include file="./header.jsp"%>
		<main>

			<h2>
				<img src="${pageContext.request.contextPath}/resources/image/main_logo(black stic).png" alt="vie" width="300px" height="300px">
			</h2>
			<h2>환영합니다!</h2>
			<p>회원가입 또는 로그인하여 계속 진행하세요.</p>

			<div>
				<button onclick="location.href='회원가입페이지.html'">회원가입</button>
				<button onclick="location.href='로그인페이지.html'">로그인</button>
			</div>
		</main>

		<%@ include file="./footer.jsp"%>
</body>
</html>

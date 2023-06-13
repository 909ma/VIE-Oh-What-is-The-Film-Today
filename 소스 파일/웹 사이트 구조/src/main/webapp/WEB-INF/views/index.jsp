<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>(수정)아 오늘 영화 뭐 보지?</title>
</head>
<style>
* {
	text-align: center;
}

#header {
	display: flex;
	justify-content: center;
	align-items: center;
}

footer {
	text-align: center;
	padding: 10px;
	background-color: #f5f5f5;
	color: #999999;
	font-size: 14px;
}
</style>
<link rel="stylesheet" href="commonStyles.css">
<!-- 제대로 안 됨 -->

<body>
	<%@ include file="header.jsp"%>
	<main>


		<h2>환영합니다!</h2>
		<p>회원가입 또는 로그인하여 계속 진행하세요.</p>

		<div>
			<button onclick="location.href='회원가입페이지.html'">회원가입</button>
			<button onclick="location.href='로그인페이지.html'">로그인</button>
		</div>
	</main>

	<%@ include file="footer.jsp"%>
</body>
</html>

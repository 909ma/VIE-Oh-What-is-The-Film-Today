<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>영화 내용 상세보기</title>
<style>
* {
	box-sizing: border-box;
}

body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
}

.container {
	max-width: 800px;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	color: #333333;
}

.movie-title {
	font-size: 24px;
	margin-bottom: 10px;
}

.movie-details {
	margin-bottom: 20px;
}

.movie-poster {
	max-width: 100%;
	height: auto;
	margin-bottom: 20px;
}

.movie-description {
	margin-bottom: 10px;
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
</head>
<body>
	<%@ include file="../header.jsp"%>
	<div class="container">
		<h2 class="movie-title">영화 제목</h2>
		<img class="movie-poster" src="../image/테스트1.jpg" alt="영화 포스터" />
		<div class="movie-details">
			<p class="movie-description">영화 설명이나 내용을 여기에 작성합니다.</p>
			<p>더 많은 영화 정보를 추가할 수 있습니다.</p>
		</div>
	</div>
	<%@ include file="../footer.jsp"%>
</body>
</html>
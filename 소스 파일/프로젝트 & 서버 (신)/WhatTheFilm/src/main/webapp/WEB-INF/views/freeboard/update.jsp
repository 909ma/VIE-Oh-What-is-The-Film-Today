<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
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
</head>
<body>
	<%@ include file="../logoutBar.jsp"%>
	<%@ include file="../header.jsp"%>
    <h1>게시글 수정</h1>
    
    <form action="update" method="post">
        <input type="hidden" name="postId" value="${post.id}">
        
        <label for="title">제목:</label>
        <input type="text" name="title" id="title" value="${post.title}" required><br>
        
        <label for="content">내용:</label>
        <textarea name="content" id="content" rows="5" required>${post.content}</textarea><br>
        
        <label for="author">작성자:</label>
        <input type="text" name="author" id="author" value="${post.author}" required><br>
        
        <input type="submit" value="수정 완료">
    </form>
        	<%@ include file="../footer.jsp"%>
</body>
</html>

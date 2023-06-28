<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 페이지</title>
    <!-- fontawesome 추가 -->
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
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 10px;
        }

        p {
            color: #666;
            margin-bottom: 10px;
        }

        .container {
            width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .container form {
            margin-top: 20px;
        }

        .container input[type="submit"] {
            padding: 8px 16px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .container input[type="submit"]:hover {
            background-color: #23527c;
        }

        .button-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #F5F5DC;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            margin-right: 10px;
        }

        .button-link:hover {
            background-color: #23527c;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <%@ include file="../logoutBar.jsp"%>
    <%@ include file="../header.jsp"%>
    <h1>게시글 상세 페이지</h1>

    <div class="container">
        <h2>제목: ${data.title}</h2>
        <p>작성자: ${data.author}</p>
        <p>내용: ${data.content}</p>
        <p>작성일: ${data.created_at}</p>

        <form action="delete" method="post">
            <input type="hidden" name="postId" value="${postId}">
            <%-- 사용자명이 "admin"인 경우에만 삭제 버튼 표시 --%>
            <% if ("admin".equals(session.getAttribute("loginid"))) { %>
                <input type="submit" value="삭제">
            <% } %>
            <a href="/freeboard/list" class="button-link">목록으로 돌아가기</a>
        </form>
    </div>

    <%@ include file="../footer.jsp"%>
</body>
</html>

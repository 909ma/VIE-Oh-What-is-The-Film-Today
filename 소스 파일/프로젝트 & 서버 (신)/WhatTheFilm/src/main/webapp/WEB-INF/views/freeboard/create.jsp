<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새로운 게시글 작성</title>
    
    <!-- Fontawesome 추가 -->
    <script src="https://kit.fontawesome.com/8dbcba5bdb.js" crossorigin="anonymous"></script>

    <!-- 웹 폰트 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

    <!-- 스타일 시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout_base.css">

    <!-- 자바스크립트 파일 -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery.smooth-scroll.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/rollmain.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.easing.js"></script>

    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #23527c;
        }
        
        .readonly {
            background-color: #f5f5f5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <%@ include file="../logoutBar.jsp"%>
    <%@ include file="../header.jsp"%>
    
    <h1>새로운 게시글 작성</h1>
    
    <form action="create" method="post">
        <label for="title">제목:</label>
        <br></br>
        <input type="text" name="title" id="title" required><br>
        
        <label for="content">내용:</label>
                <br></br>
        <textarea name="content" id="content" rows="5" required></textarea><br>
        
        <label for="author">작성자:</label>
        <input type="text" name="author" id="author" value="<%= session.getAttribute("loginid") %>" readonly class="readonly"><br>
        
        <input type="submit" value="작성 완료">
    </form>
    
    <%@ include file="../footer.jsp"%>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>자세한 공지사항</title>
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
        body {
            font-family: 'Noto Sans KR', sans-serif;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
        }

        .announcement-container {
            border: 1px solid #ccc;
            border-radius: 4px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .announcement-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .announcement-content {
            font-size: 16px;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .date-section {
            margin-bottom: 10px;
        }

        .date-label {
            font-weight: bold;
            margin-right: 10px;
        }

        p {
            color: #666;
            margin-bottom: 10px;
        }

        form {
            margin-bottom: 10px;
        }

        button {
            padding: 8px 16px;
            background-color: #337ab7;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #23527c;
        }

        .button-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #337ab7;
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
    <h1>자세한 공지사항</h1>
    
    <div class="announcement-container">
        <h2 class="announcement-title">${data.title}</h2>
        <p class="announcement-content">${data.content}</p>
        
        <div class="date-section">
            <span class="date-label">작성일 :</span>
            <span>${data.created_at}</span>
        </div>
        
        <div class="date-section">
            <span class="date-label">마지막 수정일 :</span>
            <span>${data.updated_at}</span>
        </div>
        
        <c:if test="${session.getAttribute('loginid') == 'admin'}">
            <form action="/announcement/delete" method="post">
                <input type="hidden" name="noticeId" value="${data.id}" />
                <button type="submit">삭제</button>
            </form>
        </c:if>
        
        <c:if test="${session.getAttribute('loginid') == 'admin'}">
            <a href="/announcement/update?noticeId=${data.id}" class="button-link">수정하기</a>
        </c:if>
    </div>
    
    <a href="/announcement/list" class="button-link">목록으로 돌아가기</a>
    <%@ include file="../footer.jsp"%>
</body>
</html>

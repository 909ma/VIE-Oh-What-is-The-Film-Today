<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th,
        td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }

        a {
            color: #337ab7;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

.create-new-link {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #F5F5DC;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
}

        .create-new-link:hover {
            background-color: #23527c;
        }

        /* Added CSS */
        td.column-divider {
            width: 1px;
            background-color: #ddd;
        }

        /* Adjusted styles for larger post list */
        .post-list {
            max-width: 800px;
            margin: 0 auto;
        }

        /* Pagination styles */
        .pagination {
            margin-top: 20px;
        }

        .pagination a {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            color: #333;
            background-color: #f2f2f2;
            border-radius: 4px;
        }

        .pagination a.active {
            background-color: #337ab7;
            color: #fff;
        }

        .pagination a:hover {
            background-color: #ddd;
        }
    </style>
</head>
<body>
    <%@ include file="../logoutBar.jsp"%>
    <%@ include file="../header.jsp"%>
    
    <div class="post-list">
        <h1>자유게시판</h1>
        
        <table>
            <tr>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            
            <c:forEach items="${data}" var="post">
                <tr>
                    <td><a href="detail?postId=${post.id}">${post.title}</a></td>
                    <td>${post.author}</td>
                    <td>${post.created_at}</td>
                </tr>
            </c:forEach>
        </table>
        
<a href="create" class="create-new-link">새로운 게시글 작성</a>
        
        <div class="pagination">
            <c:if test="${page > 1}">
                <a href="list?page=${page - 1}">이전 페이지</a>
            </c:if>
            
            <c:if test="${hasNextPage}">
                <a href="list?page=${page + 1}">다음 페이지</a>
            </c:if>
        </div>
    </div>
    
    <%@ include file="../footer.jsp"%>
</body>
</html>

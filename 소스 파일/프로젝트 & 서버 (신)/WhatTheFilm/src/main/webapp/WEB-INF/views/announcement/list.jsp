<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>공지사항 목록</title>
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

        .create-new-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #337ab7;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
        }

        .create-new-link:hover {
            background-color: #23527c;
        }

        /* Added CSS */
        td.date-column {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: right;
        }

        td.title-column {
            width: 70%;
        }

        td.column-divider {
            width: 1px;
            background-color: #ddd;
        }
        
        /* Adjusted styles for larger notice list */
        .notice-list {
            max-width: 800px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <%@ include file="../logoutBar.jsp"%>
    <%@ include file="../header.jsp"%>
    
    <div class="notice-list">
        <h1>공지사항 목록</h1>
        
        <table>
            <thead>
                <tr>
                    <th class="title-column">제목</th>
                    <th class="column-divider"></th>
                    <th class="date-column">작성일</th>
                    <th class="column-divider"></th>
                    <th class="date-column">마지막 수정일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${data}" var="announcement">
                    <tr>
                        <td class="title-column"><a href="/announcement/detail?noticeId=${announcement.id}">${announcement.title}</a></td>
                        <td class="column-divider"></td>
                        <td class="date-column">${announcement.created_at}</td>
                        <td class="column-divider"></td>
                        <td class="date-column">${announcement.updated_at}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="pagination">
            <c:if test="${startPage > 1}">
                <a href="/announcement/list?nowPage=${startPage - 1}">Previous</a>
            </c:if>
            
            <c:forEach begin="${startPage}" end="${endPage}" var="page">
                <a href="/announcement/list?nowPage=${page}" class="${page == currentPage ? 'active' : ''}">${page}</a>
            </c:forEach>
            
            <c:if test="${endPage < totalCount}">
                <a href="/announcement/list?nowPage=${endPage + 1}">Next</a>
            </c:if>
        </div>
        
        <c:if test="${session.getAttribute('loginid') == 'admin'}">
            <a href="/announcement/create" class="create-new-link">새로 만들기</a>
        </c:if>
    </div>
    
    <%@ include file="../footer.jsp"%>
</body>
</html>

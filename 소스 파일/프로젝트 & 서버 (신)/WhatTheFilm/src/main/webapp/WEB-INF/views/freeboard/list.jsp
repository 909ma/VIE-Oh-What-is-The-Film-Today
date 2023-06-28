<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자유게시판</title>
</head>
<body>
    <h1>자유게시판</h1>
    
    <table>
        <tr>
            <th>제목</th>
            <th>작성자</th>
<!--             <th>조회수</th> -->
            <th>작성일</th>
        </tr>
        <c:forEach items="${data}" var="post">
            <tr>
                <td><a href="detail?postId=${post.id}">${post.title}</a></td>
                <td>${post.author}</td>
<%--                 <td>${post.views}</td> --%>
                <td>${post.created_at}</td>
            </tr>
        </c:forEach>
    </table>
    
    <a href="create">새로운 게시글 작성</a>
    
    <div>
        <c:if test="${page > 1}">
            <a href="list?page=${page - 1}">이전 페이지</a>
        </c:if>
        
        <c:if test="${hasNextPage}">
            <a href="list?page=${page + 1}">다음 페이지</a>
        </c:if>
    </div>
</body>
</html>

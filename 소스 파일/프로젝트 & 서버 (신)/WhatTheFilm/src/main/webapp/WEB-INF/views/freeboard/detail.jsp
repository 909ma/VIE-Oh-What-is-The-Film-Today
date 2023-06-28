<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 페이지</title>
</head>
<body>
    <h1>게시글 상세 페이지</h1>
    
    <h2>제목: ${data.title}</h2>
    <p>작성자: ${data.author}</p>
<%--     <p>조회수: ${data.views}</p> --%>
    <p>내용: ${data.content}</p>
    <p>작성일: ${data.created_at}</p>
    
<%--     <a href="update?postId=${postId}">수정</a> --%>
    <form action="delete" method="post">
        <input type="hidden" name="postId" value="${postId}">
        <%-- 사용자명이 "admin"인 경우에만 삭제 버튼 표시 --%>
        <% if ("admin".equals(session.getAttribute("loginid"))) { %>
            <input type="submit" value="삭제">
        <% } %>
        <a href="/freeboard/list" class="button-link">목록으로 돌아가기</a>
    </form>
</body>
</html>

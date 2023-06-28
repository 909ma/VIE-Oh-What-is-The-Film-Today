<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새로운 게시글 작성</title>
</head>
<body>
    <h1>새로운 게시글 작성</h1>
    
    <form action="create" method="post">
        <label for="title">제목:</label>
        <input type="text" name="title" id="title" required><br>
        
        <label for="content">내용:</label>
        <textarea name="content" id="content" rows="5" required></textarea><br>
        
        <label for="author">작성자:</label>
        <input type="text" name="author" id="author" value="<%= session.getAttribute("loginid") %>" readonly><br>
        
        <input type="submit" value="작성 완료">
    </form>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
</head>
<body>
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
</body>
</html>

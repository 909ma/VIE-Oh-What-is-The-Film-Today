<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Update Announcement</title>
</head>
<body>
    <h1>Update Announcement</h1>
    
    <form action="/announcement/update" method="post">
        <input type="hidden" name="noticeId" value="${announcement.noticeId}">
        <input type="text" name="title" value="${announcement.title}" required><br>
        <textarea name="content" required>${announcement.content}</textarea><br>
        <button type="submit">Update</button>
    </form>
    
</body>
</html>

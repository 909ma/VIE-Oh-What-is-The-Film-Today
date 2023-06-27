<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>회원 정보</title>
    <style>
        body {
            font-family: '맑은 고딕', 'Malgun Gothic', '돋움', Dotum, sans-serif;
            background-color: #f7f7f7;
            padding: 20px;
        }
        
        h1 {
            color: #333333;
            text-align: center;
        }
        
        .container {
            max-width: 400px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border: 1px solid #cccccc;
            border-radius: 4px;
        }
        
        .info {
            margin-bottom: 10px;
        }
        
        .info label {
            font-weight: bold;
            width: 80px;
            display: inline-block;
        }
        
        .button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin-top: 20px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원 정보</h1>
        <div class="info">
            <label>아이디  :</label>
            ${data.loginid}
        </div>
        <div class="info">
            <label>닉네임  :</label>
            ${data.nickname}
        </div>
        <div class="info">
            <label>생년월일  :</label>
            ${data.birthyear}
        </div>
        <div class="info">
<%--              <label>입력일:</label> --%>
<%--             <fmt:formatDate value="${data.regdate}" pattern="yyyy.MM.dd HH:mm:ss" /> --%>

<%-- 굳이 필요 없고, 쓰려고 하면 아래 두 줄 주석 해제(위에껀 건드리지 말거나 그냥 지워버리기) --%>
<%-- <fmt:parseDate value="${data.regdate}" pattern="yyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both"/> --%>
<%-- 	<p>입력일 : <fmt:formatDate pattern="dd.MM.yyy HH:mm:ss" value="${parsedDateTime}"/> </p> --%>
        </div>
        <div class="info">
            <label>성별  :</label>
            ${data.gender}
        </div>
        <form method="POST" action="/delete">
            <input type="hidden" name="memberId" value="${data.member_id}" />
            <input type="submit" value="삭제" class="button" />
        </form>
        <form action="/update">
        	<input type="hidden" name = "loginid" value="${data.loginid}"/>
        	<input type="hidden" name = "nickname" value="${data.nickname}"/>
        	<input type="hidden" name = "birthyear" value="${data.birthyear}"/>
            <input type="submit" value="정보수정" class="button" />
        </form>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        /* CSS 스타일 추가 */
        body {
            background-color: #f2f2f2; /* 연한 배경색 */
            color: #333; /* 어두운 글자색 */
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff; /* 흰색 배경 */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        }

        p {
            margin-bottom: 20px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc; /* 연한 테두리 */
            background-color: #f8f8f8; /* 매우 연한 입력 필드 배경색 */
            color: #555; /* 어두운 글자색 */
        }

        input[type="submit"] {
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            background-color: #c00;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease; /* 부드러운 호버 효과 */
        }

        input[type="submit"]:hover {
            background-color: #900;
        }
    </style>
</head>
<body>
    <h1>로그인</h1>
    <form method="POST" action="/login">
        <p>
            아이디 : <input type="text" name="loginid" placeholder="아이디" />
        </p>
        <p>
            비밀번호 : <input type="password" name="password" placeholder="비밀번호" />
        </p>
        <p>
            <input type="submit" value="로그인" />
        </p>
    </form>
</body>
</html>

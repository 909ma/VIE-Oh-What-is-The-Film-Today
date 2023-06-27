<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정보수정</title>
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

        .password-mismatch {
            color: red;
            font-style: italic;
        }

        .olmessage {
            margin-top: 10px;
            font-style: italic;
        }

        .olmessage-green {
            color: green;
        }

        .olmessage-red {
            color: red;
        }
    </style>
  
</head>
<body>
    <h1>정보수정</h1>
    <form method="POST">

        <p>
        	아이디 : <input type="text" name="loginid_update" value="${data.myloginid}">
            닉네임 : <input type="text" name="nickname_update" value="${data.oldnickname}" id="nickname" placeholder="닉네임" />
            <button id="overlappedNickName" type="button">중복확인</button>
            <span id="nicknameMessage" class="olmessage"></span>
        </p>
        
        <p>
            생년월일 : <input type="number" name="birthyear_update" value="${data.oldbirthyear}" id="birthyear" placeholder="6자리로 입력하세요 ex)980911" />
        </p>
        <p>
            <input type="submit" value="수정" />
        </p>
    </form>
</body>
</html>

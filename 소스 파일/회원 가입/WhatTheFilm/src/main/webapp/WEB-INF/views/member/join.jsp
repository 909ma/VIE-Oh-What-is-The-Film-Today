<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            document.getElementById("overlappedID").addEventListener("click", function() {
                var loginId = document.getElementById("loginId").value;

                // AJAX 요청
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = xhr.responseText;
                            var idMessage = document.getElementById("idMessage");
                            if (response === "true") {
                                idMessage.textContent = "사용할 수 있는 아이디입니다.";
                                idMessage.classList.remove("olmessage-red");
                                idMessage.classList.add("olmessage-green");
                            } else {
                                idMessage.textContent = "이미 사용 중인 아이디입니다.";
                                idMessage.classList.remove("olmessage-green");
                                idMessage.classList.add("olmessage-red");
                            }
                        } else {
                            console.error("AJAX request failed.");
                        }
                    }
                };

                xhr.open("POST", "/checkDuplicateId", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.send("loginId=" + loginId);
            });

            document.getElementById("overlappedNickName").addEventListener("click", function() {
                var nickname = document.getElementById("nickname").value;

                // AJAX 요청
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var response = xhr.responseText;
                            var nicknameMessage = document.getElementById("nicknameMessage");
                            if (response === "true") {
                                nicknameMessage.textContent = "사용할 수 있는 닉네임입니다.";
                                nicknameMessage.classList.remove("olmessage-red");
                                nicknameMessage.classList.add("olmessage-green");
                            } else {
                                nicknameMessage.textContent = "이미 사용 중인 닉네임입니다.";
                                nicknameMessage.classList.remove("olmessage-green");
                                nicknameMessage.classList.add("olmessage-red");
                            }
                        } else {
                            console.error("AJAX request failed.");
                        }
                    }
                };

                xhr.open("POST", "/checkDuplicateNickname", true);
                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhr.send("nickname=" + nickname);
            });
        });

        function validateForm() {
            var loginId = document.getElementById("loginId").value;
            var password = document.getElementsByName("password")[0].value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var nickname = document.getElementById("nickname").value;
            var birthyear = document.getElementById("birthyear").value;

            if (loginId === "" || password === "" || confirmPassword === "" || nickname === "" || birthyear === "") {
                // 경고창 표시
                alert("입력 필드를 모두 채워주세요.");
                return false; // 폼 제출 중지
            }
            if (birthyear.length !== 4) {
                // 생년월일을 4자리로 입력하지 않은 경우
                alert("생년월일을 4자리로 입력해주세요.");
                return false; // 폼 제출 중지
            }

            if (password !== confirmPassword) {
                // 비밀번호 불일치 경고창 표시
                var passwordMatchMessage = document.getElementById("passwordMatchMessage");
                passwordMatchMessage.textContent = "비밀번호가 일치하지 않습니다.";
                passwordMatchMessage.classList.add("password-mismatch");
                return false; // 폼 제출 중지
            }

            return true; // 폼 제출 진행
        }

        function handlePasswordChange() {
            var passwordMatchMessage = document.getElementById("passwordMatchMessage");
            passwordMatchMessage.textContent = "";
            passwordMatchMessage.classList.remove("password-mismatch");
        }

        function handleConfirmPasswordChange() {
            var passwordMatchMessage = document.getElementById("passwordMatchMessage");
            passwordMatchMessage.textContent = "";
            passwordMatchMessage.classList.remove("password-mismatch");
        }
    </script>
</head>
<body>
    <h1>회원가입</h1>
    <form method="POST" action="/register" onsubmit="return validateForm()">
        <p>
            아이디 : <input type="text" name="loginid" id="loginId" placeholder="아이디" />
            <button id="overlappedID" type="button">중복확인</button>
            <span id="idMessage" class="olmessage"></span>
        </p>
        <p>
            비밀번호 : <input type="password" name="password" placeholder="비밀번호" oninput="handlePasswordChange()" />
        </p>
        <p>
            비밀번호 확인 : <input type="password" name="confirmpassword" id="confirmPassword" placeholder="비밀번호 확인" oninput="handleConfirmPasswordChange()" />
            <span id="passwordMatchMessage" class="olmessage"></span>
        </p>
         <p>성별
            <label><input type="radio" name="gender" value="남성"> 남성</label>
            <label><input type="radio" name="gender" value="여성"> 여성</label>
        </p>
        <p>
            닉네임 : <input type="text" name="nickname" id="nickname" placeholder="닉네임" />
            <button id="overlappedNickName" type="button">중복확인</button>
            <span id="nicknameMessage" class="olmessage"></span>
        </p>
        
        <p>
            생년월일 : <input type="text" name="birthyear" id="birthyear" placeholder="4자리로 입력하세요 ex)1998" />
        </p>
        <p>
            <input type="submit" value="회원가입" />
        </p>
    </form>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <!-- 필요한 CSS 스타일 시트를 추가해주세요 -->
</head>
<body>
    <h1>회원정보 비밀번호 변경</h1>
    <form method="POST" action="/pwedit" onsubmit="return validateForm()">
        <p>
            현재 비밀번호 : <input type="password" name="currentPassword" placeholder="현재 비밀번호" />
        </p>
        <p>
            새로운 비밀번호 : <input type="password" name="newPassword" placeholder="새로운 비밀번호" oninput="handlePasswordChange()" />
        </p>
        <p>
            비밀번호 확인 : <input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호 확인" oninput="handleConfirmPasswordChange()" />
            <span id="passwordMatchMessage" class="olmessage"></span>
        </p>
        <p>
            <input type="submit" value="수정 완료" />
        </p>
    </form>

    <script>
        // JavaScript 코드를 추가해주세요
        // 필요한 유효성 검사 등의 기능을 구현할 수 있습니다
        function validateForm() {
            var currentPassword = document.getElementsByName("currentPassword")[0].value;
            var newPassword = document.getElementsByName("newPassword")[0].value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var nickname = document.getElementById("nickname").value;

            if (currentPassword === "" || newPassword === "" || confirmPassword === "" || nickname === "") {
                // 경고창 표시
                alert("입력 필드를 모두 채워주세요.");
                return false; // 폼 제출 중지
            }

            if (newPassword !== confirmPassword) {
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
</body>
</html>

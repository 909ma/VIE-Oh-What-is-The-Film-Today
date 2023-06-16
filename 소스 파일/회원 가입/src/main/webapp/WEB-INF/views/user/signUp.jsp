<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원가입</title>
    <style>
      /* CSS 스타일 추가 */
      /* ... 이전 스타일 코드 ... */

      .password-mismatch {
        color: red;
        font-style: italic;
      }
    </style>
    <script>
      function validateForm() {
        var password = document.getElementsByName("Password")[0].value;
        var confirmPassword = document.getElementById("confirmPassword").value;
        var passwordMessage = document.getElementById("passwordMessage");

        if (password !== confirmPassword) {
          passwordMessage.textContent = "비밀번호가 일치하지 않습니다.";
          return false; // 폼 제출 중지
        } else {
          passwordMessage.textContent = ""; // 메시지 초기화
        }

        return true; // 폼 제출 진행
      }
    </script>
  </head>
  <body>
    <h1>회원가입</h1>
    <form method="POST" action="/register" onsubmit="return validateForm()">
      <p>
        아이디 :
        <input type="text" name="LoginID" id="loginId" placeholder="아이디" />
      </p>
      <button id="overlappedID" type="button">중복확인</button><br />
      <span id="idMessage" class="olmessaget"></span>
      <p>
        비밀번호 :
        <input type="password" name="Password" placeholder="비밀번호" />
      </p>
      <p>
        비밀번호 확인 :
        <input
          type="password"
          name="ConfirmPassword"
          id="confirmPassword"
          placeholder="비밀번호 확인"
        />
      </p>
      <span id="passwordMessage" class="password-mismatch"></span>
      <span id="passwordMatchMessage"></span>
      <p>닉네임 : <input type="text" name="Nickname" id="nickname" /></p>
      <button id="overlappedNickName" type="button">중복확인</button><br />
      <span id="nicknameMessage" class="olmessaget2"></span>
      <p>
        성별
        <label><input type="radio" name="Gender" value="남성" /> 남성</label>
        <label><input type="radio" name="Gender" value="여성" /> 여성</label>
      </p>
      <p>
        태어난 연도 :
        <input
          type="text"
          name="BirthYear"
          placeholder="4자리로 입력하세요 EX)1998"
        />
      </p>
      <input type="hidden" name="action" value="register" />
      <p><input type="submit" value="회원가입" /></p>
    </form>
  </body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>로그아웃바 테스트</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
	<style>
	#logout-bar {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 30px;
	    background-color: #4c87c6; /* 예시로 파란색 사용, 원하는 색상으로 변경해주세요 */
	    color: #ffffff; /* 텍스트 색상을 흰색으로 지정, 원하는 색상으로 변경해주세요 */
	    font-size: 12px; /* 텍스트 크기 조정, 원하는 크기로 변경해주세요 */
	    font-weight: bold; /* 텍스트 굵기 조정, 원하는 굵기로 변경해주세요 */
	    padding: 5px; /* 위 아래 여백을 조정, 원하는 여백으로 변경해주세요 */
	    box-sizing: border-box;
	}
	</style>
</head>
<body>
	<%@ include file="../header.jsp"%>
	<main>
    	<div class="container">
			<div class="topnav">
        		<a href="/board">메인 화면</a>
        		<a href="/Announcement">공지 사항</a>
        		<a href="/freeboard">자유게시판</a>
        		<a href="/recommend">영화 추천</a>
        		<a href="/dailyMovie">상영작 통계 조회</a>
        		<a href="/HowMuchDailyMovie">개봉작 통계 조회</a>
        		<a class="active" href="/SearchMovie">영화 찾기</a>
      		</div>
    	</div>
    	
    <!-- 로그인 바의 일부 -->
	<div id="logout-bar">
    	<!-- 로그인 정보 표시 -->
    	<span id="username">사용자명</span>
    	<!-- 로그아웃까지 남은 시간 표시 -->
    	<span id="logout-timer"></span>
	</div>

  </main>
  <%@ include file="../footer.jsp"%>
</body>
<!-- 자바스크립트 -->
<script>
    // 로그아웃 시간(밀리초)
    var logoutTime = new Date().getTime() + 20 * 60 * 1000;

    // 매 초마다 시간 갱신
    var timer = setInterval(function() {
        // 현재 시간
        var now = new Date().getTime();

        // 남은 시간 계산
        var distance = logoutTime - now;

        // 분과 초 계산
        var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        // 로그아웃까지 남은 시간 표시
        document.getElementById("logout-timer").innerHTML = minutes + "분 " + seconds + "초";

        // 시간이 초과되면 로그아웃
        if (distance < 0) {
            clearInterval(timer);
            // 로그아웃 처리
            window.location.href = "/logout";
        }
    }, 1000);
</script>

</html>

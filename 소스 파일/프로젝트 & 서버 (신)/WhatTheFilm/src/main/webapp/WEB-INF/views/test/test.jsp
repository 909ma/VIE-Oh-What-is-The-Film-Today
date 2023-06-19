<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>DailyMovie 테이블</title>
  <style>
    table {
      border-collapse: collapse;
      width: 100%;
    }

    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
    }
  </style>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
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
    <%
      // 데이터베이스 연결 설정
      String url = "jdbc:mysql://localhost:3306/myproject"; // 데이터베이스 URL과 이름으로 수정
      String username = "root";
      String password = "1234";

      try {
        // 드라이버 로드
        Class.forName("com.mysql.jdbc.Driver");

        // 데이터베이스 연결
        Connection connection = DriverManager.getConnection(url, username, password);

        // SQL 쿼리 실행
        String query = "SELECT number, movieNm, MAX(openDt) AS maxOpenDt, MAX(salesAcc) AS maxSalesAcc, MAX(audiAcc) AS maxAudiAcc FROM dailymovie GROUP BY movieNm, number ORDER BY movieNm;";
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);

        // 테이블 생성
        out.println("<table>");
        ResultSetMetaData metaData = resultSet.getMetaData();
        int columnCount = metaData.getColumnCount();

        // 테이블 헤더 생성
        out.println("<tr>");
        out.println("<th>영화코드</th>");
        out.println("<th>제목</th>");
        out.println("<th>개봉일</th>");
        out.println("<th>누적 매출</th>");
        out.println("<th>누적 관객</th>");
        out.println("</tr>");

        // 테이블 내용 생성
        while (resultSet.next()) {
          String movieNumber = resultSet.getString("number");  // 영화 번호 가져오기
          String movieTitle = resultSet.getString("movieNm");  // 영화 제목 가져오기
          out.println("<tr>");
          out.println("<td>" + movieNumber + "</td>");
          out.println("<td><a href='movieDetail?number=" + movieNumber + "'>" + movieTitle + "</a></td>");  // 영화 제목에 링크 추가
          out.println("<td>" + resultSet.getString("maxOpenDt") + "</td>");
          out.println("<td>" + resultSet.getString("maxSalesAcc") + "</td>");
          out.println("<td>" + resultSet.getString("maxAudiAcc") + "</td>");
          out.println("</tr>");
        }
        out.println("</table>");

        // 연결 및 리소스 해제
        resultSet.close();
        statement.close();
        connection.close();
      } catch (Exception e) {
        e.printStackTrace();
      }
    %>
  </main>
  <%@ include file="../footer.jsp"%>
</body>
</html>

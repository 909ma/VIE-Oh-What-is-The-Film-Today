<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Data</title>
</head>
<body>
<h1>전날 상영한 영화 데이터</h1>

<%
// MySQL 데이터베이스 연결 정보
String url = "jdbc:mysql://localhost:3306/myproject";
String username = "root";
String password = "1234";

try {
    // JDBC 드라이버 로드
    Class.forName("com.mysql.cj.jdbc.Driver");

    // 데이터베이스 연결
    Connection conn = DriverManager.getConnection(url, username, password);

    // SQL 쿼리 작성
    String query = "SELECT * FROM dailymovie WHERE targetDt = ?";

    // 전날 날짜 계산
    java.util.Date today = new java.util.Date();
    java.util.Calendar cal = java.util.Calendar.getInstance();
    cal.setTime(today);
    cal.add(java.util.Calendar.DAY_OF_MONTH, -1);
    java.util.Date yesterday = cal.getTime();

    // 날짜 형식 변환
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    String targetDate = sdf.format(yesterday);

    // PreparedStatement 생성
    PreparedStatement pstmt = conn.prepareStatement(query);
    pstmt.setString(1, targetDate);
    out.print("전날 날짜: " + targetDate + "<br>"); // 전날 날짜 출력

    // 쿼리 실행
    ResultSet rs = pstmt.executeQuery();

    // 결과 출력
    while (rs.next()) {
        String movieNm = rs.getString("movieNm");
        int rank = rs.getInt("rank");

        out.println("영화 이름: " + movieNm + "<br>");
        out.println("순위: " + rank + "<br><br>");
    }

    // 자원 해제
    rs.close();
    pstmt.close();
    conn.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

</body>
</html>

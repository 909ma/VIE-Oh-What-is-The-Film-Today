<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.util.stream.Collectors" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Posters</title>

<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
function searchMovie(movieTitle, rank) {
    var apiKey = "e2a56aa6721d47327a92acc02bfbddf3"; // 본인의 API 키로 대체해야 합니다.
    var encodedTitle = encodeURIComponent(movieTitle);
    var apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + encodedTitle;

    $.ajax({
        url: apiUrl,
        type: "GET",
        success: function(response) {
            var results = response.results;
            if (results.length > 0) {
                var movie = results[0];
                var posterPath = movie.poster_path;
                var posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath;
                $("#posterImage" + rank).attr("src", posterUrl); // 포스터 이미지 업데이트
            } else {
                $("#posterImage" + rank).attr("src", ""); // 검색 결과 없을 경우 이미지 초기화
            }
        },
        error: function() {
            $("#posterImage" + rank).attr("src", ""); // 에러 발생 시 이미지 초기화
        }
    });
}
</script>
</head>
<body>
<h1>영화 포스터</h1>

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
    String query = "SELECT * FROM dailymovie WHERE targetDt = ? ORDER BY `rank`";

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

    // 쿼리 실행
    ResultSet rs = pstmt.executeQuery();

    // 결과 출력
    while (rs.next()) {
        String movieNm = rs.getString("movieNm");
        int rank = rs.getInt("rank");

        out.println("영화 이름: " + movieNm + "<br>");
        out.println("순위: " + rank + "<br>");

        // 영화 포스터 이미지 출력
        out.println("<img id='posterImage" + rank + "' src='' alt='포스터'><br>");

        // searchMovie 함수 호출
        out.println("<script>");
        out.println("searchMovie('" + movieNm + "', " + rank + ");");
        out.println("</script>");

        out.println("<br>");
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

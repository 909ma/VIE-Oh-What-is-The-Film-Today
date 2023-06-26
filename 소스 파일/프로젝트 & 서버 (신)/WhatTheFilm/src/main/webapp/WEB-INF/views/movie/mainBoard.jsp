<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.util.stream.Collectors"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VIE: 아 오늘 영화 뭐 보지?</title>
<!--fontawesome추가  -->
<script src="https://kit.fontawesome.com/8dbcba5bdb.js" crossorigin="anonymous"></script>

<!-- 웹 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/swiper.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout_base.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery.smooth-scroll.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/rollmain.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/swiper.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.easing.js"></script>

<style>
/* 포스터 영역 */
.poster {
	display: flex;
	justify-content: left;
	align-items: center;
	overflow: auto;
}
</style>

<script>
	function searchMovie(movieTitle, rank) {
		var apiKey = "e2a56aa6721d47327a92acc02bfbddf3"; // 본인의 API 키로 대체해야 합니다.
		var movieNmEncoded = encodeURIComponent(movieTitle);

		// 1. 영화 정보 조회
		var kobisUrl = "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json?key=f5eef3421c602c6cb7ea224104795888&movieNm="
				+ movieNmEncoded;
		$.ajax({
			url : kobisUrl,
			type : "GET",
			success : function(response) {
				var movies = response.movieListResult.movieList;
				if (movies.length > 0) {
					var movie = findMovieByKoreanTitle(movies, movieTitle);
					if (movie) {
						var movieNmEn = movie.movieNmEn;
						// 2. 영화 정보로 검색
						searchMovieByEnglishTitle(movieNmEn, rank, movieTitle);
						//console.log(rank + " : " + movieNmEn + "(eng)"); // 검색 방식 로그 출력
					} else {
						searchMovieByKoreanTitle(movieTitle, rank);
						//console.log(rank + " : " + movieTitle); // 검색 방식 로그 출력
					}
				} else {
					searchMovieByKoreanTitle(movieTitle, rank);
					//console.log(rank + " : " + movieTitle); // 검색 방식 로그 출력
				}
			},
			error : function() {
				searchMovieByKoreanTitle(movieTitle, rank);
				//console.log(rank + " : " + movieTitle); // 검색 방식 로그 출력
			}
		});
	}

	function findMovieByKoreanTitle(movies, movieTitle) {
		for (var i = 0; i < movies.length; i++) {
			var movie = movies[i];
			var title = movie.movieNm;
			if (title === movieTitle) {
				return movie;
			}
		}
		return null;
	}

	function searchMovieByEnglishTitle(movieTitle, rank, movieNm) {
		var apiKey = "e2a56aa6721d47327a92acc02bfbddf3"; // 본인의 API 키로 대체해야 합니다.
		var encodedTitle = encodeURIComponent(movieTitle);
		var apiUrl = "https://api.themoviedb.org/3/search/movie?api_key="
				+ apiKey + "&query=" + encodedTitle;

		$.ajax({
			url : apiUrl,
			type : "GET",
			success : function(response) {
				var results = response.results;
				if (results.length > 0) {
					var movie = results[0];
					var posterPath = movie.poster_path;
					if (posterPath) {
						var posterUrl = "https://image.tmdb.org/t/p/w500"
								+ posterPath;
						$("#posterImage" + rank).attr("src", posterUrl); // 포스터 이미지 업데이트
					} else {
						searchMovieByKoreanTitle(movieNm, rank);
					}
				} else {
					searchMovieByKoreanTitle(movieNm, rank);
				}
			},
			error : function() {
				searchMovieByKoreanTitle(movieNm, rank);
			}
		});
	}

	// 3. 한국어로 다시 검색
	function searchMovieByKoreanTitle(movieTitle, rank) {
		var apiKey = "e2a56aa6721d47327a92acc02bfbddf3"; // 본인의 API 키로 대체해야 합니다.
		var encodedTitle = encodeURIComponent(movieTitle);
		var apiUrl = "https://api.themoviedb.org/3/search/movie?api_key="
				+ apiKey + "&query=" + encodedTitle;

		$
				.ajax({
					url : apiUrl,
					type : "GET",
					success : function(response) {
						var results = response.results;
						if (results.length > 0) {
							var movie = results[0];
							var posterPath = movie.poster_path;
							var posterUrl = "https://image.tmdb.org/t/p/w500"
									+ posterPath;
							$("#posterImage" + rank).attr("src", posterUrl); // 포스터 이미지 업데이트
						} else {
							$("#posterImage" + rank)
									.attr("src",
											"${pageContext.request.contextPath}/resources/image/errorPoster.png"); // 검색 결과 없을 경우 이미지 초기화
						}
					},
					error : function() {
						$("#posterImage" + rank).attr("src", ""); // 에러 발생 시 이미지 초기화
					}
				});
	}
</script>
</head>
<body>
	<%@ include file="../logoutBar.jsp"%>
	<%@ include file="../header.jsp"%>



	<main>
		<h1>Top10 영화</h1>

		<!--  시작  -->
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

			out.print("<div class=\"poster\">");
			// 결과 출력
			while (rs.next()) {
				String movieNm = rs.getString("movieNm");
				int rank = rs.getInt("rank");

				// 영화 포스터 이미지 출력
				out.println("<a href='movieDetail?number=" + rs.getInt("number") + "'><img id='posterImage" + rank
				+ "' src='' alt='포스터 없음' width='500'></a>");

				// 영화 검색 함수 호출
				out.println("<script>searchMovie('" + movieNm + "', " + rank + ");</script>");
				//         out.println("영화 이름: " + movieNm + "<br>");
				//         out.println("순위: " + rank + "<br>");
			}
			out.print("</div>");

			// 자원 해제
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<!--  끝  -->
	</main>
	<%@ include file="../footer.jsp"%>
</body>
</html>

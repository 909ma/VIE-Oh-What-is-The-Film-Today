<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.util.stream.Collectors"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="org.json.JSONObject"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0  minimum-scale=1, maximum-scale=1" />
<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<title>VIE: BIG 3</title>

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
p {
	text-align: center;
}

table {
	width: auto;
	max-width: 1024px;
	border-collapse: collapse;
	margin: auto;
}

img {
	max-width: 100%;
}

th, td {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
}

th {
	background-color: #f2f2f2;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #e6e6e6;
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


		<!--  끝  -->

		<table border="1">
			<th>1위 영화</th>
			<th>2위 영화</th>
			<th>3위 영화</th>
			<!-- 첫 번째 줄 시작 -->
			<tr>
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
					String query = "SELECT * FROM dailymovie WHERE targetDt = ? ORDER BY `rank` LIMIT 3";

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
						out.print("<th>");
						out.println("<a href='movieDetail?number=" + rs.getInt("number") + "'><img id='posterImage" + rank
						+ "' src='' alt='포스터 없음'></a>");
						out.print("</th>");

						// 영화 검색 함수 호출
						out.println("<script>searchMovie('" + movieNm + "', " + rank + ");</script>");
					}
					out.print("</div>");
				%>
			</tr>
			<!-- 첫 번째 줄 끝 -->
			<!-- 두 번째 줄 시작 -->
			<tr>

				<%
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String movieNm = rs.getString("movieNm");
					out.print("<th>");
					out.print(movieNm);
					out.println("</th>");

				}
				%>

			</tr>
			<!-- 두 번째 줄 끝 -->
			<!-- 세 번째 줄 시작 -->
			<tr>
				<%
				// JDBC 관련 설정
				String dbUrl = "jdbc:mysql://localhost/myproject?useUnicode=true&characterEncoding=utf8";

				Connection conn1 = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn1 = DriverManager.getConnection(dbUrl, username, password);

					String sql = "SELECT * FROM myproject.dailymovie WHERE targetDt = ? ORDER BY `rank` LIMIT 3";

					// PreparedStatement 생성
					PreparedStatement pstmt1 = conn1.prepareStatement(sql);
					pstmt1.setString(1, targetDate);

					rs1 = pstmt1.executeQuery();

					while (rs1.next()) {
						String movieNm = rs1.getString("movieNm");
						int number = rs1.getInt("number"); // 영화의 고유 식별자

						// 영화 평점 조회
						String api_key = "e2a56aa6721d47327a92acc02bfbddf3";

						// 영화명을 영문으로 검색하기 위해 API로부터 영문 제목 가져오기
						String movieCdUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd="
						+ number;

						HttpURLConnection movieCdConnection = null;
						BufferedReader movieCdReader = null;
						try {
					URL movieCdApiUrl = new URL(movieCdUrl);
					movieCdConnection = (HttpURLConnection) movieCdApiUrl.openConnection();
					movieCdConnection.setRequestMethod("GET");

					int movieCdResponseCode = movieCdConnection.getResponseCode();
					if (movieCdResponseCode == HttpURLConnection.HTTP_OK) {
						movieCdReader = new BufferedReader(new InputStreamReader(movieCdConnection.getInputStream()));
						String movieCdLine;
						StringBuilder movieCdResponse = new StringBuilder();
						while ((movieCdLine = movieCdReader.readLine()) != null) {
							movieCdResponse.append(movieCdLine);
						}

						JSONObject movieCdData = new JSONObject(movieCdResponse.toString());
						JSONObject movieInfoResult = movieCdData.getJSONObject("movieInfoResult");
						JSONObject movieInfo = movieInfoResult.getJSONObject("movieInfo");
						String movieNmEn = movieInfo.getString("movieNmEn");

						// 영화 평점 조회
						String movieName = movieNmEn.replace(" ", "%20");
						String movieUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + api_key + "&query="
								+ movieName;

						HttpURLConnection movieConnection = null;
						BufferedReader movieReader = null;
						try {
							URL movieApiUrl = new URL(movieUrl);
							movieConnection = (HttpURLConnection) movieApiUrl.openConnection();
							movieConnection.setRequestMethod("GET");

							int movieResponseCode = movieConnection.getResponseCode();
							if (movieResponseCode == HttpURLConnection.HTTP_OK) {
								movieReader = new BufferedReader(new InputStreamReader(movieConnection.getInputStream()));
								String movieLine;
								StringBuilder movieResponse = new StringBuilder();
								while ((movieLine = movieReader.readLine()) != null) {
									movieResponse.append(movieLine);
								}

								JSONObject searchResults = new JSONObject(movieResponse.toString());
								int totalResults = searchResults.getInt("total_results");
								if (totalResults > 0) {
									JSONArray movies = searchResults.getJSONArray("results");
									JSONObject movie = movies.getJSONObject(0);
									int movieId = movie.getInt("id");

									String movieDetailUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key="
											+ api_key;

									HttpURLConnection detailConnection = null;
									BufferedReader detailReader = null;
									try {
										URL detailApiUrl = new URL(movieDetailUrl);
										detailConnection = (HttpURLConnection) detailApiUrl.openConnection();
										detailConnection.setRequestMethod("GET");

										int detailResponseCode = detailConnection.getResponseCode();
										if (detailResponseCode == HttpURLConnection.HTTP_OK) {
											detailReader = new BufferedReader(
													new InputStreamReader(detailConnection.getInputStream()));
											String detailLine;
											StringBuilder detailResponse = new StringBuilder();
											while ((detailLine = detailReader.readLine()) != null) {
												detailResponse.append(detailLine);
											}

											JSONObject movieData = new JSONObject(detailResponse.toString());
											double rating = movieData.getDouble("vote_average");
											String formattedRating = String.format("%.1f", rating);
				%>
				<td>평점 : <%=formattedRating%></td>
				<%
				} else {
				// 영화 상세 정보 요청 실패
				out.println("영화 상세 정보 요청에 실패하였습니다.");
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (detailReader != null) {
				detailReader.close();
				}
				if (detailConnection != null) {
				detailConnection.disconnect();
				}
				}
				} else {
				// 영화 검색 결과 없음
				out.println("'" + movieNm + "'에 대한 검색 결과가 없습니다.");
				}
				} else {
				// 영화 검색 요청 실패
				out.println("영화 검색 요청에 실패하였습니다.");
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (movieReader != null) {
				movieReader.close();
				}
				if (movieConnection != null) {
				movieConnection.disconnect();
				}
				}
				} else {
				// 영화 코드 검색 요청 실패
				out.println("영화 코드 검색 요청에 실패하였습니다.");
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (movieCdReader != null) {
				movieCdReader.close();
				}
				if (movieCdConnection != null) {
				movieCdConnection.disconnect();
				}
				}
				}
				} catch (Exception e) {
				e.printStackTrace();
				} finally {
				if (rs1 != null) {
				try {
				rs1.close();
				} catch (SQLException e) {
				e.printStackTrace();
				}
				}
				if (stmt1 != null) {
				try {
				stmt1.close();
				} catch (SQLException e) {
				e.printStackTrace();
				}
				}
				if (conn1 != null) {
				try {
				conn1.close();
				} catch (SQLException e) {
				e.printStackTrace();
				}
				}
				}
				%>

			</tr>
			<!-- 세 번째 줄 끝 -->
			<!-- 네 번째 줄 시작 -->
			<tr>
				<%
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String audiAcc = rs.getString("audiAcc");
					DecimalFormat df = new DecimalFormat("###,###,###");
					String formattedAudiAcc = df.format(Integer.parseInt(audiAcc));

					out.print("<td>총 관객수 : ");
					out.print(formattedAudiAcc);
					out.println("명</td>");
				}
				%>
			</tr>
			<!-- 네 번째 줄 끝 -->
			<!-- 다섯 번째 줄 시작 -->
			<tr>

				<%
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String inputDate = rs.getString("openDt");
					String audiAcc = rs.getString("audiAcc");

					SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
					Date startDate = sdf1.parse(inputDate);

					Calendar startCal = Calendar.getInstance();
					startCal.setTime(startDate);

					Calendar endCal = Calendar.getInstance();
					endCal.setTime(new Date()); // 현재 날짜로 설정
					endCal.add(Calendar.DAY_OF_MONTH, -1);

					int daysBetween = 0;
					while (startCal.compareTo(endCal) <= 0) {
						startCal.add(Calendar.DAY_OF_MONTH, 1);
						daysBetween++;
					}

					double power = Double.parseDouble(audiAcc) / (daysBetween * 333333) * 100;
					DecimalFormat df = new DecimalFormat("###,###,###.00");
					String formattedPower = df.format(power);

					out.print("<td>영화 흥행력 : ");
					out.print(formattedPower);
					out.println("</td>");

				}
				%>
			</tr>
			<!-- 다섯 번째 줄 끝 -->

			<%
			// 자원 해제
			rs.close();
			pstmt.close();
			conn.close();
			} catch (Exception e) {
			e.printStackTrace();
			}
			%>
		</table>
		<br>
		<p>
			※영화 흥행력 : 이 추세로 한 달 뒤면 천만 영화 달성하는 정도를 100이라고 했을 때 현재 영화들의 추세 <br>
	</main>
	<%@ include file="../footer.jsp"%>
</body>
</html>

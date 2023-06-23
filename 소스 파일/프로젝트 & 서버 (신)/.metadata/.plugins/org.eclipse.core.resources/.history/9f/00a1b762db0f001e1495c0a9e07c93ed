<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.BufferedReader, java.io.InputStreamReader, java.net.HttpURLConnection, java.net.URL" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONObject" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>영화 추천 리스트</h1>
    <form method="GET">
        <label for="audiacc">관객 수 기준:</label>
        <input type="number" id="audiacc" name="audiacc">
        <input type="submit" value="검색">
    </form>
    <table>
        <tr>
            <th>영화</th>
            <th>관객 수</th>
            <th>개봉일</th>
            <th>평점</th>
        </tr>
        <% 
            // JDBC 관련 설정
            String dbUrl = "jdbc:mysql://localhost/myproject?useUnicode=true&characterEncoding=utf8";
            String username = "root";
            String password = "1234";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, username, password);

                // 사용자 입력 값 받기
                String audiaccParam = request.getParameter("audiacc");
                int audiaccValue = 0; // 기본값

                // 사용자 입력 값이 있을 경우 정수로 변환
                if (audiaccParam != null && !audiaccParam.isEmpty()) {
                    audiaccValue = Integer.parseInt(audiaccParam);
                }

                String sql = "SELECT number, movieNm, MAX(audiacc) AS max_audiacc, openDt " +
                             "FROM myproject.dailymovie " +
                             "WHERE audiacc >= " + audiaccValue + " " +
                             "GROUP BY movieNm, openDt, number " +
                             "ORDER BY movieNm";
                stmt = conn.createStatement();
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int number = rs.getInt("number"); // 영화의 고유 식별자
                    String movieNm = rs.getString("movieNm");
                    int maxAudiacc = rs.getInt("max_audiacc");
                    String openDt = rs.getString("openDt");
                    
                    // 관객 수를 세 자리마다 쉼표로 구분하여 출력
                    String formattedAudiacc = String.format("%,d", maxAudiacc);
                    
                    // 영화 평점 조회
                    String api_key = "e2a56aa6721d47327a92acc02bfbddf3";
                    String movieName = movieNm.replace(" ", "%20");
                    String movieUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + api_key + "&query=" + movieName;

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

                                String movieDetailUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key=" + api_key;

                                HttpURLConnection detailConnection = null;
                                BufferedReader detailReader = null;
                                try {
                                    URL detailApiUrl = new URL(movieDetailUrl);
                                    detailConnection = (HttpURLConnection) detailApiUrl.openConnection();
                                    detailConnection.setRequestMethod("GET");

                                    int detailResponseCode = detailConnection.getResponseCode();
                                    if (detailResponseCode == HttpURLConnection.HTTP_OK) {
                                        detailReader = new BufferedReader(new InputStreamReader(detailConnection.getInputStream()));
                                        String detailLine;
                                        StringBuilder detailResponse = new StringBuilder();
                                        while ((detailLine = detailReader.readLine()) != null) {
                                            detailResponse.append(detailLine);
                                        }

                                        JSONObject movieData = new JSONObject(detailResponse.toString());
                                        double rating = movieData.getDouble("vote_average");
                                        String formattedRating = String.format("%.1f", rating);

                                        %>
                                        <tr>
                                            <td><a href="movieDetail?number=<%= number %>"><%= movieNm %></a></td>
                                            <td><%= formattedAudiacc %> 명</td>
                                            <td><%= openDt %></td>
                                            <td><%= formattedRating %></td>
                                        </tr>
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
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </table>
</body>
</html>

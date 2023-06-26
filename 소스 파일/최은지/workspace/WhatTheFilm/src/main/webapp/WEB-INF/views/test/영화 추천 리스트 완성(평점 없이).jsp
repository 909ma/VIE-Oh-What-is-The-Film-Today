<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
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
        </tr>
        <% 
            // JDBC 관련 설정
            String url = "jdbc:mysql://localhost/myproject?useUnicode=true&characterEncoding=utf8";
            String username = "root";
            String password = "1234";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

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

        %>
        <tr>
            <td><a href="movieDetail?number=<%= number %>"><%= movieNm %></a></td> <!-- 세부 정보 페이지로 이동하는 링크 -->
            <td><%= formattedAudiacc %> 명</td>
            <td><%= openDt %></td>
        </tr>
        <% 
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

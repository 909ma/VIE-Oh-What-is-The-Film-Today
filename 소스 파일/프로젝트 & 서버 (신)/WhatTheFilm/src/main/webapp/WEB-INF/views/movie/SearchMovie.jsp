<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.Connection,
java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="java.sql.ResultSetMetaData" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>개봉작 통계 조회</title>
<script src="https://d3js.org/d3.v7.min.js"></script>
<style>
/* 차트 스타일링 */
.bar {
	fill: #000000;
}

.bar:hover {
	fill: darkblue;
}

#chart {
	bottom: 20px;
	left: 50%;
	background-color: #ffffff;
}

#chart {
	width: 100%; /* 가로 길이를 100%로 설정 */
	
}

#dataBox{
	max-width: 1024px;
	text-align: center;
	margin: auto;
}

/*테이블 */
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
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
</head>
<body>
	<%@ include file="../header.jsp"%>
	
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
	
	<main>
	
	<div id="dataBox">
		<div id="chart-container">
			<svg id="chart"></svg>
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
	<script>
        // 초기 데이터 배열
        var originalData = [
            <%try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection connection = DriverManager.getConnection(url, username, password);
	Statement statement = connection.createStatement();
	String sql = "SELECT targetDt, SUM(audiCnt) AS totalAudiCnt FROM DailyMovie GROUP BY targetDt ORDER BY targetDt ASC";
	ResultSet resultSet = statement.executeQuery(sql);
	while (resultSet.next()) {
		int totalAudiCnt = resultSet.getInt("totalAudiCnt");
		int targetDt = resultSet.getInt("targetDt");%>
            {
                totalAudiCnt: <%=String.valueOf(totalAudiCnt)%>,
                targetDt: <%=String.valueOf(targetDt)%>
            },
            <%}
resultSet.close();
statement.close();
connection.close();
} catch (Exception e) {
e.printStackTrace();
}%>
        ];

        // 초기 데이터로 차트 생성
        var chartData = originalData;

        var margin = { top: 20, right: 20, bottom: 30, left: 40 };
        var width = 500 - margin.left - margin.right;
        var height = 300 - margin.top - margin.bottom;

        var svg = d3.select("#chart")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

        // 기존의 세로축 요소 제거
        svg.select(".y-axis").remove();

        var x = d3.scaleBand()
            .domain(chartData.map(function(d) { return d.targetDt; }))
            .range([0, width])
            .padding(0.1);

        var y = d3.scaleLinear()
            .domain([0, d3.max(chartData, function(d) { return d.totalAudiCnt; })])
            .range([height, 0]);

        svg.selectAll(".bar")
            .data(chartData)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.targetDt); })
            .attr("y", function(d) { return y(d.totalAudiCnt); })
            .attr("width", x.bandwidth())
            .attr("height", function(d) { return height - y(d.totalAudiCnt); });

        var xAxis = d3.axisBottom(x);

        var yAxis = d3.axisLeft(y);

        svg.append("g")
            .attr("class", "x-axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);

        svg.append("g")
            .attr("class", "y-axis")
            .call(yAxis);

        // 데이터 업데이트 함수
        function updateChart(data) {
            // 새로운 데이터로 차트 업데이트
            var bars = svg.selectAll(".bar")
                .data(data, function(d) { return d.targetDt; });

            bars.enter().append("rect")
                .attr("class", "bar")
                .merge(bars)
                .transition()
                .duration(500)
                .attr("x", function(d) { return x(d.targetDt); })
                .attr("y", function(d) { return y(d.totalAudiCnt); })
                .attr("width", x.bandwidth())
                .attr("height", function(d) { return height - y(d.totalAudiCnt); });

            bars.exit().remove();

            // 세로축 업데이트
            svg.select(".y-axis")
                .transition()
                .duration(500)
                .call(yAxis);
        }

        // 데이터 필터링 함수
        function filterData(minValue, maxValue) {
            var filteredData = originalData.filter(function(d) {
                return d.totalAudiCnt >= minValue && d.totalAudiCnt <= maxValue;
            });

            updateChart(filteredData);
        }

        // 초기 차트 표시
        updateChart(chartData);
	</script>
</body>
</html>


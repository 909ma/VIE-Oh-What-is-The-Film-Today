<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,
java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>개봉작 통계 조회</title>
<script src="https://d3js.org/d3.v7.min.js"></script>
<style>
/* 테이블 스타일링 */
table {
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 20px;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

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

#dataBox {
	max-width: 1024px;
	text-align: center;
	margin: auto;
}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commonStyles.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/naviStyles.css">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon.ico">
</head>
<body>
	<%@ include file="../logoutBar.jsp"%>
	<%@ include file="../header.jsp"%>
	<%@ include file="../navi.jsp"%>
	<main>

		<div id="dataBox">
			<label for="food-select">선택:</label> <select id="food-select" onchange="updateData()">
				<option value="">전체</option>
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					String url = "jdbc:mysql://localhost/myproject";
					String username = "root";
					String password = "1234";
					Connection connection = DriverManager.getConnection(url, username, password);
					Statement statement = connection.createStatement();
					String sql = "SELECT DISTINCT movieNm FROM HowMuchDailyMovie ORDER BY movieNm ASC";
					ResultSet resultSet = statement.executeQuery(sql);
					while (resultSet.next()) {
						String name = resultSet.getString("movieNm");
				%>
				<option value="<%=name%>"><%=name%></option>
				<%
				}
				resultSet.close();
				statement.close();
				connection.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</select> <br>

			<svg id="chart"></svg>
			<h4>국내 영화 시장 1년 지표</h4>
			<br>
			<table id="data-table">
				<tr>
					<th>당일 관객</th>
					<th>영화</th>
					<th>당일 매출</th>
					<th>날짜</th>
				</tr>
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					String url = "jdbc:mysql://localhost/myproject";
					String username = "root";
					String password = "1234";
					Connection connection = DriverManager.getConnection(url, username, password);
					Statement statement = connection.createStatement();
					String sql = "SELECT audiCnt, movieNm, FORMAT(salesAmt, 0) AS formattedAmt, DATE_FORMAT(targetDt, '%Y-%m-%d') AS formattedDt FROM HowMuchDailyMovie ORDER BY targetDt DESC";
					ResultSet resultSet = statement.executeQuery(sql);
					while (resultSet.next()) {
						int amount = resultSet.getInt("audiCnt");
						String name = resultSet.getString("movieNm");
						String formattedAmt = resultSet.getString("formattedAmt") + "원";
						String formattedDt = resultSet.getString("formattedDt");
				%>
				<tr class="data-row">
					<td><%=String.format("%,d",amount) + "명"%></td>
					<td><%=name%></td>
					<td><%=formattedAmt %></td>
					<td><%=formattedDt%></td>
				</tr>
				<%
				}
				resultSet.close();
				statement.close();
				connection.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
				%>
			</table>
		</div>
	</main>
	<%@ include file="../footer.jsp"%>

	<script>
              // 초기 데이터 배열
              var originalData = [
                  <%try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	String url = "jdbc:mysql://localhost/myproject";
	String username = "root";
	String password = "1234";
	Connection connection = DriverManager.getConnection(url, username, password);
	Statement statement = connection.createStatement();
	String sql = "SELECT audiCnt, movieNm, salesAmt, targetDt FROM HowMuchDailyMovie  ORDER BY targetDt ASC";
	ResultSet resultSet = statement.executeQuery(sql);
	while (resultSet.next()) {
		int amount = resultSet.getInt("audiCnt");
		String name = resultSet.getString("movieNm");
		String itemspec = resultSet.getString("salesAmt");
		int year = resultSet.getInt("targetDt");%>
                  {
                      amount: <%=String.valueOf(amount)%>,
                      name: "<%=name%>",
                      itemspec: "<%=itemspec%>",
                      year: <%=String.valueOf(year)%>
                  },
                  <%}
resultSet.close();
statement.close();
connection.close();
} catch (Exception e) {
e.printStackTrace();
}%>
			              ];

              // 초기 데이터로 테이블 생성
              var table = d3.select("#data-table");

              var rows = table.selectAll(".data-row")
                  .data(originalData)
                  .enter()
                  .append("tr")
                  .attr("class", "data-row");

              rows.append("td")
                  .text(function(d) { return d.amount; });

              rows.append("td")
                  .text(function(d) { return d.name; });

              rows.append("td")
                  .text(function(d) { return d.itemspec; });

              rows.append("td")
                  .text(function(d) { return d.year; });

           // 초기 데이터로 차트 생성
              var chartData = originalData;

              var margin = { top: 20, right: 20, bottom: 30, left: 40 };
              var width = 1024;
              var height = 300 - margin.top - margin.bottom;

              var svg = d3.select("#chart")
                  .attr("width", width + margin.left + margin.right)
                  .attr("height", height + margin.top + margin.bottom)
                  .append("g")
                  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


              // 기존의 세로축 요소 제거
              svg.select(".y-axis").remove();

              var x = d3.scaleBand()
                  .domain(chartData.map(function(d) { return d.year; }))
                  .range([0, width])
                  .padding(0.1);

              var y = d3.scaleLinear()
                  .domain([0, d3.max(chartData, function(d) { return d.amount; })])
                  .range([height, 0]);

              svg.selectAll(".bar")
                  .data(chartData)
                  .enter().append("rect")
                  .attr("class", "bar")
                  .attr("x", function(d) { return x(d.year); })
                  .attr("y", function(d) { return y(d.amount); })
                  .attr("width", x.bandwidth())
                  .attr("height", function(d) { return height - y(d.amount); });

              svg.append("g")
                  .attr("class", "x-axis")
                  .attr("transform", "translate(0," + height + ")")
                  .call(d3.axisBottom(x));

              svg.append("g")
                  .attr("class", "y-axis")
                  .call(d3.axisLeft(y));


              // 데이터 갱신 함수
              function updateData() {
                  var selectedFood = document.getElementById("food-select").value;

                  // 선택된 음식에 따라 테이블과 차트 데이터 필터링
                  if (selectedFood) {
                      var filteredData = originalData.filter(function(d) {
                          return d.name === selectedFood;
                      });

                      // 테이블 업데이트
                      var tableRows = table.selectAll(".data-row")
                          .data(filteredData, function(d) { return d.year; });

                      tableRows.exit().remove();

                      var newRows = tableRows.enter()
                          .append("tr")
                          .attr("class", "data-row");

                      newRows.append("td");
                      newRows.append("td");
                      newRows.append("td");
                      newRows.append("td");

                      tableRows = newRows.merge(tableRows);

                      tableRows.select("td:nth-child(1)")
                          .text(function(d) { return d.amount; });

                      tableRows.select("td:nth-child(2)")
                          .text(function(d) { return d.name; });

                      tableRows.select("td:nth-child(3)")
                          .text(function(d) { return d.itemspec; });

                      tableRows.select("td:nth-child(4)")
                          .text(function(d) { return d.year; });

                      // 차트 업데이트
                      svg.select(".y-axis").remove(); // 기존의 y축 요소 제거
                      svg.select(".x-axis").remove(); // 기존의 x축 요소 제거
				        x.domain(filteredData.map(function(d) { return d.year; })); // x 축 도메인 업데이트
				        y.domain([0, d3.max(filteredData, function(d) { return d.amount; })]); // y 축 도메인 업데이트

                      var chartBars = svg.selectAll(".bar")
                          .data(filteredData, function(d) { return d.year; });

                      chartBars.exit().remove();

                      chartBars.enter()
                          .append("rect")
                          .attr("class", "bar")
                          .attr("x", function(d) { return x(d.year); })
                          .attr("y", function(d) { return y(d.amount); })
                          .attr("width", x.bandwidth())
                          .attr("height", function(d) { return height - y(d.amount); })
                          .merge(chartBars)
                          .transition()
                          .duration(500)
                          .attr("x", function(d) { return x(d.year); })
                          .attr("y", function(d) { return y(d.amount); })
                          .attr("width", x.bandwidth())
                          .attr("height", function(d) { return height - y(d.amount); });

                      svg.append("g")
                          .attr("class", "y-axis")
                          .call(d3.axisLeft(y));
                  } else {
                      // 선택된 음식이 없을 때 모든 데이터 표시
                      var tableRows = table.selectAll(".data-row")
                          .data(originalData, function(d) { return d.year; });

                      tableRows.exit().remove();

                      var newRows = tableRows.enter()
                          .append("tr")
                          .attr("class", "data-row");

                      newRows.append("td");
                      newRows.append("td");
                      newRows.append("td");
                      newRows.append("td");

                      tableRows = newRows.merge(tableRows);

                      tableRows.select("td:nth-child(1)")
                          .text(function(d) { return d.amount; });

                      tableRows.select("td:nth-child(2)")
                          .text(function(d) { return d.name; });

                      tableRows.select("td:nth-child(3)")
                          .text(function(d) { return d.itemspec; });

                      tableRows.select("td:nth-child(4)")
                          .text(function(d) { return d.year; });

                      var chartBars = svg.selectAll(".bar")
                          .data(originalData, function(d) { return d.year; });

                      chartBars.exit().remove();
                      x.domain(originalData.map(function(d) { return d.year; })); // x 축 도메인 업데이트
                      y.domain([0, d3.max(originalData, function(d) { return d.amount; })]); // y 축 도메인 업데이트

                      chartBars.enter()
                          .append("rect")
                          .attr("class", "bar")
                          .attr("x", function(d) { return x(d.year); })
                          .attr("y", function(d) { return y(d.amount); })
                          .attr("width", x.bandwidth())
                          .attr("height", function(d) { return height - y(d.amount); })
                          .merge(chartBars)
                          .transition()
                          .duration(500)
                          .attr("x", function(d) { return x(d.year); })
                          .attr("y", function(d) { return y(d.amount); })
                          .attr("width", x.bandwidth())
                          .attr("height", function(d) { return height - y(d.amount); });
                  }
              }
    </script>
</body>
</html>

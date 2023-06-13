<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,
java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MySQL 데이터 표시 및 D3 차트</title>
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
	position: fixed;
	bottom: 20px;
	left: 50%;
	transform: translateX(-50%);
	background-color: #ffffff;
}
</style>
</head>
<body>
	<label for="food-select">음식 선택:</label>
	<select id="food-select" onchange="updateData()">
		<option value="">전체</option>
		<% try { 
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			String url = "jdbc:mysql://localhost/myproject"; 
			String username = "root"; 
			String password = "1234"; 
			Connection connection = DriverManager.getConnection(url, username, password); 
			Statement statement = connection.createStatement();
			String sql = "SELECT DISTINCT name FROM practice";
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				String name = resultSet.getString("name");
		%>
		<option value="<%=name%>"><%=name%></option>
		<%  }
			resultSet.close();
			statement.close();
			connection.close();
			} catch
      (Exception e) { e.printStackTrace(); } %>
	</select>

	<table id="data-table">
		<tr>
			<th>Amount</th>
			<th>Name</th>
			<th>Item Spec</th>
			<th>Year</th>
		</tr>
		<% try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost/myproject";
			String username = "root";
			String password = "1234";
			Connection connection = DriverManager.getConnection(url, username, password);
			Statement statement = connection.createStatement();
			String sql = "SELECT amount, name, itemspec, year FROM practice";
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				int amount = resultSet.getInt("amount");
				String name = resultSet.getString("name");
      			String itemspec = resultSet.getString("itemspec");
      			int year = resultSet.getInt("year");
      	%>
		<tr class="data-row">
			<td><%=String.valueOf(amount)%></td>
			<td><%=name%></td>
			<td><%=itemspec%></td>
			<td><%=String.valueOf(year)%></td>
		</tr>
		<%  }
			resultSet.close();
			statement.close();
			connection.close();
			} catch
      (Exception e) { e.printStackTrace(); } %>
	</table>

	<svg id="chart"></svg>

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
      	String sql = "SELECT amount, name, itemspec, year FROM practice";
      	ResultSet resultSet = statement.executeQuery(sql);
      	while (resultSet.next()) {
      		int amount = resultSet.getInt("amount");
      		String name = resultSet.getString("name");
      		String itemspec = resultSet.getString("itemspec");
      		int year = resultSet.getInt("year");%>
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
                      y.domain([0, d3.max(filteredData, function(d) { return d.amount; })]);

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
                      svg.select(".y-axis").remove(); // 기존의 y축 요소 제거

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

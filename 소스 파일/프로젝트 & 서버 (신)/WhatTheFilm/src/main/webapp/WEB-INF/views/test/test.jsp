<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection,
java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>상영작 통계 조회</title>
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

#dataBox{
	max-width: 1024px;
	text-align: center;
	margin: auto;
}
</style>
</head>
<body>
<div id="dataBox">
	<label for="date-select">날짜:</label>
	<input type="date" id="date-select" onchange="updateData()" onload="setDefaultDate()" />
	<br>

	<svg id="chart"></svg>
	<br>
	<table id="data-table">
		<tr>
			<th>순위</th>
			<th>당일 관객수</th>
			<th>영화 제목</th>
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
			String sql = "SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY audiCnt DESC";
			ResultSet resultSet = statement.executeQuery(sql);
			int rank = 1;
			while (resultSet.next()) {
				int amount = resultSet.getInt("audiCnt");
				String name = resultSet.getString("movieNm");
				String itemspec = resultSet.getString("salesAmt");
				int year = resultSet.getInt("targetDt");
		%>
		<tr class="data-row">
			<td><%=rank%></td>
			<td><%=String.valueOf(amount)%></td>
			<td><%=name%></td>
			<td><%=itemspec%></td>
			<td><%=String.valueOf(year)%></td>
		</tr>
		<%
				rank++;
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
    String sql = "SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY targetDt ASC";
    ResultSet resultSet = statement.executeQuery(sql);
    int rank = 1;
    while (resultSet.next()) {
        int amount = resultSet.getInt("audiCnt");
        String name = resultSet.getString("movieNm");
        String itemspec = resultSet.getString("salesAmt");
        int year = resultSet.getInt("targetDt");%>
        {
            rank: <%=rank%>,
            amount: <%=String.valueOf(amount)%>,
            name: "<%=name%>",
            itemspec: "<%=itemspec%>",
            year: <%=String.valueOf(year)%>
        },
        <% rank++; }
        resultSet.close();
        statement.close();
        connection.close();
        } catch (Exception e) {
        e.printStackTrace();
        } %>
    ];

    // 초기 데이터로 테이블 생성
    var table = d3.select("#data-table");

    var rows = table.selectAll(".data-row")
        .data(originalData)
        .enter()
        .append("tr")
        .attr("class", "data-row");

    rows.append("td")
        .text(function(d) { return d.rank; });

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

    var x = d3.scaleBand()
        .domain(chartData.map(function(d) { return d.rank; }))
        .range([0, width])
        .padding(0.1);

    var y = d3.scaleLinear()
        .domain([0, d3.max(chartData, function(d) { return d.amount; })])
        .range([height, 0]);

    svg.selectAll(".bar")
        .data(chartData)
        .enter().append("rect")
        .attr("class", "bar")
        .attr("x", function(d) { return x(d.rank); })
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
        var selectedDate = document.getElementById("date-select").value;

        // Parse the selected date into the desired format (e.g., "2023-06-16")
        var formattedDate = selectedDate.split("-").join("");

        // Filter the originalData based on the selected date
        var filteredData = originalData.filter(function(d) {
            return d.year === parseInt(formattedDate);
        });

        // Sort the filteredData by rank
        filteredData.sort(function(a, b) {
            return a.rank - b.rank;
        });

        // Update the table
        var tableRows = table.selectAll(".data-row")
            .data(filteredData, function(d) { return d.rank; });

        tableRows.exit().remove();

        var newRows = tableRows.enter()
            .append("tr")
            .attr("class", "data-row");

        newRows.append("td");
        newRows.append("td");
        newRows.append("td");
        newRows.append("td");
        newRows.append("td");

        tableRows = newRows.merge(tableRows);

        tableRows.select("td:nth-child(1)")
            .text(function(d) { return d.rank; });

        tableRows.select("td:nth-child(2)")
            .text(function(d) { return d.amount; });

        tableRows.select("td:nth-child(3)")
            .text(function(d) { return d.name; });

        tableRows.select("td:nth-child(4)")
            .text(function(d) { return d.itemspec; });

        tableRows.select("td:nth-child(5)")
            .text(function(d) { return d.year; });

        // Update the chart
        svg.select(".y-axis").remove(); // Remove the existing y-axis
        svg.select(".x-axis").remove(); // Remove the existing x-axis

        x.domain(filteredData.map(function(d) { return d.rank; })); // Update x-axis domain
        y.domain([0, d3.max(filteredData, function(d) { return d.amount; })]); // Update y-axis domain

        var chartBars = svg.selectAll(".bar")
            .data(filteredData, function(d) { return d.rank; });

        chartBars.exit().remove();

        chartBars.enter()
            .append("rect")
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.rank); })
            .attr("y", function(d) { return y(d.amount); })
            .attr("width", x.bandwidth())
            .attr("height", function(d) { return height - y(d.amount); })
            .merge(chartBars)
            .transition()
            .duration(500)
            .attr("x", function(d) { return x(d.rank); })
            .attr("y", function(d) { return y(d.amount); })
            .attr("width", x.bandwidth())
            .attr("height", function(d) { return height - y(d.amount); });

        svg.append("g")
            .attr("class", "y-axis")
            .call(d3.axisLeft(y));
    }

    // 기본 선택 날짜를 어제로 설정
    document.getElementById("date-select").value = getYesterdayDate();

</script>
</body>
</html>

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
#chart{
  width: 100%; /* 가로 길이를 100%로 설정 */
  height: 100vh; /* 세로 길이를 뷰포트의 높이에 맞게 설정 */
}
</style>
</head>
<body>
<div id="chart-container">
	<svg id="chart"></svg>
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


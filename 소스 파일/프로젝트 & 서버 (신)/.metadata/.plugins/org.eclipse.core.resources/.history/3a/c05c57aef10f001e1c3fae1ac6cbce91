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
.arc {
	fill-opacity: 0.8;
}

.arc:hover {
	fill-opacity: 1;
}

#chart {
	max-width: 500px;
	height: 300px;
	margin: 30px auto;
}

#dataBox {
	max-width: 1024px;
	text-align: center;
	margin: auto;
}

.data-row.highlighted {
	background-color: yellow;
}

h4 {
	text-align: center;
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
		<h4>최근 100일 상영작 통계</h4>
		<div id="dataBox">
			<label for="date-select">날짜:</label> <input type="date" id="date-select" onchange="updateData(); updateTable();" onload="setDefaultDate()" /> <br>

			<div id="chart"></div>
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
					String sql = "SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY targetDt DESC LIMIT 1000";
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
	String sql = "SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY targetDt DESC LIMIT 1000";
	ResultSet resultSet = statement.executeQuery(sql);
	int rank = 1;
	while (resultSet.next()) {
		int amount = resultSet.getInt("audiCnt");
		String name = resultSet.getString("movieNm");
		String itemspec = resultSet.getString("salesAmt");
		int year = resultSet.getInt("targetDt");%>
        {amount: <%=amount%>, name: '<%=name%>', itemspec: '<%=itemspec%>', year: <%=year%>},
        <%}
resultSet.close();
statement.close();
connection.close();
} catch (Exception e) {
e.printStackTrace();
}%>
    ];

    // 도넛 차트 생성을 위한 함수
    var svg = d3.select("#chart")
        .append("svg")
        .attr("width", 500)
        .attr("height", 300)
        .append("g")
        .attr("transform", "translate(" + 250 + "," + 150 + ")");

    function createDonutChart(data) {
        var width = 500;
        var height = 300;
        var radius = Math.min(width, height) / 2;

        var color = d3.scaleOrdinal(d3.schemeCategory10);

        var pie = d3.pie()
            .value(function(d) { return d.amount; })
            .sort(null);

        var arc = d3.arc()
            .innerRadius(radius * 0.6)
            .outerRadius(radius);

        var arcs = svg.selectAll("arc")
            .data(pie(data))
            .enter()
            .append("g")
            .attr("class", "arc");

arcs.append("path")
  .attr("d", arc)
  .attr("fill", function(d, i) { return color(i); })
  .attr("fill-opacity", 0.8)
  .attr("data-index", function(d, i) { return i; }) // 인덱스 값을 저장하는 속성 추가
  .on("click", function() {
    var dataIndex = d3.select(this).attr("data-index");
    highlightTableRow(dataIndex);
  });

        arcs.append("text")
  .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
  .attr("text-anchor", "middle");
    }
	

    // 전날 데이터 필터링
    var currentDate = new Date();
    currentDate.setDate(currentDate.getDate() - 1);
    var previousDate = currentDate.toISOString().slice(0, 10);

    var filteredData = originalData.filter(function(d) {
        return d.year === parseInt(previousDate.replaceAll("-", ""));
    });

    // 초기 도넛 차트 생성
    createDonutChart(filteredData);

    
    // 어제의 날짜를 가져오는 함수
    function getYesterdayDate() {
      var today = new Date();
      var yesterday = new Date(today);
      yesterday.setDate(today.getDate() - 1);
      return yesterday.toISOString().slice(0, 10);
    }
    
    // 기본 날짜 설정
    function setDefaultDate1() {
      var yesterday = getYesterdayDate();
      document.getElementById("date-select").value = yesterday;
    }
    
    // 기본 날짜 설정
    function setDefaultDate() {
        var today = new Date().toISOString().slice(0, 10);
        document.getElementById("date-select").value = today;
    }
 // 데이터 가져오기 함수
    function fetchData() {
      var selectedDate = document.getElementById("date-select").value;
      
      // AJAX 요청
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          var responseData = JSON.parse(xhr.responseText);
          updateTable(responseData); // 테이블 갱신 함수 호출
        }
      };
      
      // 서버의 Java 코드로 요청 보내기
      xhr.open("GET", "getData.jsp?date=" + selectedDate, true);
      xhr.send();
    }

 // 테이블 갱신 함수
    function updateTable() {
      var table = document.getElementById("data-table");
      table.innerHTML = ""; // 기존 테이블 내용 초기화

      var selectedDate = document.getElementById("date-select").value;
      var filteredData = originalData.filter(function(d) {
        return d.year === parseInt(selectedDate.replaceAll("-", ""));
      });

      // 테이블 헤더 생성
      var headerRow = document.createElement("tr");
      var rankHeader = document.createElement("th");
      rankHeader.textContent = "순위";
      var amountHeader = document.createElement("th");
      amountHeader.textContent = "당일 관객수";
      var nameHeader = document.createElement("th");
      nameHeader.textContent = "영화 제목";
      var itemspecHeader = document.createElement("th");
      itemspecHeader.textContent = "당일 매출";
      var yearHeader = document.createElement("th");
      yearHeader.textContent = "날짜";

      headerRow.appendChild(rankHeader);
      headerRow.appendChild(amountHeader);
      headerRow.appendChild(nameHeader);
      headerRow.appendChild(itemspecHeader);
      headerRow.appendChild(yearHeader);

      table.appendChild(headerRow);

   // 데이터를 테이블에 추가
      for (var i = 0; i < filteredData.length; i++) {
        var row = document.createElement('tr');
		 row.className = 'data-row'; // 클래스 이름 추가
        var rankCell = document.createElement("td");
        rankCell.textContent = i + 1; // 순위 데이터 추가 (1부터 시작)
        var amountCell = document.createElement("td");
        amountCell.textContent = filteredData[i].amount.toLocaleString() + "명"; // "명"을 추가하여 표시
        var nameCell = document.createElement("td");
        nameCell.textContent = filteredData[i].name;
        var itemspecCell = document.createElement("td");
        itemspecCell.textContent = parseFloat(filteredData[i].itemspec).toLocaleString() + "원"; // 쉼표 포함된 형식으로 변환 후 "원"을 추가하여 표시
        var yearCell = document.createElement("td");
        yearCell.textContent = String(filteredData[i].year);

        row.appendChild(rankCell);
        row.appendChild(amountCell);
        row.appendChild(nameCell);
        row.appendChild(itemspecCell);
        row.appendChild(yearCell);

        table.appendChild(row);
      }

    }


function highlightRow(row) {
  var rows = document.getElementsByClassName('data-row');
  for (var i = 0; i < rows.length; i++) {
    rows[i].classList.remove('highlighted');
  }
  row.classList.add('highlighted');
}
function highlightTableRow(index) {
  var rows = document.getElementsByClassName("data-row");
  for (var i = 0; i < rows.length; i++) {
    if (i === parseInt(index)) {
      rows[i].classList.add("highlighted");
    } else {
      rows[i].classList.remove("highlighted");
    }
  }
}

var chartSlices = document.querySelectorAll(".arc path");
for (var i = 0; i < chartSlices.length; i++) {
  chartSlices[i].addEventListener("click", function() {
    var index = parseInt(this.getAttribute("data-index"));
    highlightTableRow(index);
	 row.addEventListener('click', function() {
    highlightRow(this); // 클릭한 행을 전달하여 highlightRow() 함수 호출
  });

  table.appendChild(row);
  });
}







    // 데이터 필터링 및 차트 업데이트
    function updateData() {
        var selectedDate = document.getElementById("date-select").value;
        var filteredData = originalData.filter(function(d) {
            return d.year === parseInt(selectedDate.replaceAll("-", ""));
        });

        svg.selectAll("*").remove();

        createDonutChart(filteredData);
    }
    
    // 페이지 로드 시 기본 날짜 설정
    setDefaultDate1();

</script>
</body>
</html>

// JSON 데이터를 비동기적으로 가져오기
Promise.all([
  fetch("./data/ChartSetting.json").then((response) => response.json()),
  fetch("./data/list.json").then((response) => response.json()),
])
  .then(([chartData, jsonData]) => {
    var selectElement = document.getElementById("achievementSelect");

    // 선택 가능한 옵션 추가
    jsonData.forEach((review) => {
      var option = document.createElement("option");
      option.value = review.title;
      option.text = review.title;
      selectElement.add(option);
    });

    // radarOptions 데이터 가져오기
    var radarOptions = {
      scale: {
        ticks: {
          beginAtZero: chartData.chartData.beginAtZero,
          min: chartData.chartData.min,
          max: chartData.chartData.max,
          stepSize: chartData.chartData.stepSize,
          fontSize: 20, // 원하는 폰트 크기로 설정 (예: 60) 스텝 크기
        },
        pointLabels: {
          fontSize: 24, // 원하는 폰트 크기로 설정 (예: 24) 라벨 크기
        },
      },
    };

    // 레이더 차트 생성
    var radarData = {
      labels: [],
      datasets: [
        {
          label: "데이터셋",
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          pointBackgroundColor: "rgba(75, 192, 192, 1)",
          pointBorderColor: "#fff",
          pointHoverBackgroundColor: "#fff",
          pointHoverBorderColor: "rgba(75, 192, 192, 1)",
          data: [],
        },
      ],
    };

    var ctx = document.getElementById("radarChart").getContext("2d");
    var radarChart = new Chart(ctx, {
      type: "radar",
      data: radarData,
      options: radarOptions,
    });

    // 리뷰 선택 시 해당 리뷰의 데이터 로드
    function loadReviewData() {
      var selectedTitle = selectElement.value;
      var reviewDataPath = "./list/" + selectedTitle + "/data.json";

      // 리뷰 데이터 가져오기
      fetch(reviewDataPath)
        .then((response) => response.json())
        .then((reviewData) => {
          // 선택된 리뷰의 제목과 내용 표시
          var titleElement = document.getElementById("achievementTitle");
          var contentElement = document.getElementById("achievementContent");

          titleElement.textContent = selectedTitle;
          contentElement.innerHTML = ""; // 내용 초기화

          // content 배열의 각 항목을 처리
          reviewData.content.forEach((item) => {
            if (item.type === "text") {
              // 텍스트 항목인 경우
              var textNode = document.createTextNode(item.value);
              contentElement.appendChild(textNode);
            } else if (item.type === "image") {
              // 이미지 항목인 경우
              var imageContainer = document.createElement("div");
              imageContainer.className = "image-container";

              var image = new Image();
              image.onload = function () {
                var canvas = document.createElement("canvas");
                var ctx = canvas.getContext("2d");

                // 이미지 크기를 1024px로 조정
                var width = 1024;
                var height = (width / this.width) * this.height;
                canvas.width = width;
                canvas.height = height;

                // 조정된 크기로 이미지 그리기
                ctx.drawImage(this, 0, 0, width, height);

                // 이미지를 data URL로 변환하여 img 요소 생성
                var imageElement = new Image();
                imageElement.src = canvas.toDataURL();
                imageContainer.appendChild(imageElement);

                // canvas 요소 삭제 (optional)
                canvas.remove();
              };
              image.src = "./list/" + selectedTitle + "/" + item.value;

              contentElement.appendChild(imageContainer);
            } else if (item.type === "table") {
              // 테이블 항목인 경우
              var table = document.createElement("table");
              var tbody = document.createElement("tbody");

              item.value.forEach((row) => {
                var tr = document.createElement("tr");
                row.forEach((cell) => {
                  var td = document.createElement("td");
                  td.textContent = cell;
                  tr.appendChild(td);
                });

                tbody.appendChild(tr);
              });

              table.appendChild(tbody);
              contentElement.appendChild(table);
            }
          });

          // 레이더 차트 데이터 업데이트
          radarChart.data.labels = reviewData.labels.map((label) => label.name);
          radarChart.data.datasets[0].data = reviewData.labels.map(
            (label) => label.value
          );
          radarChart.update();
        })
        .catch((error) => {
          console.error(
            "리뷰 데이터를 가져오는 동안 오류가 발생했습니다:",
            error
          );
        });
    }

    // 리뷰 선택 시 loadReviewData() 함수 호출
    selectElement.addEventListener("change", loadReviewData);

    // 초기 리뷰 데이터 로드
    loadReviewData();
  })
  .catch((error) => {
    console.error("JSON 데이터를 가져오는 동안 오류가 발생했습니다:", error);
  });

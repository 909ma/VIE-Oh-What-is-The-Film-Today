<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 포스터 검색</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $("#searchButton").click(function() {
        var movieTitle = $("#movieTitle").val(); // 인풋 박스의 값 가져오기
        searchMovie(movieTitle); // 영화 검색 함수 호출
    });

    function searchMovie(movieTitle) {
        var apiKey = "e2a56aa6721d47327a92acc02bfbddf3";
        // 제 api 키 값입니다... : e2a56aa6721d47327a92acc02bfbddf3
        var encodedTitle = encodeURIComponent(movieTitle);
        var apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + encodedTitle;

        $.ajax({
            url: apiUrl,
            type: "GET",
            success: function(response) {
                var results = response.results;
                if (results.length > 0) {
                    var movie = results[0];
                    var posterPath = movie.poster_path;
                    var posterUrl = "https://image.tmdb.org/t/p/w500" + posterPath;
                    $("#posterImage").attr("src", posterUrl); // 포스터 이미지 업데이트
                } else {
                    $("#posterImage").attr("src", ""); // 검색 결과 없을 경우 이미지 초기화
                }
            },
            error: function() {
                $("#posterImage").attr("src", ""); // 에러 발생 시 이미지 초기화
            }
        });
    }
});
</script>
</head>
<body>
    <h1>영화 포스터 검색</h1>
    <input type="text" id="movieTitle" placeholder="영화 제목을 입력하세요">
    <button id="searchButton">검색</button>
    <br>
    <img id="posterImage" src="" alt="포스터 이미지">
</body>
</html>

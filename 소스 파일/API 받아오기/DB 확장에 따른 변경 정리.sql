-- 개봉작 통계 조회(최근 1년 동안의 데이터만 제공할 예정)
CREATE VIEW HowMuchDailyMovie AS SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY targetDt DESC LIMIT 3650;
SELECT * FROM HowMuchDailyMovie;

-- 상영작 통계 조회
CREATE VIEW MovieChart AS 
SELECT audiCnt, movieNm, salesAmt, targetDt
FROM DailyMovie
ORDER BY targetDt DESC
LIMIT 1000;

SELECT * FROM MovieChart ORDER BY audiCnt DESC;
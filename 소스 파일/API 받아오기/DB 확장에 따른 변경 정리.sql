-- 개봉작 통계 조회(최근 1년 동안의 데이터만 제공할 예정)
CREATE VIEW HowMuchDailyMovie AS SELECT audiCnt, movieNm, salesAmt, targetDt FROM DailyMovie ORDER BY targetDt DESC LIMIT 3650;
SELECT * FROM HowMuchDailyMovie;


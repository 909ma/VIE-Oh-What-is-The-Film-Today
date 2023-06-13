-- 테이블 만들기
CREATE TABLE `myproject`.`dailymovie` (
  `movieCd` VARCHAR(100) NOT NULL,
  `number` BIGINT NULL,
  `movieNm` VARCHAR(1000) NULL,
  `openDt` VARCHAR(45) NULL,
  `rank` INT NULL,
  `salesAmt` BIGINT NULL,
  `salesAcc` BIGINT NULL,
  `audiCnt` BIGINT NULL,
  `audiAcc` BIGINT NULL,
  `targetDt` BIGINT NULL,
  PRIMARY KEY (`movieCd`)
);

-- 테이블 내용 전체 보기
SELECT * FROM myproject.dailymovie;

-- 지정된 날 영화 보기
SELECT * FROM myproject.dailymovie where targetDt = '20230505';

-- 테이블 내용 삭제
-- delete from dailymovie;

-- 일일 관객수 총합
SELECT targetDt, SUM(audiCnt) AS totalAudience
FROM dailymovie
GROUP BY targetDt
ORDER BY targetDt;

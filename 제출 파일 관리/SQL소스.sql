-- 유저 테이블
CREATE TABLE `user` (
  `member_id` bigint NOT NULL AUTO_INCREMENT,
  `loginid` varchar(255) NOT NULL,
  `password` varchar(70) NOT NULL,
  `gender` enum('남성','여성') NOT NULL,
  `birthyear` char(6) NOT NULL,
  `nickname` varchar(45) NOT NULL,
  `manager` int NOT NULL,
  `regdate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 영화 테이블
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

-- 공지사항 게시판
CREATE TABLE IF NOT EXISTS notice (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 자유게시판
CREATE TABLE IF NOT EXISTS freeboard (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    author VARCHAR(100) NOT NULL,
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 뷰
CREATE VIEW HowMuchDailyMovie AS 
SELECT audiCnt, movieNm, salesAmt, targetDt 
FROM DailyMovie 
ORDER BY targetDt DESC 
LIMIT 3650;

CREATE VIEW MovieChart AS 
SELECT audiCnt, movieNm, salesAmt, targetDt
FROM DailyMovie
ORDER BY targetDt DESC
LIMIT 1000;


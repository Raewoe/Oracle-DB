--01_DDL.sql

--memberlist 테이블 생성
CREATE TABLE `scott`.`memberlist` (
  `membernum` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `birth` DATETIME NULL DEFAULT NOW(),
  `age` INT NULL DEFAULT 20,
  `bpoint` INT NULL DEFAULT 0,
  PRIMARY KEY (`membernum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

select*from memberlist;


--booklist 테이블 생성
CREATE TABLE `scott`.`booklist` (
  `booknum` INT NOT NULL AUTO_INCREMENT,
  `subject` VARCHAR(100) NOT NULL,
  `makeyear` INT NULL,
  `inprice` INT NOT NULL,
  `rentprice` INT NOT NULL,
  `grade` VARCHAR(5) NULL DEFAULT 'all',
  PRIMARY KEY (`booknum`))
  ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


--자주 쓰는 자료형
--int : 정수 자료형(float, double 은 실수)
--varchar : 문자열 자료형, 가변 길이(char은 고정 길이)
--text : 긴 문자열은 text로 별도 저장
--datetime : 날짜 자료형 저장
--tinyint : -128에서 127까지 저장하지만 여기서는 1또는 0만 저장해 boolean 값 표현


--자주 쓰는 제약 조건
--not null : 빈 값은 받지 않는다는 뜻(null은 빈 값 허용)
--auto_increment : 숫자 자료형인 경우 다음 로우가 저장될 때 자동으로 1 증가
--UNSIGNED: 0과 양수만 허용
--ZEROFILL: 숫자의 자리 수가 고정된 경우 빈 자리에 0을 넣음
--DEFAULT now(): 날짜 컬럼의 기본값을 현재 시간으로. DATETIME 자료형에 적용 가능


--rentlist 테이블 생성
--필드 :
--numseq(PK, int, AI), rentdate(datetime, default now()), bnum(int, not null)
--mnum(int, not null), discount(int, default 0)

CREATE TABLE `scott`.`rentlist` (
  `numseq` INT NOT NULL AUTO_INCREMENT,
  `rentdate` DATETIME NULL DEFAULT now(),
  `bnum` INT NOT NULL,
  `mnum` INT NOT NULL,
  `discount` INT NULL DEFAULT 0,
  PRIMARY KEY (`numseq`),
  INDEX `FK1_idx` (`bnum` ASC) VISIBLE,
  INDEX `FK2_idx` (`mnum` ASC) VISIBLE,
  CONSTRAINT `FK1`
    FOREIGN KEY (`bnum`)
    REFERENCES `scott`.`booklist` (`booknum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK2`
    FOREIGN KEY (`mnum`)
    REFERENCES `scott`.`memberlist` (`membernum`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

select*from rentlist;







--필드의 수정
alter table `scott`.`memberlist`
change column `birth` `birthday` date not null;

--필드 삭제
alter table `scott`.`memberlist`
drop column `gender`;

--필드의 추가
alter table `scott`.`memberlist`
add column `gender` varchar(3) null after `age`;
--age 필드 뒤에 gender 필드 생성

select*from memberlist;

--외래키 추가
ALTER TABLE `scott`.`rentlist` 
ADD INDEX `FK1_idx` (`bnum` ASC) VISIBLE,
ADD INDEX `FK2_idx` (`mnum` ASC) VISIBLE;
;
ALTER TABLE `scott`.`rentlist` 
ADD CONSTRAINT `FK1`
  FOREIGN KEY (`bnum`)
  REFERENCES `scott`.`booklist` (`booknum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `FK2`
  FOREIGN KEY (`mnum`)
  REFERENCES `scott`.`memberlist` (`membernum`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;



  
  
  
  
create or replace view rentDetail as 
select a.numseq, date_format(a.rentdate, '%Y-%m-%d')as rd, 
       a.bnum, b.subject, a.mnum, c.name, b.rentprice, a.discount,
       (b.rentprice - a.discount)as "amount"
from rentlist a, booklist b, memberlist c 
where a.bnum = b.booknum and a.mnum = c.membernum;

select*from rentDetail;








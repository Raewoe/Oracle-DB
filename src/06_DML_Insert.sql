-- 06_DML.sql


-- DML(Data Management Language) 데이터 조작 언어

-- 테이블에 레코드를 조작(추가, 수정, 삭제, 조회)하기 위한 명령어들
-- INSERT(추가)
-- UPDATE(수정)
-- DELETE(삭제)
-- SELECT(조회 및 선택)


-- [1] 샘플 테이블 생성
CREATE TABLE exam01(
	deptno number(2),
	dname varchar2(15),
	loc varchar2(15)
);

SELECT * FROM exam01;

-- [2] 레코드 추가

-- 레코드 추가 방법 #1
INSERT INTO 테이블이름(필드명1, 필드명2, 필드명3, ...) VALUES(값1, 값2, 값3, ...);

-- 레코드 추가 방법 #2
INSERT INTO 테이블이름 VALUES(값1, 값2, 값3, ...);


-- #1과 #2의 차이점
-- #1: 필드명과 입력되어야 하는 값들이 1:1 매칭되어 입력된다
--		 필드명의 순서는 반드시 지켜야하는 것은 아니지만 나열된 필드명대로 값들의 순서는 맞춰서 입력한다.
INSERT INTO exam01(deptno, dname, loc) VALUES('기획부', 10, '서울'); --X
INSERT INTO exam01(deptno, dname, loc) VALUES(10, '기획부', '서울'); --O
INSERT INTO exam01(loc, deptno, dname) VALUES('서울', 10, '기획부'); --O
-- null 값을 허용하는 필드나, default 값이 있는 필드는 생략하고 구성할 수 있다.
INSERT INTO exam01(deptno, dname) VALUES(10, '기획부'); --O


-- #2 모든 필드에 해당하는 값들을 최초에 테이블 생성시 기술한 필드순서에 맞게 모두 입력하는 방법이다
INSERT INTO exam01 VALUES(10, '기획부', '서울'); --O
-- #2는 null을 허용하는곳을 비우고 입력할 수 없으며, null이라도 직접 지정해야 한다
INSERT INTO exam01 VALUES(10, null, '서울'); --O

-- #1과 #2 공통으로 숫자는 그냥 쓰고, 문자는 작은 따옴표로 묶어서 표현한다

DELETE FROM booklist;	--테이블내의 모든 레코드를 삭제하는 명령

-- 위 두가지 방법 중 자유롭게 선택하여, booklist 테이블에 10개의 레코드를 추가한다
-- booknum은 시퀀스를 이용한다
-- grade는 'all', '12', '18' 세가지만 골라서 입력한다. 테이블에 grade가 없으면 입력하지 않아도 된다

SELECT * FROM booklist;

INSERT INTO booklist VALUES(book_seq.nextVal, '이것이 자바다', 2017, 30000, 3000);
INSERT INTO booklist VALUES(book_seq.nextVal, '가면산장 살인사건', 2018, 13320, 1500);
INSERT INTO booklist VALUES(book_seq.nextVal, '나미야 잡화점의 기적', 2017, 13320, 2000);
INSERT INTO booklist VALUES(book_seq.nextVal, '유튜브 영상편집', 2020, 20700, 2500);
INSERT INTO booklist VALUES(book_seq.nextVal, 'JSP웹프로그래밍', 2016, 25000, 2500);
INSERT INTO booklist VALUES(book_seq.nextVal, '오라클데이터베이스', 2020, 30000, 3000);
INSERT INTO booklist VALUES(book_seq.nextVal, '일곱해의 마지막', 2020, 12150, 2000);
INSERT INTO booklist VALUES(book_seq.nextVal, '봉제인형 살인사건', 2019, 13150, 2000);
INSERT INTO booklist VALUES(book_seq.nextVal, '쇼코의 미소', 2023, 13420, 2000);

INSERT INTO booklist(booknum, subject, makeyear, inprice, outprice)
VALUES(book_seq.nextVal, '좀비아이', 2020, 12000, 2500);


-- memberlist에 10명의 데이터를 추가한다. (member_seq이용)
SELECT * FROM memberlist;
INSERT INTO memberlist(membernum, name, phone)
VALUES(member_seq.nextVal, '홍길동', '010-1111-2222');
INSERT INTO memberlist(membernum, name, phone)
VALUES(member_seq.nextVal, '이순신', '010-2222-3333');
INSERT INTO memberlist(membernum, name, phone)
VALUES(member_seq.nextVal, '유관순', '010-3333-4444');
INSERT INTO memberlist(membernum, name, phone)
VALUES(member_seq.nextVal, '신사임당', '010-4444-5555');

INSERT INTO memberlist VALUES(member_seq.nextVal, '추신수', '010-5656-1234', '84/07/07', 240, 'M', 28);
INSERT INTO memberlist VALUES(member_seq.nextVal, '류현진', '010-3333-1234', '83/08/08', 142, 'F', 27);
INSERT INTO memberlist VALUES(member_seq.nextVal, '손흥민', '010-4444-1234', '82/07/04', 220, 'M', 23);
INSERT INTO memberlist VALUES(member_seq.nextVal, '이청용', '010-6666-1234', '81/06/03', 440, 'F', 36);
INSERT INTO memberlist VALUES(member_seq.nextVal, '이영표', '010-5555-1234', '80/05/02', 140, 'M', 31);
INSERT INTO memberlist VALUES(member_seq.nextVal, '최지만', '010-1111-1234', '85/04/01', 340, 'F', 29);

SELECT * FROM booklist;
SELECT * FROM memberlist;
SELECT * FROM rentlist;


-- rentlist 테이블도 rent_seq를 이용해서 10개의 데이터를 추가한다
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2021/10/01', 1, 1, 100);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2021/11/01', 1, 2, 100);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2021/12/01', 2, 3, 200);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2021/10/05', 4, 4, 100);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2022/10/01', 6, 1, 200);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2022/10/03', 6, 5, 300);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2022/10/05', 5, 4, 100);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2022/11/01', 7, 2, 300);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2023/12/01', 9, 7, 100);
INSERT INTO rentlist VALUES(rent_seq.nextVal, '2023/01/01', 10, 8, 200);

commit -- 현재창에서 commit은 세미콜론을 붙이지 않는다. 단일 명령이고 다른 명령과 함께 사용하지 않는다는 뜻이다.



-- 데이터베이스 백업명령
exp userid=scott/tiger file=abc.dmp log=abc.log

-- 데이터베이스 복원명령
imp userid=scott/tiger file=abc.dmp log=abc.log full=y

-- 오라클의 백업 명령과 복원 명령은 모두 command 창에서 실행한다













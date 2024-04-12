-- 10_View.sql

--* 오라클 - 뷰(View)
--  - 물리적인 테이블에 근거한 논리적인 "가상 테이블." -> 저장되어 있는 select 문
--	- 가상이란 단어는 실질적으로 데이터를 저장하고 있지 않기 때문에 붙인 것이고,
--	- 테이블이란 단어는 실질적으로 데이터를 저장하고 있지 않더라도 사용자는 마치
--	- 테이블을 사용하는 것과 동일하게 뷰를 사용할 수 있기 때문에 붙인 것.

--	- 뷰는 기본테이블에서 파생된 객체로서 기본테이블에 대한 하나의 쿼리문임.
--	- 실제 테이블에 저장된 데이터를 뷰를 통해서 볼 수 있도록 함.


-- 뷰 생성 방법
CREATE OR replace VIEW 뷰이름 AS SELECT 조회 명령(SELECT~)


CREATE OR replace VIEW empinfo AS
SELECT a.empno, a.ename, a.deptno, b.dname, b.loc
FROM emp a, dept b
WHERE a.deptno = b.deptno;

SELECT * FROM empinfo;


-- rentlistm, memberlist, booklist 가 조인된 결과는 report라는 이름의 뷰를 생성하세요
-- 대여일자, 대여도서번호, 제목, 대여회원번호, 이름, 매출액(rentprice-discount)
CREATE OR replace VIEW report AS
SELECT r.rentdate AS "대여일자", r.bnum AS "대여도서번호", b.subject AS "제목", r.mnum AS "대여회원번호", m.name AS "이름", b.rentprice-r.discount AS "매출액"
FROM rentlist r, memberlist m, booklist b
WHERE r.mnum = m.membernum AND r.bnum = b.booknum

SELECT * FROM report;

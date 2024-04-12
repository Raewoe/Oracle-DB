-- 09_JOIN.sql

SELECT * FROM emp;
SELECT * FROM dept;
DROP TABLE emp2;
CREATE TABLE emp2 AS SELECT ename, deptno FROM emp WHERE job='SALESMAN';
SELECT * FROM emp2;


-- [1] 사원명이 'SCOTT'인 사원의 부서명을 알고 싶을 때
SELECT deptno FROM emp WHERE ename='SCOTT';
SELECT dname FROM dept WHERE deptno=20;
-- 서브쿼리 사용 ----------------------------
SELECT dname FROM dept WHERE deptno=(SELECT deptno FROM emp WHERE ename='SCOTT');

-- JOIN
-- 두 개 이상의 테이블에 나눠져 있는 관련 데이터들을 하나의 테이블로 모아서 조회하고자 할 때 사용하는 명령이다.


-- cross join : 두개 이상의 테이블이 조인
-- ***가장 최악의 결과를 얻는 조인 방식***
SELECT * FROM emp2,dept;


-- equi join : 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이 일치하는 행을 연결하여 결과를 생성
SELECT * FROM emp2,dept WHERE emp2.deptno = dept.deptno;

SELECT * FROM emp2 a, dept b WHERE a.deptno = b.deptno;

SELECT * FROM emp a, dept b WHERE a.deptno = b.deptno;



-- rentlist의 대여일자, 대여도서번호, 대여회원번호, 할인금액을 출력하되, 도서의 제목을 도서번호 옆에 출력하세요
SELECT a.rentdate, a.bnum, b.subject, a.mnum, a.discount FROM rentlist a, booklist b
WHERE a.bnum = b.booknum;

-- rentlist의 대여일자, 대여도서번호, 대여회원번호, 할인금액을 출력하되, 회원의 이름을 대여회원번호 옆에 출력하세요
SELECT a.rentdate, a.bnum, a.mnum, m.name, a.discount FROM rentlist a, memberlist m
WHERE a.mnum = m.membernum;

-- rentlist의 대여일자, 대여도서번호, 대여회원번호, 할인금액을 출력하되, 도서의 제목, 회원의 이름을
-- 도서번호와 회원번호 옆에 출력하세요
SELECT a.rentdate AS "대여날짜", a.bnum, b.subject AS "제목", a.mnum, c.name AS "대여자", a.discount AS "할인", b.rentprice-a.discount AS"매출액"
FROM rentlist a, booklist b, memberlist c
WHERE a.bnum = b.booknum AND a.mnum = c.membernum;


-- non-equi join
-- 동일 컬럼이 없어서 다른 조건을 사용하여 조인
-- 조인 조건에 특정 범위내에 있는지를 조사하기 위해 조건절에 조인 조건을 '=' 연산자 이외의 비교
SELECT * FROM emp;
SELECT * FROM salgrade;

SELECT a.ename, a.sal, b.grade
FROM emp a, salgrade b
WHERE a.sal >= b.losal AND a.sal <= b.hisal;

SELECT a.ename, a.sal, b.grade
FROM emp a, salgrade b
WHERE a.sal BETWEEN b.losal AND b.hisal;


-- outer join
-- 조인 조건에 만족하지 못해서 해당 결과를 출력시에 누락이 되는 문제점이 발생할 때 해당 레코드를 출력하는 조인
SELECT a.booknum, a.subject, b.rentdate FROM booklist a, rentlist b
WHERE a.booknum=b.bnum(+)

-- emp 테이블에는 deptno가 40인 레코드가 하나도 없다. 그래서 조인 결과에는 40번 부서의 이름도 loc도 표시가 안된다
SELECT * FROM emp a, dept b
WHERE a.deptno(+)=b.deptno;


-- ANSI join

-- 일반 equi 조인
SELECT a.ename, b.dname
FROM emp a, dept b
WHERE a.deptno=b.deptno;

-- Ansi inner join
-- Ansi 이너 조인의 표현 방식
SELECT ename, dname
FROM emp INNER JOIN dept ON emp.deptno=dept.deptno;

-- Ansi 이너 조인의 표현 방식 - 서로 비교되는 필드명이 같을 때만 사용
SELECT ename, dname
FROM emp INNER JOIN dept USING (deptno)


-- Ansi Outer Join
-- 기존 아우터 조인의 표현방식
SELECT * FROM emp, dept
WHERE emp.deptno(+) = dept.deptno;

SELECT * FROM rentlist, booklist
WHERE rentlist.bnum(+) = booklist.booknum;

-- Ansi Outer Join 표현방식
SELECT * FROM emp RIGHT OUTER JOIN dept ON emp.deptno = dept.deptno;
SELECT * FROM rentlist RIGHT OUTER JOIN booklist ON rentlist.bnum = booklist.booknum;















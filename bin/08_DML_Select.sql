-- 08_DML_Select.sql

-- 오라클 명령어: select문(검색)
-- 가장 사용빈도수가 높은 명령

-- [1] scott 사용자가 관리하고 있는 테이블 목록
SELECT * FROM tab;
SELECT * FROM tabs;

-- [2] 특정 테이블의 구조 조회(필드 리스트/데이터 형식)
desc booklist; -- 커맨드 창(sqlplus)에서 확인 요망
desc memberlist; -- 커맨드 창(sqlplus)에서 확인 요망


SELECT * FROM USER_CONSTRAINTS;	-- 모든 제약 사항
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='RENTLIST';	-- 특정테이블의 제약 사항
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='BOOKLIST';
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='MEMBERLIST';


-- SELECT의 사용법
-- SELECT: select와 from 사이에 조회하고자 하는 필드명들을 ,로 구분하여 나열한다
SELECT booknum, subject, rentprice FROM booklist;
-- 모든 필드를 한번에 지목하려면 *을 써준다		--SELECT * FROM...
-- from 뒤에는 대상 테이블 명을 써준다
-- where 절을 붙여서 조건에 맞는 행만 골라낼 수 있다
SELECT 필드명들 또는 * FROM 테이블명 WHERE 검색조건

-- 출판년도가 2020년 이후인 도서의 제목과 출판년도를 조회
SELECT subject, makeyear FROM booklist WHERE makeyear>=2020;

SELECT * FROM booklist;	-- 검색조건 없이 모든 필드를 다 조회해서 열람


-- 연산의 결과가 필드의 항목을 조회할 수 있다
SELECT rentprice - inprice FROM booklist;
SELECT rentprice * 10 - inprice AS 마진 FROM booklist;
SELECT subject AS 제목, rentprice * 10 - inprice AS 마진 FROM booklist;
SELECT subject AS "도서 제목", rentprice * 10 - inprice AS "10회대여 마진" FROM booklist;
-- 오라클 SQL에서 ||는 이어붙이기 연산이다
SELECT booknum ||'-'|| subject AS "book info" FROM booklist;


-- 중복제거 distinct
SELECT bnum AS 도서대여기록 FROM rentlist;
SELECT DISTINCT bnum AS 도서대여기록 FROM rentlist;


-- 함수의 사용
SELECT avg(inprice) AS 입고가격평균 FROM booklist;
SELECT sum(inprice) AS 입고가격합계 FROM booklist;


-- 검색 조건: update와 delete에서 사용하던 where와 사용방식이 같다
SELECT * FROM memberlist;
SELECT * FROM booklist;


-- memberlist 테이블에서 이름이 '홍'으로 시작하는 회원의 모든 회원정보 출력
SELECT * FROM memberlist WHERE name LIKE '홍%';

-- memberlist 테이블에서 1983년도 이후로 태어난 회원의 모든 회원정보
SELECT * FROM memberlist WHERE birth>='1983/01/01';

-- booklist에서 제작년도가 2016년 이전이거나 입고가격(inprice)이 18000 이하인 도서의 모든 필드
SELECT * FROM booklist WHERE makeyear<2016 OR inprice<=18000;

-- booklist에서 도서 제목에 두번째 글자가 '것'인 도서 정보
SELECT * FROM booklist WHERE subject LIKE '_것%';


SELECT * FROM emp;
SELECT * FROM dept;


-- IN  ANY  SOME  ALL

-- 부서번호가 10,20,30인 사원들의 모든 필드 조회
-- 방법 #1
SELECT * FROM emp WHERE deptno=10 OR deptno=20 OR deptno=30;

-- 방법 #2
SELECT * FROM emp WHERE deptno <> 40; -- 40이 아닌 것

-- 방법 #3
SELECT * FROM emp WHERE deptno IN(10,20,30);


-- 1. ANY
SELECT * FROM emp WHERE deptno = ANY(10,20,40);
-- ANY(): 괄호안에 나열된 내용중 어느하나라도 해당하는 것이 있다면 검색 대상으로 함
-- in과 유사

-- 2. SOME 조건식 - ANY와 동일
SELECT * FROM emp WHERE deptno = SOME(10,20,40);


-- ALL
SELECT * FROM emp WHERE deptno = ALL(10,20,40);
-- 괄호안의 모든값이 동시 만족해야하는 조건이므로 해당하는 레코드가 없을때가 대부분이다. 사용빈도수가 현저히 낮다

SELECT * FROM emp WHERE deptno <> ALL(10,20,40);
-- 이와 같이 구성내용과 모두 같지 않을때를 필터링할 때 자주 사용한다
-- 위 예문을 in으로 표현
SELECT * FROM emp WHERE deptno NOT IN(10,20,40);




-- 그 외 활용하기 좋은 select에 대한 예제

-- 부서번호가 10이 아닌 사원(아래 두 문장은 같은 의미의 명령이다)
SELECT * FROM emp WHERE NOT ( DEPTNO=10);
SELECT * FROM emp WHERE DEPTNO<>10;

-- 급여가 1000달러 이상, 3000달러 이하
SELECT * FROM emp WHERE SAL>=1000 AND SAL<=3000;
SELECT * FROM emp WHERE SAL BETWEEN 1000 AND 3000;

-- 사원의 연봉 출력
SELECT deptno, ename, sal*12 AS 연봉 FROM emp;



-- 정렬(Sort) - where 구문 뒤에, 또는 구문의 맨 끝에 Order by 필드명[desc]
-- select 명령의 결과를 특정 필드값의 오름차순 이나 내림 차순으로 정렬하라는 명령
-- asc: 오름차순 정렬, 쓰지 않으면 기본 오름차순 정렬로 실행된다
-- desc: 내림차순 정렬, 내림 차순 정렬을 위해서는 반드시 필드명 뒤에 써야하는 키워드입니다.

-- emp 테이블에서
-- sal이 1000 이상인 데이터를 ename의 오름차순으로 정렬하여 조회
SELECT * FROM emp WHERE sal>=1000 ORDER BY ename;		-- 오름차순일때 asc는 생략 가능
-- sal이 1000 이상인 데이터를 ename의 내림차순으로 정렬하여 조회
SELECT * FROM emp WHERE sal>=1000 ORDER BY ename DESC;


-- job으로 내림차순 정렬 후 같은 job_id 사이에서는 순서를 hiredate의 내림차순으로 정렬
SELECT * FROM emp ORDER BY job DESC, hiredate DESC;
-- 두개 이상의 정렬 기준이 필요하다면 위와 같이 컴마(,)로 구분해서 두가지 기준을 지정해주며,
-- 위의 예제로 봤을 때 job으로 1차 내림 차순 정렬하고, 같은 job 값들 사이에 hiredate로 내림차순 정렬한다










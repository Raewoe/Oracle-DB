-- 07_DML_Update

-- 데이터 변경 - 수정(UPDATE)
-- UPDATE 테이블명 SET 변경내용 WHERE 검색조건
UPDATE memberlist SET age=30, phone='010-0000-1111' WHERE membernum=3;
UPDATE memberlist SET age=17 WHERE name='유관순';
SELECT * FROM memberlist;


-- 명령문에 WHERE 이후 구문은 생략이 가능하다
-- 다만 이부분을 생략하면 모든 레코드를 대상으로해서 UPDATE 명령이 실행되어 모든 레코드가 수정된다.
-- 검색조건: 필드명(비교-관계연산자) 조건값 으로 이루어진 조건연산이며, 흔히 자바에서 if()
-- if 괄호안에 사용했던 연산을 그대로 사용하는게 보통이다
-- 나이가 29세 이상 -> WHERE age>=29
-- 두개 이상의 필드를 수정하고자 한다면 (,)로 구분해서 기술한다
-- 복합 조건을 사용하고자 한다면 and,or 등을 사용한다 (&& -> AND, || -> OR, ! -> NOT)

-- 예제풀면서 확인하려고 임의로 작성한 내용임
ALTER TABLE booklist ADD grade varchar2(3);
SELECT * FROM booklist;
ALTER TABLE booklist RENAME COLUMN outprice to rentprice;
SELECT * FROM memberlist;
-- 여기까지

-- booklist 테이블의 도서 제목 '봉제인형 살인사건' 도서의 grade를 '18'로 수정한다
UPDATE booklist SET grade='18' WHERE subject='봉제인형 살인사건';
UPDATE booklist SET grade='18' WHERE subject LIKE '봉제인형%';
UPDATE booklist SET grade='18' WHERE subject LIKE '%살인사건';
UPDATE booklist SET grade='18' WHERE subject LIKE '%인형%';

-- booklist의 모든 도서의 대여가격(rentprice)를 10% 이상으로 인상한 값으로 수정한다
UPDATE booklist SET rentprice=rentprice*1.1; 

-- memberlist에서 사은포인트(bpoint)가 300이상인 회원의 bpoint에 30점을 가산한다
UPDATE memberlist SET bpoint=bpoint+30 WHERE bpoint>=300;

-- 생년월일이 NULL인 회원의 생년월일을 2000-01-01로 AGE를 23으로 변경한다
UPDATE memberlist SET birth='00/01/01', age=23 WHERE birth IS NULL;	--null 선택시 is사용

-- GENDER가 NULL인 회원의 GENDER를 'M'으로 변경한다
UPDATE memberlist SET gender='M' WHERE gender IS null;

SELECT * FROM booklist;


-- 외래키로 참조되는 필드를 수정
UPDATE booklist SET booknum=17 WHERE booknum=7;
-- rentlist의 bnum에 7번이 없다면 변경이 가능
-- rentlist의 bnum에 7번이 있다면 변경이 불가능
-- ORA-02292: integrity constraint (SCOTT.FK1) violated - child record found

-- 해결방법
-- #1 외래키를 지우고 해당 booknum과 bnum을 함께 수정한 후 다시 외래키를 설정
-- #2 PL/SQL의 트리거 기능을 이용해서 동시에 변경



-- 레코드의 삭제
-- DELETE FROM 테이블명 WHERE 조건식
-- ***WHERE 조건식이 생략되면 모든 레코드가 삭제된다 ( 주의!!! )***

-- rentlist 테이블에서 discount가 10이하인 레코드를 삭제
DELETE FROM rentlist WHERE discount<=10;


-- 삭제의 제한
DELETE FROM booklist WHERE booknum=7;	--삭제 실패
--  integrity constraint (SCOTT.FK1) violated - child record found
SELECT * FROM booklist;

-- 해결방법 #1
-- 이를 해결하려면 우선 rentlist 테이블에 해당 도서 대여목록 레코드(child record)를 모두 삭제한 후
-- booklist 테이블에서 해당 도서를 삭제
DELETE FROM rentlist WHERE bnum=7;
DELETE FROM booklist WHERE booknum=7;

-- 해결방법 #2
-- 외래키 제약조건을 삭제한 후 다시 생성
-- 외래키 생성시에 "옵션을 추가해서"
-- "참조되는 값(parents record)이 삭제되면 참조하는 값(child record)도 같이 삭제"되게 구성합니다

-- 외래키 삭제
ALTER TABLE rentlist DROP CONSTRAINT fk1;

-- 새로운 외래키 추가
ALTER TABLE rentlist ADD CONSTRAINT fk1
FOREIGN KEY(bnum) REFERENCES booklist(booknum) ON DELETE CASCADE;


-- memberlist 테이블에서 회원 한명을 삭제하면, rentlist테이블에서도 해당회원이 대여한 기록을 같이 삭제하도록
-- 외래키 설정을 바꿔주세요(외래키 제약조건 삭제 후 재생성)
ALTER TABLE rentlist DROP CONSTRAINT fk2;
ALTER TABLE rentlist ADD CONSTRAINT fk2
FOREIGN KEY(mnum) REFERENCES memberlist(membernum) ON DELETE CASCADE;





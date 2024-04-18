--03_FUNCTION.ssql

--숫자 관련 함수
--ceiling(숫자) - 값보다 큰 정수 중 가장 작은 수 (올림)
--floor(숫자) - 값보다 작은 정수 중 가장 큰 수[실수를 무조건 버림(음수일 경우는 제외)
--round(숫자, 자리수) - 소수점 자리수만큼 남기고 아래서 반올림

--문자 관련 함수
--subString('문자열', 시작위치, 개수) - 문자열 중 시작 위치부터 개수만큼 출력
--lcase('문자열') or lower('문자열') - 소문자로 바꾼다
--ucase('문자열') or upper('문자열') - 대문자로 바꾼다
--reverse('문자열') - 문자열을 반대로 나열한다

update booklist set grade = upper(grade);
select*from booklist;




--날짜 관련 함수
--now() - 현재 날짜와 시간(datetime 형식)
--curdate() or current_date() - 현재 날짜(date 형식)
--curtime() or current_time() - 현재 시간(time 형식)

--date_add(날짜, interval 더할 숫자 기준값)
--날짜에서 기준값 단위로 더할 숫자 만큼 더한다
--기준값 : year, month, dat, hour, minute, second
select date_add(now(), interval 3 year) from dual;  --3년 후

--date_sub(날짜, interval 뺄숫자 기준값) - 날짜에서 기준값 단위로 뺄숫자만큼 뺀다


--year(날짜) - 날짜의 연도 추출
--month(날짜) - 날짜의 월 추출
--monthname(날짜) - 날짜의 월을 영어로 추출
--dayofmonth()날짜) - 날짜의 월별 일자 추출
--dayofweek(날짜) - 날짜의 주별 일자 추출 (일요일(1), 월요일(2)... 토요일(7))
--weekday(날짜) - 날짜의 주별 일자 추출 (월요일(0), 화요일(1)... 일요일(6))
select concat(year(now()), '년')as 년도 from dual;


--오라클 to_char(sysdate, 'yyyymmdd') 날짜 => 문자
--오라클 to_date('20230420', 'yyyymmdd') 문자 => 날짜

--MySQL
--date_format(now(), '%y%m%d') 날짜 => 문자
--str_to_date('20230420', '%y%m%d') 문자 => 날짜
select date_format(now(), '%y%m%d') from dual; --20231101
select str_to_date('20231013', '%y%m%d') from dual; --2021-10-13

--%a  요일(sun~sat)
--%b  월(jan~dec)
--%M  월(january~december)
--%c  월(0~12)
--%h  시간(00~12)
--%I  시간(00~12)

--&r 시간(12시)을 hh:mm:ss AM/PM 형식으로
--%T 시간(24시)을 hh:mm:ss 형식으로



--집계 함수(그룹 함수)
--count(필드명) - null 값이 아닌 레코드 수를 구한다
--sum(필드명) - 필드명의 합계를 구한다
--age(필드명) - 각각의 그룹 안에서 필드명의 평균값을 구한다
--max(필드명) - 최대값을 구한다
--min(필드명) - 최소값을 구한다

















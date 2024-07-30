-- 25_유용한 함수들.sql

/* 숫자 타입 함수들 */

-- TO_NUMBER(data) : 다른 타입 데이터를 숫자 타입으로 변환한다.
SELECT TO_NUMBER('12345') FROM dual;

-- 포맷을 사용해 형식이 있는 문자열도 숫자로 변환해줄 수 있다.
SELECT TO_NUMBER('10,000', '99,999') FROM dual;
SELECT TO_NUMBER('1,000,000', '9,999,999') FROM dual;
SELECT TO_NUMBER('$30000', '$9999') FROM dual;

-- ABS(num) : 절대값
SELECT abs(-10) FROM dual;

-- floor(num) : 내림
SELECT floor(123.123) FROM dual;

-- ceil(num) : 올림
SELECT ceil(123.123) FROM dual;

-- round(num, offset) : 반올림
SELECT round(123.1234, 2) FROM dual;
SELECT round(123.12555, 2) FROM dual;
SELECT round(123.12555, 0) FROM dual;
SELECT round(123.12555, -2) FROM dual;

-- trunc(num, offset) : 반올림하지 않고 잘라버리기
SELECT trunc(123.8888, 2) FROM dual;
SELECT round(123.8888, 2) FROM dual;
SELECT trunc(17777.8888, -3) FROM dual;
SELECT round(17777.8888, -3) FROM dual;


-- mod(n, m) : 나머지 연산
SELECT mod(10, 3) FROM dual;
SELECT mod(123, 10) FROM dual;

/* 문자 타입 함수들 */

-- TO_CHAR(data) : 다른 타입 데이터들을 문자 타입으로 변환
SELECT TO_CHAR(12345) FROM dual;
SELECT TO_CHAR(sysdate) FROM dual;

-- 숫자를 문자로 변환할 때 형식을 사용할 수 있다.
SELECT TO_CHAR(3000, '9,999') FROM dual;
SELECT TO_CHAR(3000, '$9,999') FROM dual;
SELECT TO_CHAR(3000, '9,999L') FROM dual;

-- 날짜를 문자로 변환할 때도 포맷을 사용할 수 있다.
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS') FROM dual;
SELECT TO_CHAR(hire_date, 'YYYY-MM-DD HH:MI:SS') FROM employees;

-- substr(str, start, length) : 문자 자르기(시작 위치부터 length개를 자른다)
SELECT substr('Hello, world!', 5, 5) FROM dual;

-- upper(str) : 대문자로 변환
-- lower(str) : 소문자로 변환
-- initcap(str) : 첫 글자만 대문자로 변환
SELECT upper('hello') FROM dual;
SELECT lower('HELLO') FROM dual;
SELECT initcap('hello') FROM dual;
SELECT initcap(email) FROM employees;

-- replace(str, old, new) : 문자 교체
SELECT replace('abc.jpg', '.jpg', '.gif') FROM dual;

-- lpad(str, full-length, char) : 원하는 문자를 왼쪽에 추가하여 데이터의 길이를 맞춰준다.
-- rpad(str, full-length, char) : 원하는 문자를 오른쪽에 추가하여 데이터의 길이를 맞춰준다.
SELECT lpad(first_name, 20, ' ') FROM employees;
SELECT rpad(first_name, 15, ' ') FROM employees;

-- ltrim(str, chars) : 왼쪽에 있는 원하는 문자들을 모두 제거해준다.
-- rtrim(str, chars) : 오른쪽에 있는 원하는 문자들을 모두 제거해준다.
SELECT ltrim('!!@@!!!!!Ellen', '!') FROM dual;
SELECT ltrim('!!@@!!!!!Ellen', '!@') FROM dual;
SELECT rtrim('Ellen====/', '/=') FROM dual;

/* 날짜 타입 함수들 */

-- TO_DATE(data) : 문자 데이터를 날짜 타입으로 변환
SELECT TO_DATE('1998/11/11') FROM dual;
SELECT TO_DATE('1998-11-11') FROM dual;
SELECT TO_DATE('1998+11+11') FROM dual;

-- 포맷을 사용해 문자 데이터를 날짜 타입으로 변환할 수도 있다.
SELECT TO_DATE('2002---09---09', 'YYYY---MM---DD') FROM dual;
SELECT TO_DATE('2002---09---09, 23:44:35', 'YYYY---MM---DD, HH24:MI:SS') FROM dual;

-- trunc(date) : 날짜 데이터를 원하는 단위로 잘라서 사용할 수 있다.
SELECT TO_CHAR(sysdate, 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'day'), 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'month'), 'YY/MM/DD, HH:MI:SS') FROM dual;
SELECT TO_CHAR(trunc(sysdate, 'year'), 'YY/MM/DD, HH:MI:SS') FROM dual;

-- 책 8장 : 테이블과 뷰(View)
-- 책 9장 : 인덱스(Index) - 일부 상황에서 탐색 속도가 증가, 기본키가 기본적으로 인덱스 역할을 함, 잘못하면 오히려 느려질 수 있음
-- 책 10장 : 스토어드 프로시저와 함수
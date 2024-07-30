-- 02_SELECT.sql

/*
    # SELECT 컬럼명 FROM 테이블명;
    
        - 원하는 테이블의 원하는 컬럼을 조회할 수 있는 쿼리문
        - 컬럼명 자리에 *를 쓰면 모든 컬럼을 조회할 수 있다.
        - 쿼리문, 컬럼명, 테이블명은 대소문자를 구분하지 않는다.
        - 데이터는 대소문자를 구분한다.
*/

SELECT * FROM employees;

SELECT email, phone_number FROM employees;
SELECT first_name, last_name FROM employees;
SELECT country_name FROM countries;

-- 쿼리문, 컬럼명, 테이블명은 대소문자를 구분하지 않는다.
select EMail, PhOnE_NuMBer FrOm eMpLOyEEs;

-- # 연습용 계정 HR에 미리 만들어져 있는 연습용 테이블들
SELECT * FROM tab;

SELECT * FROM countries; -- 국가 정보
SELECT * FROM employees; -- 사원 정보
SELECT * FROM departments; -- 부서 정보
SELECT * FROM jobs; -- 직책 정보
SELECT * FROM locations; -- 각 지점의 주소 정보
SELECT * FROM regions; -- 대륙 정보

-- 연습1 : 모든 부서의 부서번호와 부서명을 조회해보세요.
SELECT department_id, department_name FROM departments;
-- 연습2 : 모든 사원의 사원번호/이름/월급/고용일/부서번호를 조회해보세요.
SELECT employee_id, first_name, salary, hire_date, department_id FROM employees;
-- 연습3 : 모든 지점의 소속 도시 이름/주소/우편번호를 조회해보세요.
SELECT city, street_address, postal_code FROM locations;

/*
    # DESC 테이블명;
    
        - 해당 테이블에 어떤 컬럼들이 있는지 확인할 수 있는 명령어
        - 컬럼명, null값 허용 여부, 컬럼 타입을 확인할 수 있다.
        
    # NUMBER(n), NUMBER(n,m)
    
        - 숫자만 저장할 수 있는 컬럼 타입
        - 숫자가 하나만 설정되어 있으면 숫자의 길이를 의미한다.
          ex) NUMBER(3) : 0부터 999까지 넣을 수 있다.
        - 숫자가 두 개 설정되어 있으면 첫 번째 숫자는 숫자의 전체 길이를 의미하고 두 번째 숫자는 소수점 자릿수를 의미한다.
          ex) NUMBER(5,2) : 총 5자리인데 소수점은 2자리까지 넣을 수 있다.
              NUMBER(2,2) : 총 2자리인데 소수점을 2자리까지 넣을 수 있다.(소수만 가능)
              
    # VARCHAR2(n)
    
        - 길이가 일정하지 않은 문자열을 저장할 때 사용하는 컬럼 타입
        - 설정한 컬럼의 크기가 최대 길이가 되고 더 적은 길이의 문자열이 들어오는 경우 공간 낭비를 최소화해주도록 설계되어 있다.
        
    # CHAR(n)
    
        - 고정 길이 문자열을 저장할 때 사용하는 컬럼 타입
        - 설정한 컬럼 크기보다 더 적은 길이의 문자열이 들어와도 공간을 모두 차지하며 낭비한다.
        - 공간을 최적화하려는 작업을 하지 않기 때문에 속도는 더 빠를 수 있다.
          ex) 국가 코드(KR, EN, US, JP, ...) 데이터는 무조건 2글자이므로 VARCHAR2 타입 컬럼보다 CHAR 타입 컬럼이 더 어울린다.
          
    # DATE
    
        - 날짜 및 시간 데이터를 저장할 수 있는 컬럼 타입
*/

DESC countries;
DESC locations;
DESC employees;

-- # SELECT시 컬럼 이름 뒤에 AS를 사용해 원하는 이름으로 설정해 조회할 수 있다.
SELECT first_name AS 이름, last_name AS 성 FROM employees;
-- 별칭에 띄어쓰기를 사용하고 싶은 경우 ""로 묶어서 사용할 수 있다.
SELECT first_name AS 이름, hire_date AS "고용 날짜" FROM employees;

-- # 컬럼에 산술 연산자를 활용해 계산된 결과를 얻을 수 있다.
-- Ctrl + F7 : 세로로 정렬
SELECT
    first_name AS 이름,
    salary AS 월급,
    salary * 2 AS "두 달치 월급",
    salary * 3 AS "세 달치 월급",
    salary + 100 AS "보너스 받은 월급"
FROM
    employees;

SELECT first_name, salary * 12 AS 연봉 FROM employees;

-- # 여러 컬럼끼리의 계산 결과도 알 수 있다.
--   ※ null 대신 원하는 값을 사용하고 싶은 경우 NVL() 함수를 사용할 수 있다.
SELECT
    first_name AS 이름,
    salary AS 월급,
    NVL(commission_pct, 0) AS "보너스 비율",
    salary * NVL(commission_pct, 0) AS "보너스 금액"
FROM
    employees;
    
-- # 두 컬럼 이상의 값을 이어붙여서 조회하고 싶을 때 ||를 사용할 수 있다.
SELECT first_name || ' ' || last_name AS full_name FROM employees;

-- 연습 : 모든 사원들의 사원번호/풀네임/직책/연봉을 조회해보세요.
SELECT employee_id, first_name || ' ' || last_name AS full_name, salary * 12 AS annual_salary FROM employees;
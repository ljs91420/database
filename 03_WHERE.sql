-- 03_WHERE.sql

/*
    # SELECT 컬럼명 FROM 테이블명 WHERE 조건절;
    
        - SELECT문 뒤에 WHERE절을 추가하여 해당 조건을 만족하는 행만 조회할 수 있다.
        - 조건에 사용되는 데이터는 대소문자에 영향을 받는다.
        - 오라클의 비교 연산자와 논리 연산자를 사용하여 조건절을 만들 수 있다.
        
    # 비교 연산자
    
        = : 같으면 true, (==은 사용할 수 없다)
        !=, <>, ^= : 다르면 true
        >, <, <=, >= : 비교
    
    # 논리 연산자
    
        - AND, OR, NOT
*/

-- 숫자 타입 값의 크기 비교
SELECT * FROM employees WHERE salary > 20000;
SELECT * FROM employees WHERE salary >= 10000 AND commission_pct > 0;
SELECT * FROM employees WHERE department_id = 100;

-- 문자 타입 값의 크기 비교 (사전순으로 크기 비교)
SELECT * FROM employees WHERE first_name >= 'N';
SELECT * FROM employees WHERE last_name < 'C';

-- 날짜 타입의 크기 비교 (더 작으면 이전 시간, 더 크면 뒤의 시간)
SELECT * FROM employees WHERE hire_date < '2006/01/01';
SELECT * FROM employees WHERE hire_date < '2005/01/01';
SELECT * FROM employees WHERE hire_date >= '2008/01/01';

-- AND, OR, NOT 활용

-- 사원 번호가 150번 보다 작고, 동시에 부서번호가 50번인 사원들만 조회
SELECT * FROM employees WHERE employee_id < 150 AND department_id = 50;

-- 부서번호가 30번이거나 50번이거나 80번인 사원 조회
SELECT * FROM employees WHERE department_id = 30 OR department_id = 50 OR department_id = 80;

-- 부서번호가 80번인 사원들만 제외하고 조회
SELECT * FROM employees WHERE NOT department_id = 80;
SELECT * FROM employees WHERE department_id != 80;
SELECT * FROM employees WHERE department_id <> 80;
SELECT * FROM employees WHERE department_id ^= 80;

-- 연습1 : 월급이 2000에서 3000 사이인 사원들의 이름, 월급, 직책을 조회해보세요.
SELECT first_name, salary, job_id FROM employees WHERE salary >= 2000 AND salary <= 3000;

-- 연습2 : 30, 60, 100번 부서에 속한 사원들의 이름, 전화번호, 부서번호를 조회해보세요.
SELECT first_name, phone_number, department_id FROM employees WHERE department_id = 30 OR department_id = 60 OR department_id = 100;

-- # 컬럼명 BETWEEN A AND B : 해당 컬럼 값이 A와 B 사이인 경우 true
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000;

-- # 컬럼명 IN (A, B, C, ...) : () 안의 내용 중에 해당 값이 있으면 true
SELECT * FROM employees WHERE department_id IN (30, 60, 100);

-- # 커미션을 받지 않는 사원들을 조회하고 싶은 경우

-- null 값은 일반적인 비교 연산자로는 크기 비교가 아예 불가능하다.
SELECT * FROM employees WHERE commission_pct = null;
SELECT * FROM employees WHERE commission_pct != null;

-- 해결책1 : nvl을 쓴다.
SELECT * FROM employees WHERE nvl(commission_pct, 0) != 0;
SELECT * FROM employees WHERE nvl(commission_pct, 0) = 0;

-- 해결책2 : null값은 is로 비교할 수 있다.
SELECT * FROM employees WHERE commission_pct IS NULL;

-- NOT을 여러 자리에 활용할 수 있다.
SELECT * FROM employees WHERE commission_pct IS NOT NULL;
SELECT * FROM employees WHERE NOT commission_pct IS NULL;

/*
    # 조건에 LIKE 사용하기
    
        - LIKE를 사용하면 데이터의 일부분이 일치하는 행을 조회할 수 있다.
        - % : 길이 제한 없이 아무 문자나 있어도 되는 자리
        - _ : 아무 문자나 한 글자가 반드시 존재해야 하는 자리
*/

SELECT * FROM employees;
SELECT * FROM employees WHERE first_name = 'Steven';
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'S%';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%y';

-- first_name의 아무 곳에나 소문자 t가 등장하는 사원들을 조회
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t%';

-- first_name의 뒤에서 두 번째 자리에 t가 등장하는 사원들을 조회
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t_';

-- first_name의 뒤에서 세 번째 자리에 t가 등장하는 사원들을 조회
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t__';

-- 날짜 컬럼에도 LIKE를 사용할 수 있다.
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/06/%';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/30';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '02/%';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/_2/%';

-- 숫자 컬럼에도 LIKE를 사용할 수 있다.(보통은 크기 비교가 더 편함)
SELECT first_name, salary FROM employees WHERE salary LIKE '3%';

-- 연습1 : first_name의 뒤에서 세 번째 글자가 a인 모든 사원들의 이름과 월급을 조회
SELECT first_name, salary FROM employees WHERE first_name LIKE '%a__';

-- 연습2 : first_name에 e가 두 개 이상 포함된 사원들의 이름과 직책을 조회
-- ※ first_name의 첫 글자가 대문자이기 때문에 소문자로 바꿔서 비교해주면 이름이 E로 시작하는 사원도 조회가 가능하다.
SELECT upper(first_name) FROM employees; -- upper() : 값을 대문자로 변환하는 함수
SELECT lower(first_name) FROM employees; -- lower() : 값을 소문자로 변환하는 함수
SELECT first_name, job_id FROM employees WHERE lower(first_name) LIKE '%e%e%';

-- 연습3 : first_name이 다섯 글자이면서 r로 끝나는 사원들의 이름과 전화번호를 조회
SELECT first_name, phone_number FROM employees WHERE first_name LIKE '____r';

-- 연습4 : 8월에 입사한 사원들의 이름과 고용일을 조회
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/08/%';
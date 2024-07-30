-- 13_서브 쿼리.sql

/*
    # 서브 쿼리
    
        - 쿼리문 내부에 포함된 또 다른 쿼리문
        - 서브 쿼리를 포함하고 있는 쿼리를 메인 쿼리라고 한다.
        - 서브 쿼리의 실행 결과에 따라 단일 행 서브 쿼리와 다중 행 서브 쿼리로 구분된다.
        - 서브 쿼리는 컬럼, 조건, 테이블로 활용될 수 있다.
        
    # 단일 행 서브 쿼리
    
        - 서브 쿼리의 결과가 단 하나의 행을 가진 경우
        - 주로 기본키와 함께 활용되는 경우가 많다.
        - 단일 값끼리 비교하는 일반 연산자를 사용할 수 있다.
        
    # 다중 행 서브 쿼리
    
        - 서브 쿼리의 결과가 2행 이상인 경우
        - 일반 연산자가 아니라 다중 행 전용 연산자를 사용해야 한다.
          (IN, ANY, SOME, ALL, EXISTS)
*/

-- 1. 서브 쿼리가 조건으로 활용되는 경우

-- e.g. 120번 사원과 같은 돈을 받는 사원을 조회하고 싶은 경우
SELECT * FROM employees WHERE salary = (SELECT salary FROM employees WHERE employee_id = 120);

-- e.g. IT 개발자들 중 가장 돈을 적게 받는 사원보다 적게 받는 사원들을 조회
SELECT * FROM employees WHERE salary < (SELECT MIN(salary) FROM employees WHERE job_id = 'IT_PROG');

-- 2. 서브 쿼리가 컬럼 자리에서 활용되는 경우
SELECT employee_id, first_name, (SELECT job_title FROM jobs WHERE job_id = employees.job_id) AS job_title FROM employees;

-- 3. 테이블 자리에서 서브 쿼리가 활용되는 경우
SELECT first_name, department_id FROM (SELECT * FROM employees WHERE department_id = 80) WHERE first_name LIKE 'A%';

-- 단일 행 서브 쿼리는 주로 해당 테이블의 기본키를 사용한다.
SELECT * FROM employees WHERE salary = (SELECT salary FROM employees WHERE employee_id = 120);

-- 다중 행 서브 쿼리는 실행 시 여러 줄이 나오는 서브 쿼리를 의미한다.
-- 다중 행 서브 쿼리는 연산 시 다중 행 연산자를 사용해야 한다.

-- # IN
-- e.g. Steven이라는 사람이 속해있는 직책의 모든 사원들을 조회
SELECT * FROM employees WHERE job_id IN (SELECT DISTINCT job_id FROM employees WHERE first_name = 'Steven');

-- # ANY, SOME : 여러 값들 중 조건을 만족시키는 값이 하나라도 있으면 true
-- e.g. IT 개발자들 중 가장 늦게 들어온 사원보다 일찍 들어온 사원들을 조회
SELECT * FROM employees WHERE hire_date < ANY(SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

-- IT 개발자보다 더 많이 받는 사원들을 조회
SELECT * FROM employees WHERE salary > SOME(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

-- e.g. IT 개발자와 같은 날에 들어온 사원을 조회
SELECT * FROM employees WHERE hire_date = ANY(SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

SELECT * FROM employees WHERE hire_date IN (SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

-- # ALL : 조건이 서브 쿼리의 모든 값을 만족시켜야 true

-- e.g. IT 개발자 중에 가장 많이 받는 사원보다 더 받는 사원을 조회
SELECT * FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

SELECT * FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'IT_PROG');

-- # EXISTS : 한 행이라도 조회되면 true

-- e.g. 부서가 존재하는 지역만 조회
SELECT * FROM locations WHERE EXISTS(SELECT * FROM departments WHERE location_id = locations.location_id);
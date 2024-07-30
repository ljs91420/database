-- 07_그룹 함수.sql

/*
    # 그룹 함수
    
        - 하나의 컬럼을 기준으로 삼아 다른 컬럼들의 여러 행들을 하나로 합쳐 조회하는 것
        - 그룹화의 기준이 되는 컬럼을 GROUP BY절을 통해 선택할 수 있다.
        - 그룹 함수를 사용하면 그룹의 기준이 아닌 일반 컬럼은 함께 출력할 수 없다.
*/

-- # SUM(column) : 해당 컬럼의 총합을 구해주는 그룹 함수

-- 모든 사원들의 월급의 총합(그룹화되지 않음)
SELECT SUM(salary) FROM employees; 

-- 직책별 월급의 총합
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;

-- 부서별 월급의 총합
SELECT department_id, SUM(salary) FROM employees GROUP BY department_id;

-- # AVG(column) : 해당 컬럼의 평균값을 구하는 그룹 함수
-- # COUNT(column) : 해당 컬럼의 행의 개수를 구하는 그룹 함수 (null을 제외하고 센다)

-- 부서별 월급의 총합과 평균을 구해보는 쿼리문
SELECT
    department_id,
    SUM(salary)   AS 총합,
    COUNT(salary) AS "월급받는 사람 수",
    AVG(salary)   AS "평균 월급"
FROM
    employees
GROUP BY
    department_id;
    
-- # MAX(column) : 해당 컬럼에서 가장 큰 값을 구한다.
-- # MIN(column) : 해당 컬럼에서 가장 작은 값을 구한다.

-- 직책별로 돈을 가장 많이 받는 사원의 금액과, 가장 적게 받는 사원의 금액을 조회
SELECT
    job_id,
    MAX(salary) AS "제일 많이 받는 사람",
    MIN(salary) AS "제일 적게 받는 사람"
FROM
    employees
GROUP BY
    job_id;
    
-- 연습1 : 각 직책별 평균 연봉을 구해보세요(월급 아니고 연봉)
SELECT job_id, AVG(salary * 12) AS "직책별 평균 연봉" FROM employees GROUP BY job_id;

-- 연습2 : 각 부서별로 가장 오래 전 사원이 입사한 날짜와 가장 최근에 사원이 입사한 날짜를 조회해보세요.
SELECT
    department_id,
    MIN(hire_date) AS "오래된 사원",
    MAX(hire_date) AS "신선한 사원"
FROM
    employees
GROUP BY
    department_id;
    
/*
    # HAVING절
    
        - 그룹화 이후의 결과를 사용해 조건을 적용하고 싶은 경우 사용하는 문법
        - WHERE절의 조건은 그룹화 전에 미리 행들을 거르게 되고 HAVING절의 조건은 그룹화 이후의 값들을 사용하게 된다.
*/

SELECT * FROM employees;

-- ex) 직책별 평균 월급이 10000달러 이상인 직책들 조회해보기
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id HAVING AVG(salary) >= 10000;

-- ex) 직책별 평균 월급이 10000달러 미만인 직책들 조회해보기
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id HAVING AVG(salary) < 10000;

-- WHERE절을 사용하면 월급이 10000달러 이상인 사원들로만 직책별 평균을 내게 된다.
SELECT job_id, AVG(salary) FROM employees WHERE salary >= 10000 GROUP BY job_id;

-- ex) 2006년 이전에 입사한 사원들의 부서별 평균 월급을 구하되 2명 이하인 경우는 조회하지 말 것
SELECT
    department_id,
    AVG(salary),
    COUNT(salary)
FROM
    employees
WHERE
    hire_date < '06/01/01'
GROUP BY
    department_id
HAVING
    COUNT(salary) > 2;
    
-- 연습1 : 직책별 평균 월급이 10000달러 미만인 각 직책의 사원 수를 조회해보세요.
SELECT job_id, COUNT(*) FROM employees GROUP BY job_id HAVING AVG(salary) < 10000;

-- 연습2 : 2007년에 입사한 사원들이 부서별로 몇 명씩 있는지 조회하되, 2007년에 입사한 사원들이 5명 미만인 부서는 조회되지 않도록 해보세요.
SELECT
    department_id,
    COUNT(*)
FROM
    employees
WHERE
    hire_date LIKE '07%'
GROUP BY
    department_id
HAVING
    COUNT(*) >= 5;
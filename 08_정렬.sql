-- 08_정렬.sql

/*
    # ORDER BY 컬럼명 [ASC|DESC]
    
        - 조회시 원하는 컬럼을 기준으로 정렬하여 출력할 수 있다.
        - ASC : 오름차순(Ascending)
        - DESC : 내림차순(Decending)
        - ASC 또는 DESC 입력 생략시 기본적으로 ASC로 정렬된다.
*/

SELECT * FROM employees ORDER BY first_name ASC;
SELECT * FROM employees ORDER BY first_name DESC;

-- 오름차순 할 때는 null이 가장 나중에 등장한다.
SELECT first_name, job_id, commission_pct FROM employees 
WHERE commission_pct IS NOT NULL ORDER BY commission_pct ASC; -- WHERE는 ORDER BY보다 앞에 써야 한다.
-- 내림차순 할 때는 null이 먼저 등장한다.
SELECT first_name, job_id, commission_pct FROM employees ORDER BY commission_pct DESC;

-- 정렬 기준을 여러 개 설정할 수도 있다.
SELECT first_name, job_id, department_id, salary FROM employees ORDER BY department_id, salary DESC, first_name;

-- 연습1 : 이름에 i가 포함되어 있는 사원들을 가장 오래 전 입사한 사람부터 조회해보기
SELECT * FROM employees WHERE lower(first_name) LIKE '%i%' ORDER BY hire_date;

-- 연습2 : 모든 사원들을 성 기준으로 오름차순 정렬하고, 성이 같은 경우 이름으로 다시 한 번 오름차순 정렬하여 조회해보기
SELECT * FROM employees ORDER BY last_name, first_name;

-- 연습3 : 각 부서의 평균 월급, 사원 수를 조회하고 사원 수를 기준으로 내림차순 정렬하고, 사원 수가 같으면 평균 월급을 기준으로 내림차순 정렬하여 조회
SELECT department_id, AVG(salary), COUNT(*) FROM employees GROUP BY department_id ORDER BY COUNT(*) DESC, AVG(salary) DESC;
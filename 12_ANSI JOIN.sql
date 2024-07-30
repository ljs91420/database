-- 12_ANSI JOIN.sql

/*
    # ANSI JOIN 
    
        - ANSI에서 지정한 표준 JOIN 문법
        - 다른 관계형 데이터베이스에서도 사용할 수 있는 문법
        
        * ANSI (American National Standard Institute : 미국 국제 표준 기구)
*/

-- # CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

/*
    # INNER JOIN (조인 조건을 충족하는 행만 등장하는 것)
    
        - OUTER JOIN의 반대 개념
        - 조인 조건에는 ON절을 사용하고 다른 조건에는 WHERE절을 사용해 두 조건을 분리할 수 있다.
        - 조인하는 두 테이블이 조인하기 위해 사용하는 컬럼명이 같다면 ON 대신 USING을 사용할 수 있다.
        - USING을 사용했을 때는 조인에 사용된 키 컬럼을 자동으로 하나로 합쳐준다.
*/

SELECT * FROM employees e INNER JOIN departments d ON e.department_id = d.department_id WHERE salary < 5000;
SELECT * FROM employees e INNER JOIN departments d USING (department_id) WHERE salary < 5000;

-- ANSI JOIN을 사용하여 다음을 풀어보세요.

-- 연습1 : 월급이 9000달러 이하인 사원들의 사번/이름/부번/부서명을 조회해보세요.
SELECT employee_id, first_name, department_id, department_name FROM employees INNER JOIN departments USING (department_id) 
WHERE salary <= 9000 ORDER BY department_id;

-- 연습2 : 부서명이 IT인 사원들의 사번/이름/부서명/직책명(job_title)을 조회해보세요.
SELECT employee_id, first_name, department_name, job_title FROM employees INNER JOIN departments USING (department_id)
INNER JOIN jobs USING (job_id) WHERE department_name = 'IT';

-- 연습3 : 커미션을 받는 사원들의 사번/이름/부서명/직책명을 조회해보세요.
SELECT employee_id, first_name, department_name, job_title FROM employees INNER JOIN departments USING (department_id)
INNER JOIN jobs USING (job_id) WHERE commission_pct IS NOT NULL;

-- 연습4 : 시애틀(Seattle)에서 근무하는 사원들의 이름/부서명/주소/도시명을 조회해보세요.
SELECT first_name, department_name, street_address, city FROM employees INNER JOIN departments USING (department_id)
INNER JOIN locations USING (location_id) WHERE city = 'Seattle';

/*
    # ANSI OUTER JOIN (조건을 충족하지 못한 행도 등장시키는 것)
    
        1. LEFT OUTER JOIN : 등장하지 못했던 왼쪽 테이블의 데이터가 등장한다(오른쪽 테이블의 행에 +붙인 것과 같음)
        2. RIGHT OUTER JOIN : 등장하지 못했던 오른쪽 테이블의 데이터가 등장한다(왼쪽 테이블의 행에 +붙인 것과 같음)
        3. FULL OUTER JOIN : 양쪽 테이블에 +를 붙인 효과가 있다.
*/

-- LEFT OUTER JOIN을 하면 부서가 아직 배정되지 않았던 사원이 한 명 추가로 조회됨
SELECT * FROM employees LEFT OUTER JOIN departments USING (department_id);

-- RIGHT OUTER JOIN을 하면 배정된 사원이 없어서 등장하지 못했던 부서들이 추가로 등장한다.
SELECT * FROM employees RIGHT OUTER JOIN departments USING (department_id);

-- FULL OUTER JOIN은 LEFT/RIGHT OUTER JOIN 모두를 적용한 결과가 조회된다.
-- (부서가 없어서 등장하지 못했던 사원들 + 소속 사원이 없어서 등장하지 못했던 부서들)
SELECT * FROM employees FULL OUTER JOIN departments USING (department_id);

-- 연습1 : 모든 사원들의 이름/직책명/매니저 이름/매니저 직책명을 조회하되 매니저가 없는 사원도 추가로 조회해보세요.
SELECT emp.first_name AS "사원 이름", j1.job_title AS "사원의 직책명", mgr.first_name AS "매니저 이름", j2.job_title AS "매니저의 직책명"
FROM employees emp LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id
LEFT OUTER JOIN jobs j1 ON emp.job_id = j1.job_id LEFT OUTER JOIN jobs j2 ON emp.job_id = j2.job_id;

-- 연습2 : 모든 도시의 도시 이름/주소/소속 부서 존재 여부를 조회해보세요.
SELECT location_id, city, street_address, 'T' AS dept_exists FROM locations 
WHERE location_id IN (SELECT location_id FROM departments GROUP BY location_id)
UNION
SELECT location_id, city, street_address, 'F' AS dept_exists FROM locations 
WHERE NOT location_id IN (SELECT location_id FROM departments GROUP BY location_id)
ORDER BY location_id;

SELECT location_id, COUNT(*) FROM departments GROUP BY location_id;

-- # SELECT DISTINCT : 중복을 제거하면서 조회한다.
SELECT department_id, department_name, location_id FROM departments;

SELECT location_id FROM departments;

-- location_id의 중복값을 제거하는 두 가지 방식
SELECT DISTINCT location_id FROM departments;
SELECT location_id FROM departments GROUP BY location_id;

-- 중복되지 않는 컬럼이 함께 있다면 중복을 제거하지 못한다.
SELECT DISTINCT location_id, department_name FROM departments;

SELECT DISTINCT
    city,
    street_address,
    CASE
        WHEN department_id IS NULL THEN 'F'
        ELSE 'T'
    END AS dept_exists
FROM
    locations
    LEFT OUTER JOIN departments USING ( location_id );
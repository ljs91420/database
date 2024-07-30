-- 09_JOIN.sql

/*
    # 기본키 (Primary Key, PK)
    
        - 한 테이블에서 하나의 행을 유일하게 구분할 수 있는 컬럼(e.g. employee_id)
        - 각 테이블에 여러 개의 기본키 후보가 있더라도 기본키는 하나 밖에 설정할 수 없다.
        - 기본키로 설정하려는 컬럼에는 중복된 값을 가진 행이 없어야 한다.(UNIQUE)
        - 기본키로 설정하려는 컬럼에는 NULL 값이 없어야 한다.(NOT NULL)
        
    # 후보키 (Candidate Key)
    
        - 기본키가 될 자격을 갖추었지만 기본키로 선택되지 않은 컬럼
    
    # 외래키
    
        - 다른 테이블의 기본키를 가져와 일반 컬럼으로 사용한 컬럼
          (e.g. 부서(departments) 테이블의 기본키(department_id)를 사원 테이블에서는 중복값을 허용하는 외래키 컬럼으로 사용하였다)
        - 외래키 컬럼에 들어가는 값은 반드시 참조하는 기본키 컬럼에 이미 존재하고 있는 값이어야 한다.(참조 무결성)
          (e.g. 부서(departments) 테이블에 존재하지 않는 7777번 부서를 외래키 컬럼인 employees.department_id의 값으로 사용할 수 없다)
        - 한 테이블의 기본키가 다른 테이블의 외래키로 설정되었다면 두 테이블 간에는 1:N 관계(일대다 관계)가 형성되었다고 볼 수 있다.
        
    # 개체 간 관계의 종류
    
        - 1:1 관계 : 같은 테이블 안에 컬럼으로 넣어주면 된다.
        - 1:N 관계 : 부서-사원, 글-댓글, 회원-작성글, 직장 상사-사원
        - N:N 관계 : 선생-학생, 손님-메뉴, 라이더-가게
                    (N:N 관계는 바람직하지 않아서 제거 대상이 된다.)
                    
    # JOIN
    
        - 기본키와 외래키로 관계가 형성되어 있는 두 테이블 이상의 정보를 종합하여 조회하는 것
        - CROSS JOIN
        - EQUI JOIN
        - NON-EQUI JOIN
        - SELF JOIN
        - INNER JOIN
        - OUTER JOIN
*/

/*
    # CROSS JOIN
    
        - 두 테이블의 모든 행을 조회하여 나올 수 있는 모든 경우의 수를 조회하는 JOIN
        - 그냥 다 조합해보았을 뿐인 쓸데없는 정보
*/

SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
SELECT * FROM employees, departments; -- 2889 rows (107 * 27)

/*
    # EQUI JOIN
    
        - 두 테이블에서 서로 동일한 값을 지닌 컬럼들(주로 기본키와 외래키)로 CROSS JOIN에서 의미 있는 데이터를 걸러낸 JOIN
*/

-- CROSS JOIN의 결과물로부터 두 department_id가 같은 행만 조회한다. -> 의미 있는 데이터
SELECT * FROM employees, departments WHERE employees.department_id = departments.department_id;

-- 사원 테이블에 있는 컬럼과 부서 테이블에 있는 컬럼을 엮어서 조회할 수 있다.
SELECT first_name, last_name, department_name FROM employees, departments 
WHERE employees.department_id = departments.department_id;

-- 두 테이블에 같은 이름으로 존재하는 컬럼이 있으면 명확하게 테이블 이름까지 명시해야 한다.
-- (column ambiguously defined : 컬럼이 애매하게 정의되어 있음)
SELECT first_name, last_name, employees.department_id, department_name 
FROM employees, departments 
WHERE employees.department_id = departments.department_id;

-- 연습1 : 월급이 9000달러 이하인 사원들의 사번/이름/부번/부서명을 조회해보세요.
SELECT employee_id, first_name, employees.department_id, department_name FROM employees, departments 
WHERE salary <= 9000 AND employees.department_id = departments.department_id ORDER BY department_id;

-- 연습2 : 부서명이 IT인 사원들의 사번/이름/부서명/직책명(job_title)을 조회해보세요.

SELECT * FROM jobs;

-- ※ 테이블명 뒤에 별칭을 만들어 놓고 사용할 수 있다.
SELECT employee_id, first_name, department_name, job_title FROM employees emp, departments dept, jobs
WHERE department_name = 'IT' AND emp.department_id = dept.department_id AND emp.job_id = jobs.job_id;

-- 연습3 : 커미션을 받는 사원들의 사번/이름/부서명/직책명을 조회해보세요.
SELECT
    employee_id,
    first_name,
    department_name,
    job_title
FROM
    employees e,
    departments d,
    jobs j
WHERE
    commission_pct IS NOT NULL
    AND e.department_id = d.department_id
    AND e.job_id = j.job_id;

-- 연습4 : 시애틀(Seattle)에서 근무하는 사원들의 이름/부서명/주소/도시명을 조회해보세요.
SELECT
    first_name,
    department_name,
    street_address,
    city
FROM
    employees e,
    departments d,
    locations l
WHERE
    city = 'Seattle'
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id;
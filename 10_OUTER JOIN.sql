-- 10_OUTER JOIN.sql

/*
    # OUTER JOIN
        
        - JOIN 조건을 만족하지 못해서 등장하지 못하는 행을 추가로 확인할 수 있는 JOIN
        - (+)를 붙인 조건 쪽에 null을 추가하여 등장하지 못했던 행을 추가로 조회할 수 있다.
        - 기본키 컬럼은 null을 허용하지 않지만 외래키 컬럼에는 null을 허용하기 때문에
          조회되지 않는 경우가 존재할 수 있다.(e.g. 아직 부서가 배정되지 않은 사원)
*/

SELECT * FROM employees e, departments d 
WHERE
-- 부서에 null을 추가해서라도 등장하지 못한 사원을 보고 싶다면 부서 쪽에 (+)
-- 사원에 null을 추가해서라도 등장하지 못한 부서를 보고 싶다면 사원 쪽에 (+)
e.department_id(+) = d.department_id;

-- 연습1 : 부번/부서명/주소/도시를 출력하되 소속된 부서가 없는 도시들도 함께 조회해보세요.
SELECT department_id, department_name, street_address, city FROM departments d, locations l WHERE d.location_id(+) = l.location_id;

-- 연습2 : 소속된 사원이 없는 부서만 조회해보세요.
SELECT * FROM employees e, departments d WHERE e.department_id(+) = d.department_id AND employee_id IS NULL;
-- 14_rownum.sql

/*
    # rownum
    
        - 각 테이블에 숨겨져 있는 행 번호 컬럼
        - 원하는 만큼의 행을 조회하기 위해 활용할 수 있다.
*/

SELECT rownum, first_name, salary FROM employees;

SELECT first_name, salary FROM employees ORDER BY salary DESC;
-- e.g. 월급을 많이 받는 순으로 10명 조회
SELECT first_name, salary FROM employees WHERE rownum <= 10 ORDER BY salary DESC; -- 잘 안 되고 있음

-- WHERE절의 조건이 ORDER BY보다 먼저 적용되기 때문에 rownum으로 10개를 먼저 거른 후 정렬을 수행하게 된다.

-- 서브 쿼리를 사용해 정렬된 SELECT 결과(인라인 뷰)를 먼저 생성하고 rownum을 매겨야 한다.
-- 그 후 메인 쿼리에서 WHERE절로 조건을 적용하여 조회할 수 있다.
SELECT rownum, emp.* FROM (SELECT * FROM employees ORDER BY salary DESC) emp WHERE rownum <= 10;

-- e.g. 월급 순위 20등 ~ 30등을 조회하고 싶은 경우
SELECT rownum, first_name FROM employees WHERE rownum >= 20 AND rownum <= 30;

-- WHERE절 조건에 rownum이 20보다 커야 한다는 조건이 있는데, rownum1이 해당 조건을 만족하지 못하여 해당 행이 삭제되고 다음 행이 다시 rownum1이 된다.

-- rownum을 내부의 서브 쿼리에서 붙이려고 했더니 rownum이 먼저 붙고 그 후 정렬이 되는 문제가 있다.
SELECT * FROM (SELECT rownum rn, employees.* FROM employees ORDER BY salary DESC);

-- 가장 안쪽 서브 쿼리에서 정렬을 먼저 수행하고 그 다음 서브 쿼리에서 rownum을 붙여 해당 문제를 해결할 수 있다.
-- 그 후 rn으로 이름 붙여놓은 rownum을 메인 쿼리에서 조건으로 활용하면 조회가 가능하다.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY salary DESC) emp) WHERE rn >= 20 AND rn <= 30;

-- 연습1 : 회사에 다닌지 가장 오래된 사원을 5명만 조회해보세요.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn <= 5;

-- 연습2 : 회사에 다닌지 15번째로 오래된 사원을 1명 조회해보세요.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn = 15;

-- 연습3 : 회사에 다닌지 30 ~ 39번째로 오래된 사원을 10명 조회해보세요.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn >= 30 AND rn <= 39;
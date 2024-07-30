-- 04_집합.sql

SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'; -- 3rows
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%'; -- 9rows

-- INTERSECT : 교집합
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
INTERSECT
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- ※ 위의 결과와 완전히 같은 것
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%' AND last_name LIKE 'B%';

-- UNION : 합집합 (중복행 제거, 교집합에 해당하는 행을 한 번만 등장하게 함)
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
UNION
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- UNION ALL : 합집합 (중복행 제거 안 함)
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
UNION ALL
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- MINUS : 차집합
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
MINUS
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%'
MINUS
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%';
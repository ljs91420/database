-- 04_����.sql

SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'; -- 3rows
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%'; -- 9rows

-- INTERSECT : ������
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
INTERSECT
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- �� ���� ����� ������ ���� ��
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%' AND last_name LIKE 'B%';

-- UNION : ������ (�ߺ��� ����, �����տ� �ش��ϴ� ���� �� ���� �����ϰ� ��)
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
UNION
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- UNION ALL : ������ (�ߺ��� ���� �� ��)
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
UNION ALL
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

-- MINUS : ������
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%'
MINUS
SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%';

SELECT first_name, last_name FROM employees WHERE last_name LIKE 'B%'
MINUS
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'E%';
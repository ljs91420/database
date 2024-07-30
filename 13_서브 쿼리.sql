-- 13_���� ����.sql

/*
    # ���� ����
    
        - ������ ���ο� ���Ե� �� �ٸ� ������
        - ���� ������ �����ϰ� �ִ� ������ ���� ������� �Ѵ�.
        - ���� ������ ���� ����� ���� ���� �� ���� ������ ���� �� ���� ������ ���еȴ�.
        - ���� ������ �÷�, ����, ���̺�� Ȱ��� �� �ִ�.
        
    # ���� �� ���� ����
    
        - ���� ������ ����� �� �ϳ��� ���� ���� ���
        - �ַ� �⺻Ű�� �Բ� Ȱ��Ǵ� ��찡 ����.
        - ���� ������ ���ϴ� �Ϲ� �����ڸ� ����� �� �ִ�.
        
    # ���� �� ���� ����
    
        - ���� ������ ����� 2�� �̻��� ���
        - �Ϲ� �����ڰ� �ƴ϶� ���� �� ���� �����ڸ� ����ؾ� �Ѵ�.
          (IN, ANY, SOME, ALL, EXISTS)
*/

-- 1. ���� ������ �������� Ȱ��Ǵ� ���

-- e.g. 120�� ����� ���� ���� �޴� ����� ��ȸ�ϰ� ���� ���
SELECT * FROM employees WHERE salary = (SELECT salary FROM employees WHERE employee_id = 120);

-- e.g. IT �����ڵ� �� ���� ���� ���� �޴� ������� ���� �޴� ������� ��ȸ
SELECT * FROM employees WHERE salary < (SELECT MIN(salary) FROM employees WHERE job_id = 'IT_PROG');

-- 2. ���� ������ �÷� �ڸ����� Ȱ��Ǵ� ���
SELECT employee_id, first_name, (SELECT job_title FROM jobs WHERE job_id = employees.job_id) AS job_title FROM employees;

-- 3. ���̺� �ڸ����� ���� ������ Ȱ��Ǵ� ���
SELECT first_name, department_id FROM (SELECT * FROM employees WHERE department_id = 80) WHERE first_name LIKE 'A%';

-- ���� �� ���� ������ �ַ� �ش� ���̺��� �⺻Ű�� ����Ѵ�.
SELECT * FROM employees WHERE salary = (SELECT salary FROM employees WHERE employee_id = 120);

-- ���� �� ���� ������ ���� �� ���� ���� ������ ���� ������ �ǹ��Ѵ�.
-- ���� �� ���� ������ ���� �� ���� �� �����ڸ� ����ؾ� �Ѵ�.

-- # IN
-- e.g. Steven�̶�� ����� �����ִ� ��å�� ��� ������� ��ȸ
SELECT * FROM employees WHERE job_id IN (SELECT DISTINCT job_id FROM employees WHERE first_name = 'Steven');

-- # ANY, SOME : ���� ���� �� ������ ������Ű�� ���� �ϳ��� ������ true
-- e.g. IT �����ڵ� �� ���� �ʰ� ���� ������� ���� ���� ������� ��ȸ
SELECT * FROM employees WHERE hire_date < ANY(SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

-- IT �����ں��� �� ���� �޴� ������� ��ȸ
SELECT * FROM employees WHERE salary > SOME(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

-- e.g. IT �����ڿ� ���� ���� ���� ����� ��ȸ
SELECT * FROM employees WHERE hire_date = ANY(SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

SELECT * FROM employees WHERE hire_date IN (SELECT hire_date FROM employees WHERE job_id = 'IT_PROG');

-- # ALL : ������ ���� ������ ��� ���� �������Ѿ� true

-- e.g. IT ������ �߿� ���� ���� �޴� ������� �� �޴� ����� ��ȸ
SELECT * FROM employees WHERE salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG');

SELECT * FROM employees WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'IT_PROG');

-- # EXISTS : �� ���̶� ��ȸ�Ǹ� true

-- e.g. �μ��� �����ϴ� ������ ��ȸ
SELECT * FROM locations WHERE EXISTS(SELECT * FROM departments WHERE location_id = locations.location_id);
-- 12_ANSI JOIN.sql

/*
    # ANSI JOIN 
    
        - ANSI���� ������ ǥ�� JOIN ����
        - �ٸ� ������ �����ͺ��̽������� ����� �� �ִ� ����
        
        * ANSI (American National Standard Institute : �̱� ���� ǥ�� �ⱸ)
*/

-- # CROSS JOIN
SELECT * FROM employees CROSS JOIN departments;

/*
    # INNER JOIN (���� ������ �����ϴ� �ุ �����ϴ� ��)
    
        - OUTER JOIN�� �ݴ� ����
        - ���� ���ǿ��� ON���� ����ϰ� �ٸ� ���ǿ��� WHERE���� ����� �� ������ �и��� �� �ִ�.
        - �����ϴ� �� ���̺��� �����ϱ� ���� ����ϴ� �÷����� ���ٸ� ON ��� USING�� ����� �� �ִ�.
        - USING�� ������� ���� ���ο� ���� Ű �÷��� �ڵ����� �ϳ��� �����ش�.
*/

SELECT * FROM employees e INNER JOIN departments d ON e.department_id = d.department_id WHERE salary < 5000;
SELECT * FROM employees e INNER JOIN departments d USING (department_id) WHERE salary < 5000;

-- ANSI JOIN�� ����Ͽ� ������ Ǯ�����.

-- ����1 : ������ 9000�޷� ������ ������� ���/�̸�/�ι�/�μ����� ��ȸ�غ�����.
SELECT employee_id, first_name, department_id, department_name FROM employees INNER JOIN departments USING (department_id) 
WHERE salary <= 9000 ORDER BY department_id;

-- ����2 : �μ����� IT�� ������� ���/�̸�/�μ���/��å��(job_title)�� ��ȸ�غ�����.
SELECT employee_id, first_name, department_name, job_title FROM employees INNER JOIN departments USING (department_id)
INNER JOIN jobs USING (job_id) WHERE department_name = 'IT';

-- ����3 : Ŀ�̼��� �޴� ������� ���/�̸�/�μ���/��å���� ��ȸ�غ�����.
SELECT employee_id, first_name, department_name, job_title FROM employees INNER JOIN departments USING (department_id)
INNER JOIN jobs USING (job_id) WHERE commission_pct IS NOT NULL;

-- ����4 : �þ�Ʋ(Seattle)���� �ٹ��ϴ� ������� �̸�/�μ���/�ּ�/���ø��� ��ȸ�غ�����.
SELECT first_name, department_name, street_address, city FROM employees INNER JOIN departments USING (department_id)
INNER JOIN locations USING (location_id) WHERE city = 'Seattle';

/*
    # ANSI OUTER JOIN (������ �������� ���� �൵ �����Ű�� ��)
    
        1. LEFT OUTER JOIN : �������� ���ߴ� ���� ���̺��� �����Ͱ� �����Ѵ�(������ ���̺��� �࿡ +���� �Ͱ� ����)
        2. RIGHT OUTER JOIN : �������� ���ߴ� ������ ���̺��� �����Ͱ� �����Ѵ�(���� ���̺��� �࿡ +���� �Ͱ� ����)
        3. FULL OUTER JOIN : ���� ���̺� +�� ���� ȿ���� �ִ�.
*/

-- LEFT OUTER JOIN�� �ϸ� �μ��� ���� �������� �ʾҴ� ����� �� �� �߰��� ��ȸ��
SELECT * FROM employees LEFT OUTER JOIN departments USING (department_id);

-- RIGHT OUTER JOIN�� �ϸ� ������ ����� ��� �������� ���ߴ� �μ����� �߰��� �����Ѵ�.
SELECT * FROM employees RIGHT OUTER JOIN departments USING (department_id);

-- FULL OUTER JOIN�� LEFT/RIGHT OUTER JOIN ��θ� ������ ����� ��ȸ�ȴ�.
-- (�μ��� ��� �������� ���ߴ� ����� + �Ҽ� ����� ��� �������� ���ߴ� �μ���)
SELECT * FROM employees FULL OUTER JOIN departments USING (department_id);

-- ����1 : ��� ������� �̸�/��å��/�Ŵ��� �̸�/�Ŵ��� ��å���� ��ȸ�ϵ� �Ŵ����� ���� ����� �߰��� ��ȸ�غ�����.
SELECT emp.first_name AS "��� �̸�", j1.job_title AS "����� ��å��", mgr.first_name AS "�Ŵ��� �̸�", j2.job_title AS "�Ŵ����� ��å��"
FROM employees emp LEFT OUTER JOIN employees mgr ON emp.manager_id = mgr.employee_id
LEFT OUTER JOIN jobs j1 ON emp.job_id = j1.job_id LEFT OUTER JOIN jobs j2 ON emp.job_id = j2.job_id;

-- ����2 : ��� ������ ���� �̸�/�ּ�/�Ҽ� �μ� ���� ���θ� ��ȸ�غ�����.
SELECT location_id, city, street_address, 'T' AS dept_exists FROM locations 
WHERE location_id IN (SELECT location_id FROM departments GROUP BY location_id)
UNION
SELECT location_id, city, street_address, 'F' AS dept_exists FROM locations 
WHERE NOT location_id IN (SELECT location_id FROM departments GROUP BY location_id)
ORDER BY location_id;

SELECT location_id, COUNT(*) FROM departments GROUP BY location_id;

-- # SELECT DISTINCT : �ߺ��� �����ϸ鼭 ��ȸ�Ѵ�.
SELECT department_id, department_name, location_id FROM departments;

SELECT location_id FROM departments;

-- location_id�� �ߺ����� �����ϴ� �� ���� ���
SELECT DISTINCT location_id FROM departments;
SELECT location_id FROM departments GROUP BY location_id;

-- �ߺ����� �ʴ� �÷��� �Բ� �ִٸ� �ߺ��� �������� ���Ѵ�.
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
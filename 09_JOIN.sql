-- 09_JOIN.sql

/*
    # �⺻Ű (Primary Key, PK)
    
        - �� ���̺��� �ϳ��� ���� �����ϰ� ������ �� �ִ� �÷�(e.g. employee_id)
        - �� ���̺� ���� ���� �⺻Ű �ĺ��� �ִ��� �⺻Ű�� �ϳ� �ۿ� ������ �� ����.
        - �⺻Ű�� �����Ϸ��� �÷����� �ߺ��� ���� ���� ���� ����� �Ѵ�.(UNIQUE)
        - �⺻Ű�� �����Ϸ��� �÷����� NULL ���� ����� �Ѵ�.(NOT NULL)
        
    # �ĺ�Ű (Candidate Key)
    
        - �⺻Ű�� �� �ڰ��� ���߾����� �⺻Ű�� ���õ��� ���� �÷�
    
    # �ܷ�Ű
    
        - �ٸ� ���̺��� �⺻Ű�� ������ �Ϲ� �÷����� ����� �÷�
          (e.g. �μ�(departments) ���̺��� �⺻Ű(department_id)�� ��� ���̺����� �ߺ����� ����ϴ� �ܷ�Ű �÷����� ����Ͽ���)
        - �ܷ�Ű �÷��� ���� ���� �ݵ�� �����ϴ� �⺻Ű �÷��� �̹� �����ϰ� �ִ� ���̾�� �Ѵ�.(���� ���Ἲ)
          (e.g. �μ�(departments) ���̺� �������� �ʴ� 7777�� �μ��� �ܷ�Ű �÷��� employees.department_id�� ������ ����� �� ����)
        - �� ���̺��� �⺻Ű�� �ٸ� ���̺��� �ܷ�Ű�� �����Ǿ��ٸ� �� ���̺� ������ 1:N ����(�ϴ�� ����)�� �����Ǿ��ٰ� �� �� �ִ�.
        
    # ��ü �� ������ ����
    
        - 1:1 ���� : ���� ���̺� �ȿ� �÷����� �־��ָ� �ȴ�.
        - 1:N ���� : �μ�-���, ��-���, ȸ��-�ۼ���, ���� ���-���
        - N:N ���� : ����-�л�, �մ�-�޴�, ���̴�-����
                    (N:N ����� �ٶ������� �ʾƼ� ���� ����� �ȴ�.)
                    
    # JOIN
    
        - �⺻Ű�� �ܷ�Ű�� ���谡 �����Ǿ� �ִ� �� ���̺� �̻��� ������ �����Ͽ� ��ȸ�ϴ� ��
        - CROSS JOIN
        - EQUI JOIN
        - NON-EQUI JOIN
        - SELF JOIN
        - INNER JOIN
        - OUTER JOIN
*/

/*
    # CROSS JOIN
    
        - �� ���̺��� ��� ���� ��ȸ�Ͽ� ���� �� �ִ� ��� ����� ���� ��ȸ�ϴ� JOIN
        - �׳� �� �����غ����� ���� �������� ����
*/

SELECT * FROM employees; -- 107 rows
SELECT * FROM departments; -- 27 rows
SELECT * FROM employees, departments; -- 2889 rows (107 * 27)

/*
    # EQUI JOIN
    
        - �� ���̺��� ���� ������ ���� ���� �÷���(�ַ� �⺻Ű�� �ܷ�Ű)�� CROSS JOIN���� �ǹ� �ִ� �����͸� �ɷ��� JOIN
*/

-- CROSS JOIN�� ������κ��� �� department_id�� ���� �ุ ��ȸ�Ѵ�. -> �ǹ� �ִ� ������
SELECT * FROM employees, departments WHERE employees.department_id = departments.department_id;

-- ��� ���̺� �ִ� �÷��� �μ� ���̺� �ִ� �÷��� ��� ��ȸ�� �� �ִ�.
SELECT first_name, last_name, department_name FROM employees, departments 
WHERE employees.department_id = departments.department_id;

-- �� ���̺� ���� �̸����� �����ϴ� �÷��� ������ ��Ȯ�ϰ� ���̺� �̸����� ����ؾ� �Ѵ�.
-- (column ambiguously defined : �÷��� �ָ��ϰ� ���ǵǾ� ����)
SELECT first_name, last_name, employees.department_id, department_name 
FROM employees, departments 
WHERE employees.department_id = departments.department_id;

-- ����1 : ������ 9000�޷� ������ ������� ���/�̸�/�ι�/�μ����� ��ȸ�غ�����.
SELECT employee_id, first_name, employees.department_id, department_name FROM employees, departments 
WHERE salary <= 9000 AND employees.department_id = departments.department_id ORDER BY department_id;

-- ����2 : �μ����� IT�� ������� ���/�̸�/�μ���/��å��(job_title)�� ��ȸ�غ�����.

SELECT * FROM jobs;

-- �� ���̺�� �ڿ� ��Ī�� ����� ���� ����� �� �ִ�.
SELECT employee_id, first_name, department_name, job_title FROM employees emp, departments dept, jobs
WHERE department_name = 'IT' AND emp.department_id = dept.department_id AND emp.job_id = jobs.job_id;

-- ����3 : Ŀ�̼��� �޴� ������� ���/�̸�/�μ���/��å���� ��ȸ�غ�����.
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

-- ����4 : �þ�Ʋ(Seattle)���� �ٹ��ϴ� ������� �̸�/�μ���/�ּ�/���ø��� ��ȸ�غ�����.
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
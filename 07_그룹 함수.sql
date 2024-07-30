-- 07_�׷� �Լ�.sql

/*
    # �׷� �Լ�
    
        - �ϳ��� �÷��� �������� ��� �ٸ� �÷����� ���� ����� �ϳ��� ���� ��ȸ�ϴ� ��
        - �׷�ȭ�� ������ �Ǵ� �÷��� GROUP BY���� ���� ������ �� �ִ�.
        - �׷� �Լ��� ����ϸ� �׷��� ������ �ƴ� �Ϲ� �÷��� �Բ� ����� �� ����.
*/

-- # SUM(column) : �ش� �÷��� ������ �����ִ� �׷� �Լ�

-- ��� ������� ������ ����(�׷�ȭ���� ����)
SELECT SUM(salary) FROM employees; 

-- ��å�� ������ ����
SELECT job_id, SUM(salary) FROM employees GROUP BY job_id;

-- �μ��� ������ ����
SELECT department_id, SUM(salary) FROM employees GROUP BY department_id;

-- # AVG(column) : �ش� �÷��� ��հ��� ���ϴ� �׷� �Լ�
-- # COUNT(column) : �ش� �÷��� ���� ������ ���ϴ� �׷� �Լ� (null�� �����ϰ� ����)

-- �μ��� ������ ���հ� ����� ���غ��� ������
SELECT
    department_id,
    SUM(salary)   AS ����,
    COUNT(salary) AS "���޹޴� ��� ��",
    AVG(salary)   AS "��� ����"
FROM
    employees
GROUP BY
    department_id;
    
-- # MAX(column) : �ش� �÷����� ���� ū ���� ���Ѵ�.
-- # MIN(column) : �ش� �÷����� ���� ���� ���� ���Ѵ�.

-- ��å���� ���� ���� ���� �޴� ����� �ݾװ�, ���� ���� �޴� ����� �ݾ��� ��ȸ
SELECT
    job_id,
    MAX(salary) AS "���� ���� �޴� ���",
    MIN(salary) AS "���� ���� �޴� ���"
FROM
    employees
GROUP BY
    job_id;
    
-- ����1 : �� ��å�� ��� ������ ���غ�����(���� �ƴϰ� ����)
SELECT job_id, AVG(salary * 12) AS "��å�� ��� ����" FROM employees GROUP BY job_id;

-- ����2 : �� �μ����� ���� ���� �� ����� �Ի��� ��¥�� ���� �ֱٿ� ����� �Ի��� ��¥�� ��ȸ�غ�����.
SELECT
    department_id,
    MIN(hire_date) AS "������ ���",
    MAX(hire_date) AS "�ż��� ���"
FROM
    employees
GROUP BY
    department_id;
    
/*
    # HAVING��
    
        - �׷�ȭ ������ ����� ����� ������ �����ϰ� ���� ��� ����ϴ� ����
        - WHERE���� ������ �׷�ȭ ���� �̸� ����� �Ÿ��� �ǰ� HAVING���� ������ �׷�ȭ ������ ������ ����ϰ� �ȴ�.
*/

SELECT * FROM employees;

-- ex) ��å�� ��� ������ 10000�޷� �̻��� ��å�� ��ȸ�غ���
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id HAVING AVG(salary) >= 10000;

-- ex) ��å�� ��� ������ 10000�޷� �̸��� ��å�� ��ȸ�غ���
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id HAVING AVG(salary) < 10000;

-- WHERE���� ����ϸ� ������ 10000�޷� �̻��� �����θ� ��å�� ����� ���� �ȴ�.
SELECT job_id, AVG(salary) FROM employees WHERE salary >= 10000 GROUP BY job_id;

-- ex) 2006�� ������ �Ի��� ������� �μ��� ��� ������ ���ϵ� 2�� ������ ���� ��ȸ���� �� ��
SELECT
    department_id,
    AVG(salary),
    COUNT(salary)
FROM
    employees
WHERE
    hire_date < '06/01/01'
GROUP BY
    department_id
HAVING
    COUNT(salary) > 2;
    
-- ����1 : ��å�� ��� ������ 10000�޷� �̸��� �� ��å�� ��� ���� ��ȸ�غ�����.
SELECT job_id, COUNT(*) FROM employees GROUP BY job_id HAVING AVG(salary) < 10000;

-- ����2 : 2007�⿡ �Ի��� ������� �μ����� �� �� �ִ��� ��ȸ�ϵ�, 2007�⿡ �Ի��� ������� 5�� �̸��� �μ��� ��ȸ���� �ʵ��� �غ�����.
SELECT
    department_id,
    COUNT(*)
FROM
    employees
WHERE
    hire_date LIKE '07%'
GROUP BY
    department_id
HAVING
    COUNT(*) >= 5;
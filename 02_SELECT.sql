-- 02_SELECT.sql

/*
    # SELECT �÷��� FROM ���̺��;
    
        - ���ϴ� ���̺��� ���ϴ� �÷��� ��ȸ�� �� �ִ� ������
        - �÷��� �ڸ��� *�� ���� ��� �÷��� ��ȸ�� �� �ִ�.
        - ������, �÷���, ���̺���� ��ҹ��ڸ� �������� �ʴ´�.
        - �����ʹ� ��ҹ��ڸ� �����Ѵ�.
*/

SELECT * FROM employees;

SELECT email, phone_number FROM employees;
SELECT first_name, last_name FROM employees;
SELECT country_name FROM countries;

-- ������, �÷���, ���̺���� ��ҹ��ڸ� �������� �ʴ´�.
select EMail, PhOnE_NuMBer FrOm eMpLOyEEs;

-- # ������ ���� HR�� �̸� ������� �ִ� ������ ���̺��
SELECT * FROM tab;

SELECT * FROM countries; -- ���� ����
SELECT * FROM employees; -- ��� ����
SELECT * FROM departments; -- �μ� ����
SELECT * FROM jobs; -- ��å ����
SELECT * FROM locations; -- �� ������ �ּ� ����
SELECT * FROM regions; -- ��� ����

-- ����1 : ��� �μ��� �μ���ȣ�� �μ����� ��ȸ�غ�����.
SELECT department_id, department_name FROM departments;
-- ����2 : ��� ����� �����ȣ/�̸�/����/�����/�μ���ȣ�� ��ȸ�غ�����.
SELECT employee_id, first_name, salary, hire_date, department_id FROM employees;
-- ����3 : ��� ������ �Ҽ� ���� �̸�/�ּ�/�����ȣ�� ��ȸ�غ�����.
SELECT city, street_address, postal_code FROM locations;

/*
    # DESC ���̺��;
    
        - �ش� ���̺� � �÷����� �ִ��� Ȯ���� �� �ִ� ��ɾ�
        - �÷���, null�� ��� ����, �÷� Ÿ���� Ȯ���� �� �ִ�.
        
    # NUMBER(n), NUMBER(n,m)
    
        - ���ڸ� ������ �� �ִ� �÷� Ÿ��
        - ���ڰ� �ϳ��� �����Ǿ� ������ ������ ���̸� �ǹ��Ѵ�.
          ex) NUMBER(3) : 0���� 999���� ���� �� �ִ�.
        - ���ڰ� �� �� �����Ǿ� ������ ù ��° ���ڴ� ������ ��ü ���̸� �ǹ��ϰ� �� ��° ���ڴ� �Ҽ��� �ڸ����� �ǹ��Ѵ�.
          ex) NUMBER(5,2) : �� 5�ڸ��ε� �Ҽ����� 2�ڸ����� ���� �� �ִ�.
              NUMBER(2,2) : �� 2�ڸ��ε� �Ҽ����� 2�ڸ����� ���� �� �ִ�.(�Ҽ��� ����)
              
    # VARCHAR2(n)
    
        - ���̰� �������� ���� ���ڿ��� ������ �� ����ϴ� �÷� Ÿ��
        - ������ �÷��� ũ�Ⱑ �ִ� ���̰� �ǰ� �� ���� ������ ���ڿ��� ������ ��� ���� ���� �ּ�ȭ���ֵ��� ����Ǿ� �ִ�.
        
    # CHAR(n)
    
        - ���� ���� ���ڿ��� ������ �� ����ϴ� �÷� Ÿ��
        - ������ �÷� ũ�⺸�� �� ���� ������ ���ڿ��� ���͵� ������ ��� �����ϸ� �����Ѵ�.
        - ������ ����ȭ�Ϸ��� �۾��� ���� �ʱ� ������ �ӵ��� �� ���� �� �ִ�.
          ex) ���� �ڵ�(KR, EN, US, JP, ...) �����ʹ� ������ 2�����̹Ƿ� VARCHAR2 Ÿ�� �÷����� CHAR Ÿ�� �÷��� �� ��︰��.
          
    # DATE
    
        - ��¥ �� �ð� �����͸� ������ �� �ִ� �÷� Ÿ��
*/

DESC countries;
DESC locations;
DESC employees;

-- # SELECT�� �÷� �̸� �ڿ� AS�� ����� ���ϴ� �̸����� ������ ��ȸ�� �� �ִ�.
SELECT first_name AS �̸�, last_name AS �� FROM employees;
-- ��Ī�� ���⸦ ����ϰ� ���� ��� ""�� ��� ����� �� �ִ�.
SELECT first_name AS �̸�, hire_date AS "��� ��¥" FROM employees;

-- # �÷��� ��� �����ڸ� Ȱ���� ���� ����� ���� �� �ִ�.
-- Ctrl + F7 : ���η� ����
SELECT
    first_name AS �̸�,
    salary AS ����,
    salary * 2 AS "�� ��ġ ����",
    salary * 3 AS "�� ��ġ ����",
    salary + 100 AS "���ʽ� ���� ����"
FROM
    employees;

SELECT first_name, salary * 12 AS ���� FROM employees;

-- # ���� �÷������� ��� ����� �� �� �ִ�.
--   �� null ��� ���ϴ� ���� ����ϰ� ���� ��� NVL() �Լ��� ����� �� �ִ�.
SELECT
    first_name AS �̸�,
    salary AS ����,
    NVL(commission_pct, 0) AS "���ʽ� ����",
    salary * NVL(commission_pct, 0) AS "���ʽ� �ݾ�"
FROM
    employees;
    
-- # �� �÷� �̻��� ���� �̾�ٿ��� ��ȸ�ϰ� ���� �� ||�� ����� �� �ִ�.
SELECT first_name || ' ' || last_name AS full_name FROM employees;

-- ���� : ��� ������� �����ȣ/Ǯ����/��å/������ ��ȸ�غ�����.
SELECT employee_id, first_name || ' ' || last_name AS full_name, salary * 12 AS annual_salary FROM employees;
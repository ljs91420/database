-- 03_WHERE.sql

/*
    # SELECT �÷��� FROM ���̺�� WHERE ������;
    
        - SELECT�� �ڿ� WHERE���� �߰��Ͽ� �ش� ������ �����ϴ� �ุ ��ȸ�� �� �ִ�.
        - ���ǿ� ���Ǵ� �����ʹ� ��ҹ��ڿ� ������ �޴´�.
        - ����Ŭ�� �� �����ڿ� �� �����ڸ� ����Ͽ� �������� ���� �� �ִ�.
        
    # �� ������
    
        = : ������ true, (==�� ����� �� ����)
        !=, <>, ^= : �ٸ��� true
        >, <, <=, >= : ��
    
    # �� ������
    
        - AND, OR, NOT
*/

-- ���� Ÿ�� ���� ũ�� ��
SELECT * FROM employees WHERE salary > 20000;
SELECT * FROM employees WHERE salary >= 10000 AND commission_pct > 0;
SELECT * FROM employees WHERE department_id = 100;

-- ���� Ÿ�� ���� ũ�� �� (���������� ũ�� ��)
SELECT * FROM employees WHERE first_name >= 'N';
SELECT * FROM employees WHERE last_name < 'C';

-- ��¥ Ÿ���� ũ�� �� (�� ������ ���� �ð�, �� ũ�� ���� �ð�)
SELECT * FROM employees WHERE hire_date < '2006/01/01';
SELECT * FROM employees WHERE hire_date < '2005/01/01';
SELECT * FROM employees WHERE hire_date >= '2008/01/01';

-- AND, OR, NOT Ȱ��

-- ��� ��ȣ�� 150�� ���� �۰�, ���ÿ� �μ���ȣ�� 50���� ����鸸 ��ȸ
SELECT * FROM employees WHERE employee_id < 150 AND department_id = 50;

-- �μ���ȣ�� 30���̰ų� 50���̰ų� 80���� ��� ��ȸ
SELECT * FROM employees WHERE department_id = 30 OR department_id = 50 OR department_id = 80;

-- �μ���ȣ�� 80���� ����鸸 �����ϰ� ��ȸ
SELECT * FROM employees WHERE NOT department_id = 80;
SELECT * FROM employees WHERE department_id != 80;
SELECT * FROM employees WHERE department_id <> 80;
SELECT * FROM employees WHERE department_id ^= 80;

-- ����1 : ������ 2000���� 3000 ������ ������� �̸�, ����, ��å�� ��ȸ�غ�����.
SELECT first_name, salary, job_id FROM employees WHERE salary >= 2000 AND salary <= 3000;

-- ����2 : 30, 60, 100�� �μ��� ���� ������� �̸�, ��ȭ��ȣ, �μ���ȣ�� ��ȸ�غ�����.
SELECT first_name, phone_number, department_id FROM employees WHERE department_id = 30 OR department_id = 60 OR department_id = 100;

-- # �÷��� BETWEEN A AND B : �ش� �÷� ���� A�� B ������ ��� true
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000;

-- # �÷��� IN (A, B, C, ...) : () ���� ���� �߿� �ش� ���� ������ true
SELECT * FROM employees WHERE department_id IN (30, 60, 100);

-- # Ŀ�̼��� ���� �ʴ� ������� ��ȸ�ϰ� ���� ���

-- null ���� �Ϲ����� �� �����ڷδ� ũ�� �񱳰� �ƿ� �Ұ����ϴ�.
SELECT * FROM employees WHERE commission_pct = null;
SELECT * FROM employees WHERE commission_pct != null;

-- �ذ�å1 : nvl�� ����.
SELECT * FROM employees WHERE nvl(commission_pct, 0) != 0;
SELECT * FROM employees WHERE nvl(commission_pct, 0) = 0;

-- �ذ�å2 : null���� is�� ���� �� �ִ�.
SELECT * FROM employees WHERE commission_pct IS NULL;

-- NOT�� ���� �ڸ��� Ȱ���� �� �ִ�.
SELECT * FROM employees WHERE commission_pct IS NOT NULL;
SELECT * FROM employees WHERE NOT commission_pct IS NULL;

/*
    # ���ǿ� LIKE ����ϱ�
    
        - LIKE�� ����ϸ� �������� �Ϻκ��� ��ġ�ϴ� ���� ��ȸ�� �� �ִ�.
        - % : ���� ���� ���� �ƹ� ���ڳ� �־ �Ǵ� �ڸ�
        - _ : �ƹ� ���ڳ� �� ���ڰ� �ݵ�� �����ؾ� �ϴ� �ڸ�
*/

SELECT * FROM employees;
SELECT * FROM employees WHERE first_name = 'Steven';
SELECT first_name, last_name FROM employees WHERE first_name LIKE 'S%';
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%y';

-- first_name�� �ƹ� ������ �ҹ��� t�� �����ϴ� ������� ��ȸ
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t%';

-- first_name�� �ڿ��� �� ��° �ڸ��� t�� �����ϴ� ������� ��ȸ
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t_';

-- first_name�� �ڿ��� �� ��° �ڸ��� t�� �����ϴ� ������� ��ȸ
SELECT first_name, last_name FROM employees WHERE first_name LIKE '%t__';

-- ��¥ �÷����� LIKE�� ����� �� �ִ�.
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/06/%';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/30';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '02/%';
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/_2/%';

-- ���� �÷����� LIKE�� ����� �� �ִ�.(������ ũ�� �񱳰� �� ����)
SELECT first_name, salary FROM employees WHERE salary LIKE '3%';

-- ����1 : first_name�� �ڿ��� �� ��° ���ڰ� a�� ��� ������� �̸��� ������ ��ȸ
SELECT first_name, salary FROM employees WHERE first_name LIKE '%a__';

-- ����2 : first_name�� e�� �� �� �̻� ���Ե� ������� �̸��� ��å�� ��ȸ
-- �� first_name�� ù ���ڰ� �빮���̱� ������ �ҹ��ڷ� �ٲ㼭 �����ָ� �̸��� E�� �����ϴ� ����� ��ȸ�� �����ϴ�.
SELECT upper(first_name) FROM employees; -- upper() : ���� �빮�ڷ� ��ȯ�ϴ� �Լ�
SELECT lower(first_name) FROM employees; -- lower() : ���� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
SELECT first_name, job_id FROM employees WHERE lower(first_name) LIKE '%e%e%';

-- ����3 : first_name�� �ټ� �����̸鼭 r�� ������ ������� �̸��� ��ȭ��ȣ�� ��ȸ
SELECT first_name, phone_number FROM employees WHERE first_name LIKE '____r';

-- ����4 : 8���� �Ի��� ������� �̸��� ������� ��ȸ
SELECT first_name, hire_date FROM employees WHERE hire_date LIKE '%/08/%';
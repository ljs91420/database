-- 08_����.sql

/*
    # ORDER BY �÷��� [ASC|DESC]
    
        - ��ȸ�� ���ϴ� �÷��� �������� �����Ͽ� ����� �� �ִ�.
        - ASC : ��������(Ascending)
        - DESC : ��������(Decending)
        - ASC �Ǵ� DESC �Է� ������ �⺻������ ASC�� ���ĵȴ�.
*/

SELECT * FROM employees ORDER BY first_name ASC;
SELECT * FROM employees ORDER BY first_name DESC;

-- �������� �� ���� null�� ���� ���߿� �����Ѵ�.
SELECT first_name, job_id, commission_pct FROM employees 
WHERE commission_pct IS NOT NULL ORDER BY commission_pct ASC; -- WHERE�� ORDER BY���� �տ� ��� �Ѵ�.
-- �������� �� ���� null�� ���� �����Ѵ�.
SELECT first_name, job_id, commission_pct FROM employees ORDER BY commission_pct DESC;

-- ���� ������ ���� �� ������ ���� �ִ�.
SELECT first_name, job_id, department_id, salary FROM employees ORDER BY department_id, salary DESC, first_name;

-- ����1 : �̸��� i�� ���ԵǾ� �ִ� ������� ���� ���� �� �Ի��� ������� ��ȸ�غ���
SELECT * FROM employees WHERE lower(first_name) LIKE '%i%' ORDER BY hire_date;

-- ����2 : ��� ������� �� �������� �������� �����ϰ�, ���� ���� ��� �̸����� �ٽ� �� �� �������� �����Ͽ� ��ȸ�غ���
SELECT * FROM employees ORDER BY last_name, first_name;

-- ����3 : �� �μ��� ��� ����, ��� ���� ��ȸ�ϰ� ��� ���� �������� �������� �����ϰ�, ��� ���� ������ ��� ������ �������� �������� �����Ͽ� ��ȸ
SELECT department_id, AVG(salary), COUNT(*) FROM employees GROUP BY department_id ORDER BY COUNT(*) DESC, AVG(salary) DESC;
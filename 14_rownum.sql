-- 14_rownum.sql

/*
    # rownum
    
        - �� ���̺� ������ �ִ� �� ��ȣ �÷�
        - ���ϴ� ��ŭ�� ���� ��ȸ�ϱ� ���� Ȱ���� �� �ִ�.
*/

SELECT rownum, first_name, salary FROM employees;

SELECT first_name, salary FROM employees ORDER BY salary DESC;
-- e.g. ������ ���� �޴� ������ 10�� ��ȸ
SELECT first_name, salary FROM employees WHERE rownum <= 10 ORDER BY salary DESC; -- �� �� �ǰ� ����

-- WHERE���� ������ ORDER BY���� ���� ����Ǳ� ������ rownum���� 10���� ���� �Ÿ� �� ������ �����ϰ� �ȴ�.

-- ���� ������ ����� ���ĵ� SELECT ���(�ζ��� ��)�� ���� �����ϰ� rownum�� �Űܾ� �Ѵ�.
-- �� �� ���� �������� WHERE���� ������ �����Ͽ� ��ȸ�� �� �ִ�.
SELECT rownum, emp.* FROM (SELECT * FROM employees ORDER BY salary DESC) emp WHERE rownum <= 10;

-- e.g. ���� ���� 20�� ~ 30���� ��ȸ�ϰ� ���� ���
SELECT rownum, first_name FROM employees WHERE rownum >= 20 AND rownum <= 30;

-- WHERE�� ���ǿ� rownum�� 20���� Ŀ�� �Ѵٴ� ������ �ִµ�, rownum1�� �ش� ������ �������� ���Ͽ� �ش� ���� �����ǰ� ���� ���� �ٽ� rownum1�� �ȴ�.

-- rownum�� ������ ���� �������� ���̷��� �ߴ��� rownum�� ���� �ٰ� �� �� ������ �Ǵ� ������ �ִ�.
SELECT * FROM (SELECT rownum rn, employees.* FROM employees ORDER BY salary DESC);

-- ���� ���� ���� �������� ������ ���� �����ϰ� �� ���� ���� �������� rownum�� �ٿ� �ش� ������ �ذ��� �� �ִ�.
-- �� �� rn���� �̸� �ٿ����� rownum�� ���� �������� �������� Ȱ���ϸ� ��ȸ�� �����ϴ�.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY salary DESC) emp) WHERE rn >= 20 AND rn <= 30;

-- ����1 : ȸ�翡 �ٴ��� ���� ������ ����� 5�� ��ȸ�غ�����.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn <= 5;

-- ����2 : ȸ�翡 �ٴ��� 15��°�� ������ ����� 1�� ��ȸ�غ�����.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn = 15;

-- ����3 : ȸ�翡 �ٴ��� 30 ~ 39��°�� ������ ����� 10�� ��ȸ�غ�����.
SELECT * FROM (SELECT rownum rn, emp.* FROM (SELECT * FROM employees ORDER BY hire_date) emp) WHERE rn >= 30 AND rn <= 39;
-- 11_SELF JOIN.sql

/*
    # SELF JOIN
    
        - �ϳ��� ���̺��� �ڱ� �ڽŰ� JOIN�Ͽ� ���ϴ� ����� ���� JOIN
        - �ش� ���̺��� �⺻Ű�� ���� ���̺��� �ٸ� �÷����� �ܷ�Ű�� Ȱ���ϴ� ���
          (e.g. employees�� manager_id�� ���� ���̺��� employee_id ���� �����ϴ� �ܷ�Ű�̴�)
*/

SELECT * FROM employees;

SELECT
    emp.first_name AS "��� �̸�",
    mgr.first_name AS "�Ŵ��� �̸�"
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id;
    
-- ����1 : �Ŵ��� �̸��� e�� ���� ������� ��� ������ ��ȸ�غ�����(��� ������)
SELECT
    emp.*
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id
    AND lower(mgr.first_name) LIKE '%e%'
ORDER BY
    emp.employee_id;

-- ����2 : ����ϴ� ����� 7�� �̻��� �Ŵ������� ������ ��ȸ�غ�����.

-- ���̺� �ڸ��� �ϳ��� SELECT���� ()�� ��� ����� �� �ִ�.
SELECT 
    e2.* 
FROM 
    (
        SELECT manager_id FROM employees
        GROUP BY manager_id HAVING COUNT(*) >= 7
    ) e1,
    employees e2
WHERE
    e1.manager_id = e2.employee_id;

-- �ϳ��� SELECT���� �������� Ȱ���� ���� �ִ�.
SELECT * FROM employees WHERE employee_id IN (
        SELECT manager_id FROM employees
        GROUP BY manager_id HAVING COUNT(*) >= 7);
        
/*
    (1) ����� �μ�ó�� 1:N ����� ������ �� �ִ� ���� ��ʸ� �ϳ� �����غ�����.
    
        ���ΰ� �ݷ�����
    
    (2) 1:N ����� ������ �� ��ü�� ���̺� ���·� �����غ�����.(���̺��, �÷���, �� �÷� Ÿ��, �� �÷� ũ��)
    
        ���̺�� : �ݷ�����
        �÷��� : ������(VARCHAR2), ������Ϲ�ȣ(NUMBER(15)), ������(NUMBER(3,1)), ����(VARCHAR2(6)), ǰ��(VARCHAR2),
                �����ָ�(VARCHAR2), ����ó(VARCHAR2), ���(VARCHAR2), �������(DATE), �߼�ȭ ����(VARCHAR2), �ּ�(VARCHAR2)
    
    (3) �� ���̺��� �⺻Ű�� �ܷ�Ű�� �����غ�����.
    
        �⺻Ű : ������Ϲ�ȣ
        �ܷ�Ű : �ֹε�Ϲ�ȣ
*/

/*
    (1) ����� �μ�ó�� 1:N ����� ������ �� �ִ� ���� ��ʸ� �ϳ� �����غ�����.
    
        ���� - ���
        ���� - ����
        
        ���� ���̺�
        news_id(PK) / NUMBER(15)
        news_title / VARCHAR2(200)
        news_content / VARCHAR2(5000)
        news_like / NUMBER(10)
        news_angry / NUMBER(10)
        news_dislike / NUMBER(10)
        reporter_id(FK) / NUMBER(8)
        
        news_title / news_content / news_like / news_angry / news_dislike
        ���� ����     ����            1           15           3
        
        ���� ���̺�
        reporter_id(PK) / NUMBER(8)
        reporter_name / VARCHAR2(30)
        reporter_age / NUMBER(3)
        reporter_email / VARCHAR2(100)
        reporter_field / VARCHAR2(30)
    
    (2) 1:N ����� ������ �� ��ü�� ���̺� ���·� �����غ�����.(���̺��, �÷���, �� �÷� Ÿ��, �� �÷� ũ��)
    
    (3) �� ���̺��� �⺻Ű�� �ܷ�Ű�� �����غ�����.
*/
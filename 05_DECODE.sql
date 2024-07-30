-- 05_DECODE.sql

/*
    # DECODE �Լ�
    
        - �ڹ��� switch-case�� �����ϴ�.
        - DECODE(column, case1, value1, case2, value2, ..., defaultValue)
*/

SELECT * FROM departments;

SELECT
    first_name,
    department_id,
    decode(department_id, 
        90, '�ͽ�ťƼ��', 
        100, '���̳���', 
        30, '����', 
        60, 'IT�μ�', 
        '���� ���� ����'
    ) AS "�ѱ� �μ���"
FROM
    employees;
    
/*
    ���� : 
    
        IT_PROG : 8% �λ�
        SH_CLERK : 4% �λ�
        ST_CLERK : 3% �λ�
        PU_CLERK : 3% �谨
        �� �� : �״�� ����
        
        �� ������ �ݿ��Ͽ� '�̸�/����/���� �� ����/���� �� ����'�� ��ȸ�غ�����.
*/
    
SELECT
    first_name,
    job_id,
    salary,
    decode(job_id, 
        'IT_PROG', salary + salary * 0.08, 
        'SH_CLERK', salary * 1.04,
        'ST_CLERK', salary * 1.03, 
        'PU_CLERK', salary * 0.97, 
        salary) AS "AFTER_SALARY"
FROM
    employees;
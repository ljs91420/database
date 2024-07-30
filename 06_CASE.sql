-- 06_CASE.sql

/*
    # CASE
    
        - decode()�� �ش� �÷��� ���� ��Ȯ�ϰ� ��ġ�ϴ� ���̽��� ������ �� �־���.
        - CASE() ������ �ش� �÷��� �پ��� ������ ������ �� �ִ�.
        - decode()�� switch-case�� �����ߴٸ� CASE�� if���� �����ϴ�.
        
        CASE
            WHEN ������ THEN ��°�
            WHEN ������ THEN ��°�
            ...
            ELSE �⺻��
        END
*/

SELECT
    first_name,
    job_id,
    salary AS "BEFORE_SALARY",
    CASE
        WHEN job_id = 'IT_PROG' THEN salary * 1.08
        WHEN job_id LIKE '%_CLERK' THEN salary * 1.03
        ELSE salary
    END AS "AFTER_SALARY"
FROM
    employees;
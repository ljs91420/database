-- 06_CASE.sql

/*
    # CASE
    
        - decode()는 해당 컬럼의 값과 정확하게 일치하는 케이스만 매핑할 수 있었다.
        - CASE() 문법은 해당 컬럼에 다양한 조건을 적용할 수 있다.
        - decode()가 switch-case와 유사했다면 CASE는 if문과 유사하다.
        
        CASE
            WHEN 조건절 THEN 출력값
            WHEN 조건절 THEN 출력값
            ...
            ELSE 기본값
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
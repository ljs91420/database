-- 05_DECODE.sql

/*
    # DECODE 함수
    
        - 자바의 switch-case와 유사하다.
        - DECODE(column, case1, value1, case2, value2, ..., defaultValue)
*/

SELECT * FROM departments;

SELECT
    first_name,
    department_id,
    decode(department_id, 
        90, '익스큐티브', 
        100, '파이낸스', 
        30, '구매', 
        60, 'IT부서', 
        '아직 설정 못함'
    ) AS "한글 부서명"
FROM
    employees;
    
/*
    연습 : 
    
        IT_PROG : 8% 인상
        SH_CLERK : 4% 인상
        ST_CLERK : 3% 인상
        PU_CLERK : 3% 삭감
        그 외 : 그대로 유지
        
        위 사항을 반영하여 '이름/직급/변동 전 월급/변동 후 월급'을 조회해보세요.
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
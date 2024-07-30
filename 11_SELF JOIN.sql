-- 11_SELF JOIN.sql

/*
    # SELF JOIN
    
        - 하나의 테이블에서 자기 자신과 JOIN하여 원하는 결과를 얻어내는 JOIN
        - 해당 테이블의 기본키를 같은 테이블의 다른 컬럼에서 외래키로 활용하는 경우
          (e.g. employees의 manager_id는 같은 테이블의 employee_id 값을 참조하는 외래키이다)
*/

SELECT * FROM employees;

SELECT
    emp.first_name AS "사원 이름",
    mgr.first_name AS "매니저 이름"
FROM
    employees emp,
    employees mgr
WHERE
    emp.manager_id = mgr.employee_id;
    
-- 연습1 : 매니저 이름에 e가 들어가는 사원들의 모든 정보를 조회해보세요(사원 정보만)
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

-- 연습2 : 담당하는 사원이 7명 이상인 매니저들의 정보를 조회해보세요.

-- 테이블 자리에 하나의 SELECT문을 ()로 묶어서 사용할 수 있다.
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

-- 하나의 SELECT문을 조건으로 활용할 수도 있다.
SELECT * FROM employees WHERE employee_id IN (
        SELECT manager_id FROM employees
        GROUP BY manager_id HAVING COUNT(*) >= 7);
        
/*
    (1) 사원과 부서처럼 1:N 관계로 설정할 수 있는 실제 사례를 하나 생각해보세요.
    
        주인과 반려동물
    
    (2) 1:N 관계로 설정한 두 개체를 테이블 형태로 설계해보세요.(테이블명, 컬럼명, 각 컬럼 타입, 각 컬럼 크기)
    
        테이블명 : 반려동물
        컬럼명 : 동물명(VARCHAR2), 동물등록번호(NUMBER(15)), 몸무게(NUMBER(3,1)), 성별(VARCHAR2(6)), 품종(VARCHAR2),
                소유주명(VARCHAR2), 연락처(VARCHAR2), 모색(VARCHAR2), 생년월일(DATE), 중성화 여부(VARCHAR2), 주소(VARCHAR2)
    
    (3) 각 테이블의 기본키와 외래키를 설정해보세요.
    
        기본키 : 동물등록번호
        외래키 : 주민등록번호
*/

/*
    (1) 사원과 부서처럼 1:N 관계로 설정할 수 있는 실제 사례를 하나 생각해보세요.
    
        뉴스 - 댓글
        뉴스 - 기자
        
        뉴스 테이블
        news_id(PK) / NUMBER(15)
        news_title / VARCHAR2(200)
        news_content / VARCHAR2(5000)
        news_like / NUMBER(10)
        news_angry / NUMBER(10)
        news_dislike / NUMBER(10)
        reporter_id(FK) / NUMBER(8)
        
        news_title / news_content / news_like / news_angry / news_dislike
        오늘 날씨     맑음            1           15           3
        
        기자 테이블
        reporter_id(PK) / NUMBER(8)
        reporter_name / VARCHAR2(30)
        reporter_age / NUMBER(3)
        reporter_email / VARCHAR2(100)
        reporter_field / VARCHAR2(30)
    
    (2) 1:N 관계로 설정한 두 개체를 테이블 형태로 설계해보세요.(테이블명, 컬럼명, 각 컬럼 타입, 각 컬럼 크기)
    
    (3) 각 테이블의 기본키와 외래키를 설정해보세요.
*/
-- 15_테이블 생성.sql

/*
    # CRUD
    
        - 대부분의 프로그램들이 가지고 있는 데이터 처리들을 줄여 표현한 말
        - Create (데이터 생성)
        - Read   (데이터 읽기)
        - Update (데이터 수정)
        - Delete (데이터 삭제)
        
    # DML (Data Manipulate Language, 데이터 조작어)
    
        - 테이블에 들어있는 데이터를 조작할 수 있는 쿼리문들
        - INSERT : 테이블에 데이터를 추가하는 명령어(C)
        - SELECT : 테이블의 데이터를 읽는 명령어(R)
        - UPDATE : 테이블의 데이터를 수정하는 명령어(U)
        - DELETE : 테이블의 데이터를 삭제하는 명령어(D)
    
    # DDL (Data Definition Language, 데이터 정의어)
    
        - DB의 오브젝트를 정의하는 명령어들
        - 테이블, 시퀀스, 뷰, 인덱스 등이 DB 오브젝트에 해당한다.
        - CREATE : DB 오브젝트를 생성할 때 사용하는 명령어(C)
        - ALTER : 이미 존재하는 DB 오브젝트를 수정할 때 사용하는 명령어(U)
        - DROP : 이미 존재하는 DB 오브젝트를 수정할 때 사용하는 명령어(D)
                 (휴지통에서 복구 가능)
        - TRUNCATE : DB 오브젝트 완전 삭제(복구 불가능)
        - SELECT : DB 오브젝트를 확인할 때도 SELECT문을 사용한다.(R)
                   (e.g. SELECT * FROM tabs)
    
    # DCL (Data Control Language, 데이터 제어 명령어)
    
        - DB 사용자에게 다양한 권한을 부여하거나 박탈할 수 있는 명령어
        - GRANT : 권한 부여
        - REVOKE : 권한 회수
*/

SELECT * FROM tab;
SELECT * FROM tabs;

/*
    # 테이블 생성하기
    
    CREATE TABLE 테이블명 (
        컬럼명 컬럼타입,
        컬럼명 컬럼타입,
        ...
    );
*/

CREATE TABLE fruits (
    fruit_name VARCHAR2(20),
    price NUMBER(7)
);

SELECT * FROM fruits;
DESC fruits;

-- # 테이블 삭제 : DROP TABLE 테이블명;
DROP TABLE fruits;

-- DROP으로 삭제된 DB 오브젝트는 휴지통에서 확인할 수 있고 복구가 가능하다.
SHOW recyclebin;

-- 휴지통에 들어있던 DB 오브젝트 복구하기
FLASHBACK TABLE fruits TO BEFORE DROP;

SELECT * FROM fruits;
DESC fruits;

-- 휴지통 비우기(이후 복구 어려움)
PURGE recyclebin;

-- # 기존 테이블을 복사하여 새 테이블 만들기(내용도 함께 복사)
CREATE TABLE employees2 AS (SELECT * FROM employees);
SELECT * FROM employees2;

-- # 기존 테이블을 구조만 복사하여 새 테이블 만들기
CREATE TABLE employees3 AS (SELECT * FROM employees WHERE 1 = 0);
SELECT * FROM employees3;

DROP TABLE employees2;
DROP TABLE employees3;

SHOW recyclebin;

FLASHBACK TABLE employees2 TO BEFORE DROP;
SELECT * FROM employees2;

PURGE recyclebin;

-- 연습 : 어제 설계했던 1:N 관계의 테이블들을 직접 생성해보세요.
CREATE TABLE pets (
    animal_registration_number NUMBER(15),
    pet_name VARCHAR2(20),
    weight NUMBER(3,1), 
    sex VARCHAR2(6), 
    breed VARCHAR2(20),
    owner_name VARCHAR2(20),
    phone_number VARCHAR2(20),
    hair_color VARCHAR2(10), 
    birth_date DATE, 
    neutrification VARCHAR2(10), 
    address VARCHAR2(100)
);

DESC pets;
SELECT * FROM pets;

DROP TABLE pets;

PURGE recyclebin;
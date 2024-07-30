-- 21_제약조건.sql

/*
    # 제약조건
    
        - 데이터의 다양한 무결성을 유지하기 위한 제약들
        
    # 무결성
    
        - 데이터가 결함이 없는 것
        - 데이터베이스는 데이터를 결함 없는 상태로 올바르게 유지하는 것을 목표로 한다.
        
    # 개체 무결성
    
        - 테이블의 데이터 중 반드시 하나의 행을 선택할 수 있어야 한다.
        - 개체 무결성을 지키기 위한 제약조건으로 기본키(PK)를 사용한다.
    
    # 참조 무결성
    
        - 서로 참조 관계에 있는 데이터는 유효한 데이터를 참조해야 한다.
        - 참조 무결성을 지키기 위해 제약조건으로 외래키(FK)를 사용한다.
    
    # 도메인 무결성
    
        - 하나의 도메인을 구성하는 개체들은 모두 같은 타입이어야 한다.
        - 데이터베이스는 도메인 무결성을 지키기 위해 컬럼 타입을 사용한다.
        
    # 데이터 무결성
    
        - 데이터가 정확성, 일관성, 유효성을 유지하는 것
        - CHECK, NOT NULL 등의 제약조건을 사용해 데이터 무결성을 유지할 수 있다.
        
    # 관계형 데이터베이스의 제약 조건들
    
        - UNIQUE : 해당 도메인에 중복되는 값을 허용하지 않는다.(null은 허용)
        - NOT NULL : 해당 도메인에 null을 허용하지 않는다.
        - PRIMARY KEY : NOT NULL + UNIQUE, 한 테이블 당 하나만 설정 가능
        - FOREIGN KEY : 다른 PRIMARY KEY 컬럼 또는 UNIQUE 컬럼에 존재하는 값만 추가할 수 있다.
        - CHECK : 원하는 조건을 직접 설정하여 해당 조건을 만족하는 경우에만 데이터 추가
*/

SELECT * FROM employees;

-- 현재 계정의 제약조건을 볼 수 있는 데이터 딕셔너리 뷰
SELECT * FROM user_constraints;

/*
    # CONSTRAINT_TYPE
    
        P : Primary Key
        R : References (Foreign Key)
        U : Unique
        C : Check(or Not Null)
*/

-- 다른 데이터 딕셔너리 뷰들...
SELECT * FROM user_tables;
SELECT * FROM all_tables;
SELECT * FROM all_users;

/*
    # 데이터 딕셔너리(Data Dictionary)
        
        - 데이터 사전
        - DB에 의해 알아서 관리되는 데이터에 대한 데이터들
        - DB 사용자는 데이터 딕셔너리를 직접 수정할 수 없다.
        
    # 데이터 딕셔너리 뷰
    
        - 데이터 딕셔너리를 DB 사용자가 확인할 수 있게끔 제공해주는 뷰(View)
        - 앞에 user_를 붙인 데이터 딕셔너리 뷰는 현재 계정의 것을 의미한다.
        - 앞에 all_을 붙인 데이터 딕셔너리 뷰는 모든 계정의 것을 의미한다.
*/

/*
    1. 테이블 생성과 동시에 제약조건 설정하기
    
        (1) 컬럼명 컬럼타입 제약조건
            (※ 제약조건 이름을 설정하지 않아서 SYS_로 시작하는 자동 이름이 배정된다)
        (2) 컬럼명 컬럼타입 CONSTRAINT 제약조건명 제약조건
            (※ 제약조건 이름을 설정해야 뭘 잘못했는지 쉽게 파악할 수 있다.)
        
*/

CREATE TABLE fruits3 (
    f_id NUMBER(4) PRIMARY KEY, -- 이 컬럼을 기본키로 설정한다.
    f_name VARCHAR2(20) NOT NULL
);

-- 테이블명_컬럼명_제약조건 형식으로 제약조건 이름을 달아두면 잘못을 알아채기 쉽다.
CREATE TABLE fruits3 (
    f_id NUMBER(4) 
        CONSTRAINT fruits3_fid_pk PRIMARY KEY,
    f_name VARCHAR2(20) 
        CONSTRAINT fruits3_fname_uk UNIQUE 
        CONSTRAINT fruits3_fname_nn NOT NULL,
    price NUMBER(5)
        CONSTRAINT fruits3_price_chk CHECK(price >= 0)
);

SELECT * FROM tabs;
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';
SELECT * FROM user_constraints WHERE table_name = 'FRUITS3';

INSERT INTO fruits3 VALUES(1, 'Apple', 1500);
INSERT INTO fruits3 VALUES(2, 'Banana', 2000);
INSERT INTO fruits3 VALUES(1, 'Watermelon', 3000);
INSERT INTO fruits3 VALUES(3, '청송사과', 3000);
INSERT INTO fruits3 VALUES(4, 'Kiwi', -2000);
INSERT INTO fruits3 VALUES(4, 'Kiwi', null);

SELECT * FROM fruits3;
DROP TABLE fruits3;
PURGE recyclebin;

/*
    2. 테이블 생성 후 제약조건 추가하기(테이블 수정하기)
    
        - ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건(컬럼명);
        - ALTER TABLE 테이블명 MODIFY (테이블 생성시 문법과 동일);
*/

CREATE TABLE fruits4 (
    f_id NUMBER(4),
    f_name VARCHAR2(20)
);

ALTER TABLE fruits4 ADD CONSTRAINT f4_fid_pk PRIMARY KEY(f_id);

ALTER TABLE fruits4 MODIFY(
    f_name VARCHAR2(35)
        CONSTRAINT f4_fname_uk UNIQUE
        CONSTRAINT f4_fname_nn NOT NULL
);

SELECT * FROM user_constraints WHERE table_name = 'FRUITS4';

/*
    3. 제약조건 삭제하기
    
        (1) 테이블을 삭제하면 딸려있는 제약조건들도 함께 삭제된다.
        (2) ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
            (※ 자동 생성된 이름 SYS_를 가진 제약조건명은 삭제할 때 귀찮아진다.)
*/

ALTER TABLE fruits4 DROP CONSTRAINT f4_fid_pk;

-- 기본키 제약조건을 삭제해서 f_id에 중복값을 넣을 수 있게 되었다.
INSERT INTO fruits4 VALUES(1, 'Orange');
INSERT INTO fruits4 VALUES(1, 'Kiwi');

SELECT * FROM fruits4;

/*
    4. 테이블 레벨에서 제약조건 추가하기
    
        - 컬럼을 모두 선언한 후에 테이블 생성문 내부에서 제약조건을 후술하는 방식
        - DEFAULT, NOT NULL은 테이블 레벨에서 정의할 수 없고, 하던대로 컬럼 레벨에서 정의해야 한다.
*/

CREATE TABLE coffee(
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(30)
        CONSTRAINT coffee_name_nn NOT NULL,
    coffee_price NUMBER(6) DEFAULT 0,
    CONSTRAINT coffee_cid_pk PRIMARY KEY(coffee_id),
    CONSTRAINT coffee_price_chk CHECK(coffee_price >= 0),
    CONSTRAINT coffee_name_uk UNIQUE(coffee_name)
);

SELECT * FROM user_constraints WHERE table_name = 'COFFEE';

/*
    # 외래키 추가하기
    
        - 외래키 제약조건은 다른 제약조건들과 다르게 참조하려는 다른 컬럼이 미리 존재해야 한다.
        - 참조하려는 다른 컬럼(부모키)이 UNIQUE 또는 PRIMARY KEY 제약조건이 걸려있어야 한다.
        - 외래키로 설정된 컬럼에는 부모키에 존재하는 값 또는 null만 허용한다.
*/

SELECT * FROM employees;
SELECT * FROM departments;

-- 1. 컬럼 레벨에서 외래키 설정하기
--    CONSTRAINT 제약조건명 REFERENCES 부모테이블명(부모컬럼명)
CREATE TABLE coffee2(
    c_id NUMBER(4) CONSTRAINT c2_cid_pk PRIMARY KEY,
    c_name VARCHAR2(20),
    country_id CHAR(2) CONSTRAINT c2_country_id_fk REFERENCES countries(country_id)
);

-- 외래키 제약 조건을 만족시키지 못함
INSERT INTO coffee2 VALUES(1, 'Americano', 'KR');
INSERT INTO coffee2 VALUES(1, 'Americano', 'MX');

SELECT * FROM countries;
SELECT * FROM coffee2;
SELECT * FROM coffee2 INNER JOIN countries USING(country_id);

-- 2. 테이블 생성 후 외래키 나중에 추가하기
CREATE TABLE coffee3 (
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(20),
    country_id CHAR(2)
);

-- ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 FOREIGN KEY(자식키이름) REFERENCES 부모테이블(부모컬럼)
ALTER TABLE coffee3 ADD CONSTRAINT c3_country_id_fk FOREIGN KEY(country_id) REFERENCES countries(country_id);

INSERT INTO coffee3 VALUES(null, null, 'KR');
INSERT INTO coffee3 VALUES(null, null, 'EN');
INSERT INTO coffee3 VALUES(null, null, 'JP');

SELECT * FROM coffee3;

-- 3. 테이블 레벨에서 외래키 추가하기
CREATE TABLE coffee4 (
    coffee_id NUMBER(4),
    coffee_name VARCHAR2(20),
    employee_id NUMBER(6),
    CONSTRAINT c4_coffee_id_pk PRIMARY KEY(coffee_id),
    CONSTRAINT c4_employee_id_fk FOREIGN KEY(employee_id) REFERENCES employees(emplyee_id)
);

SELECT * FROM user_constraints WHERE lower(table_name) = 'coffee4';

INSERT INTO coffee4 VALUES(1, '라떼', 100);
INSERT INTO coffee4 VALUES(2, '모카', 100);

SELECT * FROM coffee4 INNER JOIN employees USING(employee_id);

-- 1. 1:N 관계의 테이블을 2개 생성(제약조건 설정)
CREATE TABLE companies (
    company_name VARCHAR2(10) CONSTRAINT company_name_nn NOT NULL,
    owner_name VARCHAR2(30) CONSTRAINT owner_name_nn NOT NULL,
    country_id CHAR(2) CONSTRAINT country_id_fk REFERENCES countries(country_id)
);

CREATE TABLE smartphones (
    model_id VARCHAR2(10) CONSTRAINT model_id_pk PRIMARY KEY,
    company_name VARCHAR2(10) CONSTRAINT company_name_nn NOT NULL,
    model_name VARCHAR2(10) CONSTRAINT model_name_nn NOT NULL
);

-- 2. INSERT로 행을 적당히 추가
INSERT INTO companies(company_name, owner_name, country_id) VALUES('Apple', '팀 쿡', 'US');
INSERT INTO companies(company_name, owner_name, country_id) VALUES('HUAWEI', '런정페이', 'CN');
INSERT INTO companies(company_name, owner_name, country_id) VALUES('SONY', '요시다 켄이치로', 'JP');

-- 3. 데이터 JOIN하여 조회해보기
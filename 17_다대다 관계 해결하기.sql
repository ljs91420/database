-- 17_다대다 관계 해결하기.sql

/*
    N:N 관계 (다대다 관계)
    
        - 커피 메뉴/손님의 관계, 학생/교사의 관계 등 두 개체가 서로 각자의 여러 행을 참조하는 경우를 다대다 관계라고 한다.
        - 다대다 관계를 해소하는 방법에는 두 가지 방법이 있다.
        - 다대다 관계를 정의할 수 있는 하나의 중간 테이블을 만들어 다대다 관계를 두 개의 1:N 관계로 변환한다.(JOIN이 많이 발생)
        - 그냥 하나의 테이블을 합쳐버리고 데이터를 마구 중복시켜 사용한다.(JOIN은 발생하지 않아서 성능은 올라가지만 물리적 저장 공간을 많이 차지함)
        
        # N:N을 2개의 1:N으로 만들어 해결하는 방식
        
        - 커피 메뉴 테이블
        cid / cname         / price
        1     Americano       1000
        2     Cafe Latte      2000
        3     Cafe Mocha      3000
        
        - N:N 관계를 해소하기 위한 커피 구매 내역 테이블
          (N:N 관계에 있는 두 테이블의 기본키를 외래키로 사용하는 테이블)
        purchase_id(PK) / cid(FK) / costomer_id(FK) / purchase_qty / receipt_id(FK)
        1                 1         3                 3              1
        2                 2         3                 1              1
        
        - 손님 정보 테이블
        customer_id / customer_name / point
        1             Kim             1033
        2             Lee             202
        3             Park            500
        
        # N:N을 하나의 테이블로 합쳐서 해결하는 방식(물리적 저장 공간의 낭비와 빠른 처리 속도)
        
        pid / cid / cname    / price / purchase_qty / purchase_date / customer_id / customer_name / point
        1     1     Americano  1000    1              24/06/06        4             Minsu           300
        2     1     Americano  1000    3              24/06/07        4             Minsu           330
*/

-- 연습1 : 다대다 관계를 하나 생각하고, 테이블과 컬럼을 설계해보세요.
-- 의사와 환자

/*
    책 정보
    ISBN(PK) / page / title / author / period
    
    책
    book_id(PK) / ISBN(FK) / book_state / 
    
    대여
    rent_id / book_id(FK) / member_id(FK) / rent_date / 
    
    회원
    member_id(PK) / phone_number / email / social number / 
*/

-- 연습2 : DB에 설계대로 테이블을 생성해보세요.
CREATE TABLE doctors (
    doctor_id NUMBER(10),
    hospital VARCHAR2(40),
    subject VARCHAR2(30),
    doctor_name VARCHAR2(12)
);

CREATE TABLE patients (
    hospital_registration_number NUMBER(8),
    patient_name VARCHAR2(20),
    birth_date DATE
);

DROP TABLE doctors;

CREATE TABLE book (
    book_id NUMBER(6),
    ISBN VARCHAR2(17),
    book_state CHAR(1)
);

CREATE TABLE library_member (
    member_id NUMBER(6),
    member_name VARCHAR2(21),
    phone_number CHAR(13)
);

CREATE TABLE book_rental (
    rent_id NUMBER(6),
    book_id NUMBER(6),
    member_id NUMBER(6),
    rent_date DATE default sysdate, -- sysdate : 현재 시간
    return_date DATE
);

-- 연습3 : 생성된 테이블에 데이터를 추가해보세요.
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (1234567890, '서울아산병원', '류마티스내과', '김영은');
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (2345678901, '한양대학교구리병원', '감염내과', '김진영');
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (3456789012, '행복한연세가정의학과의원', '가정의학과', '문상훈');

SELECT * FROM doctors;

INSERT INTO book(book_id, ISBN, book_state) VALUES(1, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(2, '979-11-7171-167-3', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(3, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(4, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(5, '979-11-7171-167-3', 'E');
COMMIT;

INSERT INTO library_member(member_id, member_name, phone_number) VALUES(1, '김철수', '010-1234-1234');
INSERT INTO library_member(member_id, member_name, phone_number) VALUES(2, '최철수', '010-1111-2222');
INSERT INTO library_member(member_id, member_name, phone_number) VALUES(3, '이철수', '010-3333-4444');

INSERT INTO book_rental(rent_id, book_id, member_id, rent_date) VALUES(1, 1, 3, '2011/05/20');
INSERT INTO book_rental(rent_id, book_id, member_id) VALUES(1, 2, 3);
INSERT INTO book_rental(rent_id, book_id, member_id, rent_date, return_date) VALUES(1, 2, 3, '2014/09/09', '2018/03/01');

SELECT * FROM book;
SELECT * FROM library_member;
SELECT * FROM book_rental;

-- 연습4 : 모든 데이터들을 JOIN하여 원하는 데이터를 조회해보세요.
SELECT member_name, ISBN, rent_date FROM book_rental INNER JOIN library_member USING (member_id) INNER JOIN book USING (book_id)
WHERE return_date IS NULL;

-- 연습5 : book_info 테이블을 마저 만들어서 ISBN 대신 책 이름이 나오게 만들어보세요.
CREATE TABLE book_info (
    ISBN CHAR(17),
    total_page NUMBER(3),
    title VARCHAR2(50),
    author CHAR(12),
    rental_period NUMBER(5)
);

INSERT INTO book_info(ISBN, total_page, title, author, rental_period) VALUES('979-11-7171-193-2', 245, '전지적 푸바오 시점', '송영관', 14);

SELECT member_name, title, rent_date FROM book_rental INNER JOIN library_member USING (member_id) INNER JOIN book USING (book_id)
INNER JOIN book_info USING (ISBN) WHERE return_date IS NULL;
CREATE TABLE student
(
    student_no NUMBER(4) NOT NULL,
    name VARCHAR2(20),
    age NUMBER(4),
    phone VARCHAR2(20),
    address VARCHAR2(100),
    memo VARCHAR2(200)
);

CREATE SEQUENCE student_seq;

INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '홍길동', 30, '010-1111-2222', '한양', '홍길동입니다.');

INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '사임당', 40, '010-3333-4444', '천안', '사임당입니다.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '임꺽정', 35, '010-5555-6666', '대전', '꺽정입니다.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '아이언맨', 45, '010-2222-3333', '뉴욕', '철사람입니다.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '잡스', 20, '010-8888-9999', '시카고', '잡스입니다.');
    
SELECT * FROM student;
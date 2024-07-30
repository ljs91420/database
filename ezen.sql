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
    (student_seq.nextval, 'ȫ�浿', 30, '010-1111-2222', '�Ѿ�', 'ȫ�浿�Դϴ�.');

INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '���Ӵ�', 40, '010-3333-4444', 'õ��', '���Ӵ��Դϴ�.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '�Ӳ���', 35, '010-5555-6666', '����', '�����Դϴ�.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '���̾��', 45, '010-2222-3333', '����', 'ö����Դϴ�.');
    
INSERT INTO student
    (student_no, name, age, phone, address, memo)
VALUES
    (student_seq.nextval, '�⽺', 20, '010-8888-9999', '��ī��', '�⽺�Դϴ�.');
    
SELECT * FROM student;
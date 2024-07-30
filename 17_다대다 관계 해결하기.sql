-- 17_�ٴ�� ���� �ذ��ϱ�.sql

/*
    N:N ���� (�ٴ�� ����)
    
        - Ŀ�� �޴�/�մ��� ����, �л�/������ ���� �� �� ��ü�� ���� ������ ���� ���� �����ϴ� ��츦 �ٴ�� ������ �Ѵ�.
        - �ٴ�� ���踦 �ؼ��ϴ� ������� �� ���� ����� �ִ�.
        - �ٴ�� ���踦 ������ �� �ִ� �ϳ��� �߰� ���̺��� ����� �ٴ�� ���踦 �� ���� 1:N ����� ��ȯ�Ѵ�.(JOIN�� ���� �߻�)
        - �׳� �ϳ��� ���̺��� ���Ĺ����� �����͸� ���� �ߺ����� ����Ѵ�.(JOIN�� �߻����� �ʾƼ� ������ �ö����� ������ ���� ������ ���� ������)
        
        # N:N�� 2���� 1:N���� ����� �ذ��ϴ� ���
        
        - Ŀ�� �޴� ���̺�
        cid / cname         / price
        1     Americano       1000
        2     Cafe Latte      2000
        3     Cafe Mocha      3000
        
        - N:N ���踦 �ؼ��ϱ� ���� Ŀ�� ���� ���� ���̺�
          (N:N ���迡 �ִ� �� ���̺��� �⺻Ű�� �ܷ�Ű�� ����ϴ� ���̺�)
        purchase_id(PK) / cid(FK) / costomer_id(FK) / purchase_qty / receipt_id(FK)
        1                 1         3                 3              1
        2                 2         3                 1              1
        
        - �մ� ���� ���̺�
        customer_id / customer_name / point
        1             Kim             1033
        2             Lee             202
        3             Park            500
        
        # N:N�� �ϳ��� ���̺�� ���ļ� �ذ��ϴ� ���(������ ���� ������ ����� ���� ó�� �ӵ�)
        
        pid / cid / cname    / price / purchase_qty / purchase_date / customer_id / customer_name / point
        1     1     Americano  1000    1              24/06/06        4             Minsu           300
        2     1     Americano  1000    3              24/06/07        4             Minsu           330
*/

-- ����1 : �ٴ�� ���踦 �ϳ� �����ϰ�, ���̺�� �÷��� �����غ�����.
-- �ǻ�� ȯ��

/*
    å ����
    ISBN(PK) / page / title / author / period
    
    å
    book_id(PK) / ISBN(FK) / book_state / 
    
    �뿩
    rent_id / book_id(FK) / member_id(FK) / rent_date / 
    
    ȸ��
    member_id(PK) / phone_number / email / social number / 
*/

-- ����2 : DB�� ������ ���̺��� �����غ�����.
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
    rent_date DATE default sysdate, -- sysdate : ���� �ð�
    return_date DATE
);

-- ����3 : ������ ���̺� �����͸� �߰��غ�����.
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (1234567890, '����ƻ꺴��', '����Ƽ������', '�迵��');
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (2345678901, '�Ѿ���б���������', '��������', '������');
INSERT INTO doctors (doctor_id, hospital, subject, doctor_name) VALUES (3456789012, '�ູ�ѿ����������а��ǿ�', '�������а�', '������');

SELECT * FROM doctors;

INSERT INTO book(book_id, ISBN, book_state) VALUES(1, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(2, '979-11-7171-167-3', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(3, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(4, '979-11-7171-193-2', 'E');
INSERT INTO book(book_id, ISBN, book_state) VALUES(5, '979-11-7171-167-3', 'E');
COMMIT;

INSERT INTO library_member(member_id, member_name, phone_number) VALUES(1, '��ö��', '010-1234-1234');
INSERT INTO library_member(member_id, member_name, phone_number) VALUES(2, '��ö��', '010-1111-2222');
INSERT INTO library_member(member_id, member_name, phone_number) VALUES(3, '��ö��', '010-3333-4444');

INSERT INTO book_rental(rent_id, book_id, member_id, rent_date) VALUES(1, 1, 3, '2011/05/20');
INSERT INTO book_rental(rent_id, book_id, member_id) VALUES(1, 2, 3);
INSERT INTO book_rental(rent_id, book_id, member_id, rent_date, return_date) VALUES(1, 2, 3, '2014/09/09', '2018/03/01');

SELECT * FROM book;
SELECT * FROM library_member;
SELECT * FROM book_rental;

-- ����4 : ��� �����͵��� JOIN�Ͽ� ���ϴ� �����͸� ��ȸ�غ�����.
SELECT member_name, ISBN, rent_date FROM book_rental INNER JOIN library_member USING (member_id) INNER JOIN book USING (book_id)
WHERE return_date IS NULL;

-- ����5 : book_info ���̺��� ���� ���� ISBN ��� å �̸��� ������ ��������.
CREATE TABLE book_info (
    ISBN CHAR(17),
    total_page NUMBER(3),
    title VARCHAR2(50),
    author CHAR(12),
    rental_period NUMBER(5)
);

INSERT INTO book_info(ISBN, total_page, title, author, rental_period) VALUES('979-11-7171-193-2', 245, '������ Ǫ�ٿ� ����', '�ۿ���', 14);

SELECT member_name, title, rent_date FROM book_rental INNER JOIN library_member USING (member_id) INNER JOIN book USING (book_id)
INNER JOIN book_info USING (ISBN) WHERE return_date IS NULL;